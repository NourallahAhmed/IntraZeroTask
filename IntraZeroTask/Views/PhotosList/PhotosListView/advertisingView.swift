//
//  advertisingView.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import SwiftUI

struct advertisingView: View {
        let images = ["macAD" ,"papajohnsAd" , "cocacolaAD"  ]
        @State var activeImageIndex = 0

        let imageSwitchTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

        var body : some View{
            VStack{
                Image(images[activeImageIndex])
                .resizable()
                .frame(width: 400, height: 200)
                .cornerRadius(20)
                .padding()
                .onReceive(imageSwitchTimer) { _ in
                    self.activeImageIndex = (self.activeImageIndex + 1) % self.images.count
                }

            }
        }

        
    }


struct advertisingView_Previews: PreviewProvider {
    static var previews: some View {
        advertisingView()
    }
}
