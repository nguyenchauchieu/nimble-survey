//
//  HomeViewController.swift
//  NimbleSurvey
//
//  Created by Nguyen Chau Chieu on 11/3/20.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var surveysCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    var activityIndicatorView: NVActivityIndicatorView!
    var surveys = [Survey]()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshControllPulled(_:)), for: .valueChanged)
        surveysCollectionView.refreshControl = refreshControl
        surveysCollectionView.delegate = self
        surveysCollectionView.dataSource = self
        setupIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchSurveyList()
    }
    
    private func setupIndicatorView() {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20),
                                                        type: .ballRotateChase,
                                                        color: .white)
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
    }
    
    private func fetchSurveyList() {

        activityIndicatorView.startAnimating()
        let surveyService = SurveyService()
        surveyService.getSurveys { [weak self] (surveys) in
            self?.surveys = surveys
            self?.surveysCollectionView.reloadData()
            self?.activityIndicatorView.stopAnimating()
        } failure: { [weak self] (errors) in
            self?.activityIndicatorView.stopAnimating()
            let banner = GrowingNotificationBanner(title: Constants.Contents.Banner.genericTitle,
                                                   subtitle: errors?.getErrorsString(),
                                                   style: .info,
                                                   colors: CustomBannerColors())
            banner.show()
        }

    }
    
    @objc func refreshControllPulled(_ sender: Any) {
        fetchSurveyList()
        refreshControl.endRefreshing()
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = surveysCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCellsId.surveyCell,
                                                             for: indexPath) as! SurveyCollectionViewCell
        cell.survey = surveys[indexPath.row]
        cell.setupSurvey()
        cell.pageControl.numberOfPages = surveys.count
        cell.pageControl.currentPage = indexPath.row
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: surveysCollectionView.frame.size.width, height: surveysCollectionView.frame.size.height)
    }
}
