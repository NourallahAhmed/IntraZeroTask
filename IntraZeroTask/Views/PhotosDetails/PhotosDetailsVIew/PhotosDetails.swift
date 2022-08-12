//
//  PhotosDetails.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI
import Kingfisher


struct PhotosDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var url : String
    var backgroundColor : UIColor
    //@State var image : UIImage?
    var body: some View {
        HStack{
        KFImage(URL(string:   url))
            
            .loadImmediately()
            .placeholder { Image("default") }
            .resizable()
            
            .frame(width: 300, height: 300)
            
            .cornerRadius(20)
            .shadow(radius: 5)
           
//            .swipeActions(edge: .trailing) {
//                Button(role: .destructive) {
//                    self.presentationMode.wrappedValue.dismiss()
//                    print("Action")
//                } label: {
//
//                }
//            }
            .padding()
        }.onAppear{
//            self.image =
//            
//            UIImage(data:NSData(contentsOf: NSURL(string: self.url)! as URL)! as Data)
//            self.backgroundColor = image?.averageColor
        }
        .foregroundColor( Color(self.backgroundColor ?? .white) )
        
    }
}

struct PhotosDetails_Previews: PreviewProvider {
    static var previews: some View {
        PhotosDetails(url: "", backgroundColor: .black)
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

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
