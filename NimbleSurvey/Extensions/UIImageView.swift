//
//  UIImageView.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/3/20.
//

import UIKit
extension UIImageView {
    func load(urlString: String) {
        let imageId = urlString.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: ".", with: "")
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            ImageSaver.saveImageToDisk(image, identifier: imageId)
                        }
                    }
                } else {
                    if let image = ImageSaver.readImageFromDisk(imageId) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        } else {
            if let image = ImageSaver.readImageFromDisk(imageId) {
                self.image = image
            }
        }
        
    }
}
