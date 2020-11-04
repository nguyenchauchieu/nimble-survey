//
//  CurvedButton.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 10/31/20.
//

import UIKit

class CurvedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        curveTheButton(radius: 10)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        curveTheButton(radius: 10)
    }
    
    private func curveTheButton(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
