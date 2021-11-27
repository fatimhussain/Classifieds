//
//  UIImageViewExtension.swift
//  Classifieds
//
//  Created by Fatima on 27/11/2021.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?, placeHolderImage: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        //load the image using AlamofireImage
        af.setImage(withURL: url, placeholderImage: placeHolderImage, completion:  { [weak self] image in
            
            DispatchQueue.main.async {
                if let imageData = image.data {
                    self?.image = UIImage(data: imageData)
                }
            }
        })
    }
}

