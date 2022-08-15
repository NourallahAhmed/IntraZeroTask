//
//  PhotosDetailsViewModek.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import UIKit
import UIImageColors 
class PhotosDetailsViewModel : ObservableObject {
    @Published var backgroundColor : UIColor?
    private var imageData : Data?
    static var shared = PhotosDetailsViewModel()
    func getBackgoundColor(url : String){
        self.backgroundColor = .white
        DispatchQueue.global(qos: .userInteractive).async {
            let imageData2 = NSData(contentsOf: NSURL(string: url )! as URL)! as Data
            DispatchQueue.main.async {
                self.imageData = imageData2
                let image = UIImage(data: self.imageData!)
                self.backgroundColor = image?.getColors()?.primary
            }
        }
        
    }
}
