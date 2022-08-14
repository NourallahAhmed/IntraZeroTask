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
    @FetchRequest(entity: Photos.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \Photos.id, ascending: true)])
    private var localPhotos : FetchedResults <Photos>
    
    
    @StateObject private var photoListViewModel =  PhotosListViewModel()
    
    @State private  var counter  = 0
    @State private  var selectedPhotoUrl : String?
    @State private var navigationToggle : Bool = false
    @State private var next = false
    @State private var Page = 1
    @State private var isChangePage : Bool = false
    var body: some View {
        NavigationView {
            VStack{
                if self.photoListViewModel.photosList.count > 0 {
                    Text("Welcome")
                        .bold()
                        .font(Font.custom("MyFont", size: 40))
                        .foregroundColor(Color.red)
                    if isChangePage == false {
                        ScrollView{
                            
                            ForEach(self.photoListViewModel.photosList, id: \.self) { photo in
                                if counter != 5 {
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
                                                print("clicked")
                                                self.selectedPhotoUrl = photo.downloadUrl
                                                self.navigationToggle.toggle()
                                                print(navigationToggle)
                                            }
                                        Spacer()
                                        Text("Auther : \(photo.author)")
                                            .foregroundColor(Color.red)
                                            .bold()
                                            .padding()
                                        Spacer()
                                    }.onAppear{
                                        counter += 1
                                    }
                                    
                                }
                                
                                if counter == 5 {
                                    VStack{
                                        Spacer()
                                        Image("default")
                                        
                                            .frame(width: 300, height: 200)
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                        
                                        Spacer()
                                        Text("Ad PlaceHolder")
                                            .bold()
                                            .padding()
                                        Spacer()
                                    }.onAppear{
                                        counter = 0
                                    }
                                    
                                }
                            }
                            
                        }.onAppear{
                            //Save into CoreData for Offline Storage
                            var photos = Photos(context: managedObjectContext)
                            self.photoListViewModel.photosList.map { photo in
                                photos.id = photo.id
                                photos.url = photo.url
                                photos.downloadUrl = photo.downloadUrl
                                photos.auther = photo.author
                                photos.width = photo.width
                                photos.height = photo.height
                                print(photos.id)
                                PersistenceController.shared.save()
                            }
                            
                            
                        }
                        
                    }
                    else{
                        //MARK: Display loading for the next page
                        ProgressView()
                        Text("Loading...")
                            .font(Font.custom("MyFont", size: 30))
                        
                    }
                    
                    
                    
                
            
                //MARK: Handling the pages
                HStack{
                    if Page > 1 {
                        Button("Previous"){
                            if Page != 1 {
                                self.Page -= 1
                                //TODO: Send to vm to change the page
                                self.photoListViewModel.changePage(page: String(self.Page))
//                                self.isChangePage.toggle()
                            }
                        }
                    }
                    Spacer()
                    Text("Page \(Page)")
                    Spacer()
                    Button("Next"){
                        self.Page += 1
                        //TODO: Send to vm to change the page
                        self.photoListViewModel.changePage(page:String(self.Page))
//                        self.isChangePage.toggle()

                        
                    }
                }
            
            }
            
            else{
                
                //MARK: If there is no local data stored .. display the loading from network

                if self.localPhotos.isEmpty {
                    ProgressView()
                    Text("Loading")
                        .font(Font.custom("MyFont", size: 30))
                }

                //MARK: Show Local Photos
                else{
                    Text("From Local Photos")
                        .bold()
                        .font(Font.custom("MyFont", size: 40))
                        .foregroundColor(Color.red)
                    
                    ForEach(self.localPhotos, id: \.self) { photo in
                        if counter != 5 {
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
                            }.onAppear{
                                counter += 1
                            }
                            
                        }
                    }
                }
            }
            
            //MARK: Navigation
            NavigationLink( "" , destination: PhotosDetails(url: self.selectedPhotoUrl ?? "" ),isActive: self.$navigationToggle)
            Spacer()
            
            
        }.onAppear{
            //MARK: get the data from network
            self.photoListViewModel.changePage(page: String(self.Page))
            print("Pressed Next")
            if Page > 0 {
                self.next = true
            }
        }
    }
    
    
    
}

}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}


//extension String {
//    func load() -> UIImage{
//        do{
//
//            guard let url = URL(string: self) else{
//                return UIImage()
//            }
//
//            let data : Data = try
//            Data(contentsOf: url)
//
//            return UIImage(data: data) ?? UIImage()
//
//        }
//        catch{
//
//        }
//        return UIImage()
//    }
//}



//MARK: consume network
//                            VStack(alignment:.leading){
//                                AsyncImage(url: URL(string: photo.downloadUrl)!)
//                                    .frame(width: 128, height: 128)
//                                    .cornerRadius(20)
//                                    .shadow(radius: 5)
//                            }
//                                    Image(uiImage: photo.downloadUrl.load())
//                                        .frame(width: 50 , height: 50)
//                                        .cornerRadius(20)
//                                        .shadow(radius: 5)
//
//MARK: Kingfisher slow down the data loading

//                                    KFImage(URL(string:   photo.downloadUrl))
//                                        .loadImmediately()
//                                        .placeholder { Image("default") }
//                                        .resizable()
//                                        .frame(width: 128, height: 128)
//                                        .cornerRadius(20)
//                                        .shadow(radius: 5)

//                                        .padding().onTapGesture {
//                                            self.image =
//
//                                            UIImage(data:NSData(contentsOf: NSURL(string: photo.downloadUrl)! as URL)! as Data)
//                                            self.backgroundColor = image?.averageColor ?? .black
//                                            print(self.backgroundColor)
//                                        }

