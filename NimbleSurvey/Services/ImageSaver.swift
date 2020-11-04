//
//  ImageSaver.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/4/20.
//

import UIKit
import Foundation

struct ImageSaver {
    
    static func saveImageToDisk(_ image: UIImage, identifier: String!) {
        if let data = image.pngData() {
            let writePath = getDocumentsDirectory() + ("/nimble_survey_\(identifier!).png")
            do {
                try data.write(to: URL(fileURLWithPath: writePath), options: [.atomic])
            } catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
            }
        }
    }
    
    static func readImageFromDisk(_ imageIdentifier: String?) -> UIImage? {
        guard let identifier = imageIdentifier else { return nil }
        let readPath = getDocumentsDirectory() + ("/nimble_survey_\(identifier).png")
        let image    = UIImage(contentsOfFile: readPath)
        return image
    }
    
    // MARK: - Private Methods
    
    fileprivate static func getDocumentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    
}
