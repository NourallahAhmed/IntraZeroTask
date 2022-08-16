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

    @State private var Xmovement = 50
    @State private var Ymovement = 50
    
    let colors : [Color] = [  .blue , .green , .red , .purple  ]
    @State var activeColorIndex = 0

    let colorSwitchTimer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    var body : some View {
        
        if isActive{
            
            PhotoListView()
        }
        else{
        VStack{
                Image(systemName: "camera.fill")
                    .font(.system(size: 100))
                    .foregroundColor(colors[activeColorIndex])
                    .onReceive(colorSwitchTimer) { _ in
                        self.activeColorIndex  += 1
                    }
                    .onAppear{
                        withAnimation(.easeIn(duration:0.2)){
                            self.movement += 150
                        }
                    }
                    .offset(x: 0 , y:  CGFloat(movement))
                                  
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
           
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
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
