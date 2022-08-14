//
//  PhotosDetails.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI
import Kingfisher
//import UIImageColors
//import swift_vibrant

import ColorKit
struct PhotosDetails: View {

    var url : String
    @State var backgroundColor2 : UIColor?
    @State var image : UIImage?
    let image2 = UIImage(named: "test")

    var done = false
    init(url : String) {
        self.url = url
        if self.url != "" {
            self.image =
            UIImage(data:NSData(contentsOf: NSURL(string: self.url)! as URL)! as Data)

//            guard let image = self.image else {
//                return
//            }
//            guard let colors = try! self.image2?.dominantColors() else{
//                print("Error")
//                return
//            }
//            guard let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) else {
//                print("fatalError")
//                fatalError("Could not create palette")
//            }
//            self.backgroundColor2 = palette.background
            

        }
    }
    var body: some View {
        VStack{
            Spacer()
            
            KFImage(URL(string: url))
                .loadImmediately()
                .placeholder { Image("default") }
                .resizable()
                .frame(width: 400, height: 400)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding()
                
            Spacer()
        }
        .background(Color(backgroundColor2 ?? .white))
    }
}

struct PhotosDetails_Previews: PreviewProvider {
    static var previews: some View {
        PhotosDetails(url: "")//, backgroundColor: .black)
    }
}



extension UIImage {
    var averageColor: UIColor? {
        
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
//        print("Color")
//        print(UIColor(red: CGFloat(bitmap[0])  / 255, green: CGFloat(bitmap[0])  / 255, blue: CGFloat(bitmap[0])  / 255, alpha: CGFloat(bitmap[0]) / 255  ).description)
//

        return(UIColor(red: CGFloat(bitmap[0])  / 255, green: CGFloat(bitmap[1])  / 255, blue: CGFloat(bitmap[2])  / 255, alpha: CGFloat(bitmap[3]) / 255  ))
    }
}
