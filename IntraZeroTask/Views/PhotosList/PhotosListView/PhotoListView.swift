//
//  PhotoListView.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI
import Kingfisher
struct PhotoListView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var  managedObjectContext
    @StateObject var photoListViewModel =  PhotosListViewModel()
    @State var backgroundColor : UIColor?
    @State var image : UIImage?
    @State var counter  = 0
    @State var selectedPhotoUrl : String?
    @State var navigationToggle : Bool = false
    @State var next = false
    @State var Page = 1
    var body: some View {
        NavigationView {
            
            VStack{
                
                if self.photoListViewModel.photosList.count > 0 {
                    Text("Welcome")
                    ScrollView{
                        
                        ForEach(self.photoListViewModel.photosList , id: \.self) { photo in
                        
                            HStack{
                                Spacer()
                                    KFImage(URL(string:   photo.downloadUrl))
                                        .loadImmediately()
                                        .placeholder { Image("default") }
                                        .resizable()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
                                        .onTapGesture {
                                            print("clicked")
                                            self.selectedPhotoUrl = photo.downloadUrl
                                            self.navigationToggle.toggle()
                                        }
                                Spacer()
                                Text(photo.author)
                                    .bold()
                                    .padding()
                                Spacer()
                            }
                                
                            }
                        
                    }
                    //Handling the pages
                    HStack{
                        if Page > 1 {
                            Button("Previous"){
                                if Page != 0 {
                                    self.Page -= 1
                                    //Send to vm to change the page
                                    self.photoListViewModel.changePage(page: String(self.Page))
                                }
                            }
                        }
                        
                        Spacer()
                        Button("Next"){
                            self.Page += 1
                            //Send to vm to change the page
                            self.photoListViewModel.changePage(page:String(self.Page))

                        }
                    }
                }
                else{
                    ProgressView()
                    Text("Loading")
                    
                }
                NavigationLink( "" , destination: PhotosDetails(url: self.selectedPhotoUrl ?? "" ),isActive: self.$navigationToggle)
            }.onAppear{
                self.photoListViewModel.getPhotosList()
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

