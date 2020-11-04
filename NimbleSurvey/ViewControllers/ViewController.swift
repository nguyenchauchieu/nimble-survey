//
//  ViewController.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 10/30/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backgroundOverlayImageView: UIImageView!
    
    @IBOutlet weak var nimbleLogoImageView: UIImageView!
    @IBOutlet weak var nimbleLogoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nimbleLogoVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var nimbleLogoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginFormStackView: UIStackView!
    @IBOutlet weak var emailTextField: CurvedTextField!
    @IBOutlet weak var passwordTextField: CurvedTextField!
    @IBOutlet weak var loginButton: CurvedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNimbleLogo()
        hideBackgroundOverlay()
        hideLoginFormStackView()
        setupEmailTextField()
        if let savedData = UserDefaults.standard.object(forKey: "loggedUserInfo") as? Data, let loggedUserInfo = try? JSONDecoder.init().decode(LoggedUserInfo.self, from: savedData) {
            NotificationCenter.default.post(name: Constants.NimbleSurveyNotifications.LoginDone, object: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        showNimbleLogo(animated: true)
    }
    
    private func setupEmailTextField() {
        let passwordTextFieldRightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        passwordTextFieldRightButton.setTitle(Constants.Contents.Buttons.forgotPassword, for: .normal)
        passwordTextFieldRightButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        passwordTextFieldRightButton.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3), for: .normal)
        passwordTextFieldRightButton.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6), for: .highlighted)
        passwordTextFieldRightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        passwordTextFieldRightButton.addTarget(self, action: #selector(forgotPasswordButtonTouchUpInside(_:)), for: .touchUpInside)
        passwordTextField.rightView = passwordTextFieldRightButton
        passwordTextField.rightViewMode = .always
    }
    
    private func showNimbleLogo(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 1, delay: 0, options: []) { [weak self] in
                self?.nimbleLogoImageView.alpha = 1.0
            } completion: {_ in
                self.showBackgroundOverlay(animated: true)
                self.showLoginFormStackView(animated: true)
                self.nimbleLogoWidthConstraint.constant = 32
                
                self.nimbleLogoVerticalCenterConstraint.priority = UILayoutPriority(rawValue: 750)
                self.nimbleLogoTopConstraint.priority = UILayoutPriority(rawValue: 1000)
                self.nimbleLogoVerticalCenterConstraint.constant = 120
                UIView.animate(withDuration: 0.6) {
                    self.view.layoutIfNeeded()
                }
            }
        } else {
            nimbleLogoImageView.alpha = 1.0
            self.showBackgroundOverlay(animated: false)
            self.showLoginFormStackView(animated: false)
            self.nimbleLogoWidthConstraint.constant = 32
            self.nimbleLogoVerticalCenterConstraint.priority = UILayoutPriority(rawValue: 750)
            self.nimbleLogoTopConstraint.priority = UILayoutPriority(rawValue: 1000)
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideNimbleLogo() {
        nimbleLogoImageView.alpha = 0.0
    }
    
    private func showBackgroundOverlay(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.4) {
                self.backgroundOverlayImageView.alpha = 1.0
            }
        } else {
            backgroundOverlayImageView.alpha = 1.0
        }
    }
    
    private func hideBackgroundOverlay() {
        backgroundOverlayImageView.alpha = 0.0
    }
    
    private func showLoginFormStackView(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.loginFormStackView.alpha = 1.0
            }
        } else {
            loginFormStackView.alpha = 1.0
        }
    }
    
    private func hideLoginFormStackView() {
        loginFormStackView.alpha = 0.0
    }
    
    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        APIClient.shared.login(email: emailText, password: passwordText) { (loggedUserInfo) in
            if loggedUserInfo != nil {
                NotificationCenter.default.post(name: Constants.NimbleSurveyNotifications.LoginDone, object: nil)
            }
        } failure: { (errorMessage) in
            print(errorMessage?["message"])
        }
    }
    
    @objc private func forgotPasswordButtonTouchUpInside(_ sender: Any) {
        let loginStoryboard = UIStoryboard.init(name: Constants.Storyboards.login, bundle: nil)
        let resetPasswordVC = loginStoryboard.instantiateViewController(identifier: Constants.ViewControllers.resetPassword) as! ResetPasswordViewController
        self.present(resetPasswordVC, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

