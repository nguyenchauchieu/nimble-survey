//
//  CurvedTextField.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 10/31/20.
//

import UIKit

class CurvedTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        let placeHolderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        self.attributedPlaceholder =
            NSAttributedString(string: self.placeholder ?? "",
                               attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])

    }
    
}
