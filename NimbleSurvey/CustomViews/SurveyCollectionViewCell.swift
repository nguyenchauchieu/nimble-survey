//
//  SurveyCollectionViewCell.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/3/20.
//

import UIKit

class SurveyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var surveyImageView: UIImageView!
    @IBOutlet weak var surveyTitleLabel: UILabel!
    @IBOutlet weak var surveyDescriptionLabel: UILabel!
    
    var survey: Survey?
    
    func setupSurvey() {
        guard let survey = survey else {return}
        surveyImageView.load(urlString: survey.imageUrl)
        surveyTitleLabel.text = survey.title
        surveyDescriptionLabel.text = survey.description
    }
}
