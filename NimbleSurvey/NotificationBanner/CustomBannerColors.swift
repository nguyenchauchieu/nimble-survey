//
//  CustomBannerColors.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/4/20.
//

import Foundation
import UIKit
import NotificationBannerSwift
class CustomBannerColors: BannerColorsProtocol {

    internal func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .info:
            return UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.6)
        case .danger:
            return UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.6)
        case .customView:
            return UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.6)
        case .success:
            return UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.6)
        case .warning:
            return UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.6)
        }
    }

}
