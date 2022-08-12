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
    
    var body: some View {
        NavigationView {
        VStack{
            
            if self.photoListViewModel.photosList.count > 0 {
                Text("Welcome")

                ScrollView{
                    ForEach(self.photoListViewModel.photosList) { photo in
                       
                        HStack{
                            Spacer()
//MARK: consume network
//                            VStack(alignment:.leading){
//                                AsyncImage(url: URL(string: photo.downloadUrl)!)
//                                    .frame(width: 128, height: 128)
//                                    .cornerRadius(20)
//                                    .shadow(radius: 5)
//                            }
                            
//MARK: Kingfisher slow down the data loading
                            
                            NavigationLink(destination:
                                            
                                            PhotosDetails(url: photo.downloadUrl, backgroundColor: self.backgroundColor ?? .black)
                                .navigationBarBackButtonHidden(true)
                                .transition(.move(edge: .bottom))){
                              
                                    KFImage(URL(string:   photo.downloadUrl))
                                        .loadImmediately()
                                        .placeholder { Image("default") }
                                        .resizable()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
//                                        .padding().onTapGesture {
//                                            self.image =
//
//                                            UIImage(data:NSData(contentsOf: NSURL(string: photo.downloadUrl)! as URL)! as Data)
//                                            self.backgroundColor = image?.averageColor ?? .black
//                                            print(self.backgroundColor)
//                                        }
                                    
                                }
                                
                            
                            Spacer()

                            Text(photo.author)
                                .bold()
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
            else{
                ProgressView()
                Text("Loading")

            }
        
        }.onAppear{
                self.photoListViewModel.getPhotosList()
        }
    }
    }
        
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
