//
//  PhotosDetails.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI
import Kingfisher
import UIImageColors
//import swift_vibrant

//import ColorKit
struct PhotosDetails: View {

    var url : String
    @StateObject private var PhotoDetailsViewModel = PhotosDetailsViewModel.shared
    @State private var backgroundColor2 : UIColor?
    @State private var backgroundColorHex : String?
    @State  private var  imageData : Data?

    @State var image : UIImage?
    init(url : String) {
        self.url = url
//        if self.url != "" {
//            self.PhotoDetailsViewModel.getBackgoundColor(url: url)
//        }
    }
    var body: some View {
        VStack{
            Spacer()
            if self.PhotoDetailsViewModel.loaded {
            KFImage(URL(string: url))
                .loadImmediately()
                .placeholder { Image("default") }
                .resizable()
                .frame(width: 400, height: 400)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding()
            }else{
                ProgressView()
            }
            Spacer()
        }
        .background(Color(self.PhotoDetailsViewModel.backgroundColor ?? .gray ))
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
        
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())

        let averageColor = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
        print(averageColor)
        return averageColor
    
    }
}
