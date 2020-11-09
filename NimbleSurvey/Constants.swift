//
//  Constants.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 10/31/20.
//

import Foundation

struct Constants {
    
    static let clienId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
    static let clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
    
    struct Storyboards {
        static let login = "Login"
        static let main = "Main"
    }
    struct ViewControllers {
        static let resetPassword = "ResetPasswordViewController"
        static let homeViewController = "HomeViewController"
    }
    
    struct Contents {
        struct Buttons {
            static let forgotPassword = "Forgot?"
        }
        struct Banner {
            static let genericTitle = "Something is wrong!"
            static let checkMailTitle = "Check your email."
            static let checkMailDescription = "We’ve email you instructions to reset your password."
        }
    }
    
    struct NimbleSurveyNotifications {
        static let LoginDone = NSNotification.Name(rawValue: "LoginDone")
    }
    
    struct CollectionViewCellsId {
        static let surveyCell = "surveyCollectionViewCell"
    }
    
    struct UserDefaultKeys {
        static let cachedSurveys = "cachedSurveys"
    }
    
    struct KeychainKeys {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
}
