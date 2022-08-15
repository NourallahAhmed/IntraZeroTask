//
//  PhotoListView.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI
import Kingfisher
struct PhotoListView: View {
    //MARK: CoreData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var  managedObjectContext
    @FetchRequest(entity: Photos.entity() ,
                  sortDescriptors: [NSSortDescriptor(keyPath: \Photos.id, ascending: true)])
                private var localPhotos : FetchedResults <Photos>
    @StateObject private var photoListViewModel =  PhotosListViewModel()
    @StateObject private var PhotoDetailsViewModel = PhotosDetailsViewModel.shared

    //MARK: InternetConnection
    @StateObject private var networkConnection = NetworkManager()
    
    @State private  var selectedPhotoUrl : String?
    @State private var navigationToggle : Bool = false
    @State private var next = false
    @State private var Page = 1
    @State private var isChangePage : Bool = false

    var body: some View {
        NavigationView {
            //MARK: there is internet Connection
            if self.networkConnection.NetworkState {
                VStack{
                    if self.photoListViewModel.photosList.count > 0  {
                        Text("Welcome")
                            .bold()
                            .font(Font.custom("MyFont", size: 20))
                            .foregroundColor(Color.blue)
                        if self.photoListViewModel.photoLoaded {
                            
                            ScrollView {
                                ForEach(self.photoListViewModel.photosListGrouped, id: \.self) { photosList in
                                    ForEach(photosList) { photo in
                                        VStack{
                                            Spacer()
                                            KFImage(URL(string:   photo.downloadUrl))
                                                .retry(maxCount: 5, interval: .seconds(5))
                                                .placeholder { Image("default") }
                                                .resizable()
                                                .frame(width: 300, height: 200)
                                                .cornerRadius(20)
                                                .shadow(radius: 5)
                                                .onTapGesture {
                                                    self.selectedPhotoUrl = photo.downloadUrl
                                                    self.navigationToggle.toggle()
                                                    print(navigationToggle)
                                                    self.PhotoDetailsViewModel.getBackgoundColor(url: photo.downloadUrl)

                                                }
                                               
                                            Spacer()
                                            Text("Auther : \(photo.author)")
                                                .foregroundColor(Color.black)
                                                .bold()
                                                .padding()
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                    VStack{
                                        Spacer()
                                        advertisingView()
                                        Spacer()
                                    }
                                }
                                
                            }.onAppear{
                                handlingCoreDataStuff()
                               
                                
                            }
                          
                        }
                        else {
                            VStack{
                                Spacer()
                                HStack{
                                    Text("Please wait until the new photos loaded    ")
                                        .font(Font.custom("MyFont", size: 20))
                                    ProgressView()
                                }
                                Spacer()
                            }
                        }
                        //MARK: Handling the pages
                        HStack{
                            if Page > 1 {
                                Button("Previous"){
                                    if Page != 1 {
                                        self.Page -= 1
                                        //TODO: Send to vm to change the page
                                        if networkConnection.NetworkState {
                                            self.photoListViewModel.changePage(page: String(self.Page))
                                        }
                                        
                                    }
                                }
                            }
                            Spacer()
                            Text("Page \(Page)")
                            Spacer()
                            Button("Next"){
                                self.Page += 1
                                //TODO: Send to vm to change the page
                                if networkConnection.NetworkState {
                                    self.photoListViewModel.changePage(page: String(self.Page))
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                    else{
                        ProgressView()
                        Text("Loading")
                        
                            .font(Font.custom("MyFont", size: 20))
                    }
                    //MARK: Navigation
                    NavigationLink( "" , destination: PhotosDetails(url: self.selectedPhotoUrl ?? "" ),isActive: self.$navigationToggle)
                    Spacer()
                }.onAppear{
                    //MARK: get the data from network
                    if self.photoListViewModel.photosList.isEmpty {
                        self.photoListViewModel.changePage(page: String(self.Page))
                    }

                }
            }
            
            //MARK: NO Internet Connection
            else{
                
                //MARK: Showing the Local Photos
                
                
                if self.localPhotos.isEmpty {
                    Text("Offline Mode")
                    Text("No Local Images")
                }
                else{
                    
                    VStack{
                        Text("From Local Photos")
                            .bold()
                            .font(Font.custom("MyFont", size: 20))
                            .foregroundColor(Color.red)
                        ScrollView{
                            ForEach(self.localPhotos, id: \.self) { photo in
                                VStack{
                                    Spacer()
                                    KFImage(URL(string:   photo.downloadUrl ?? ""))
                                        .retry(maxCount: 5, interval: .seconds(5))
                                        .placeholder { Image("default") }
                                        .resizable()
                                        .frame(width: 300, height: 200)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
                                        .onTapGesture {
                                            print("clicked")
                                            self.selectedPhotoUrl = photo.downloadUrl
                                            self.navigationToggle.toggle()
                                            print(navigationToggle)
                                        }
                                    Spacer()
                                    Text("Auther : \(photo.auther ?? " Unknown" )")
                                        .bold()
                                        .foregroundColor(Color.red)
                                        .padding()
                                    Spacer()
                                }
                            }
                        }
                        //MARK: Navigation
                        NavigationLink( "" , destination: PhotosDetails(url: self.selectedPhotoUrl ?? "" ),isActive: self.$navigationToggle)
                        Spacer()
                    }
                }
            }
        }
    }
    
    
    
    
    func handlingCoreDataStuff(){
        //TODO: Remove the Old data from coredata
        self.localPhotos.map { photo in
            managedObjectContext.delete(photo)
            PersistenceController.shared.save()
        }
        //TODO: Save into CoreData for Offline Storage
        self.photoListViewModel.photosList.map { photo in
            var photos = Photos(context: managedObjectContext)
            photos.id = photo.id
            photos.url = photo.url
            photos.downloadUrl = photo.downloadUrl
            photos.auther = photo.author
            photos.width = photo.width
            photos.height = photo.height
            PersistenceController.shared.save()
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}


extension Array {
    func dividedIntoGroups(of i: Int = 5) -> [[Element]] {
        var copy = self
        var res = [[Element]]()
        while copy.count > i {
            res.append( (0 ..< i).map { _ in copy.remove(at: 0) } )
        }
        res.append(copy)
        return res
    }
}


