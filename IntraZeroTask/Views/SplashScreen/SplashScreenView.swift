//
//  SplashScreenView.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import SwiftUI


struct SplachScreenView: View{
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var degree = 90.0
    @State private var movement = -155

    @State private var Xmovement = -300
    @State private var XXmovement = -320
    @State private var XXXmovement = -350
    

    var body : some View {
        
        if isActive{
            
            PhotoListView()
        }
        else{
        VStack{
            VStack{
                Image(systemName: "photo.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .onAppear{
                        withAnimation(.easeIn(duration:0.8)){
      
                            self.XXXmovement += 470

                        }
                    }
                    .offset(x: -18, y: CGFloat(XXXmovement))
                
                Image(systemName: "photo.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.red)
                    .onAppear{
                        withAnimation(.easeIn(duration:0.8)){
      
                            self.XXmovement += 250

                        }
                    }
                    .offset(x: 27 , y: CGFloat(XXmovement))
                
                Image(systemName: "photo.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.yellow)
                    .onAppear{
                        withAnimation(.easeIn(duration:0.8)){
      
                            self.Xmovement += 250

                        }
                    }
                    .offset(x: 10 , y: CGFloat(Xmovement))
                Image(systemName: "camera.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.black)
                    .onAppear{
                        withAnimation(.easeIn(duration:0.8)){
                            self.movement += 150

                        }
                        
                      
                    }
                    .offset(x: CGFloat(movement), y: 10)
                    
                
              
                Text("picsum.photos")
                    .font(Font.custom("Baskerville-Bold", size: 20))
                    .foregroundColor(.black.opacity(0.80))
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration:0.2)){
                    self.size
                    = 1.9
                    self.opacity = 1.0
                }
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ){
                self.isActive = true
            }
        }
        }
    }
}

struct SplachScreenView_Preview : PreviewProvider{
    static var previews: some View{
        SplachScreenView()
    }
}
