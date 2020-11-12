//
//  ResetPasswordViewController.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 10/31/20.
//

import UIKit
import NotificationBannerSwift

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: CurvedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetButtonTouchUpInside(_ sender: Any) {
        let emailText = emailTextField.text ?? ""
        APIClient.shared.forgotPassword(email: emailText) {
            let banner = GrowingNotificationBanner(title: Constants.Contents.Banner.checkMailTitle,
                                                   subtitle: Constants.Contents.Banner.checkMailDescription,
                                                   style: .info, colors: CustomBannerColors())
            banner.show()
        } failure: { (errors) in
            let banner = GrowingNotificationBanner(title: Constants.Contents.Banner.genericTitle,
                                                   subtitle: errors?.getErrorsString(), style: .info,
                                                   colors: CustomBannerColors())
            banner.show()
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
