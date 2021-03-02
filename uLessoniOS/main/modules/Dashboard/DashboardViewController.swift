//
//  DashboardViewController.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 28/02/2021.
//

import UIKit

class DashboardViewController: CustomViewController<DashboardView> {
    
    lazy var viewModel = DashboardViewModel(delegate: self, webService: DashboardWebService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupScrollView()
    }
    
    private func setupScrollView(){
        self.contentView.scrollView.refreshControl?.beginRefreshing()
        self.contentView.onScrollViewRefreshed = {[weak self] in
            self?.viewModel.getSubjects()
        }
    }
    
    private func setupCollectionView(){
        self.contentView.collectionView.delegate = self
        self.contentView.collectionView.dataSource = self
    }
}

extension DashboardViewController: DataFetchedDelegate {
    func onDataFetched() {
        DispatchQueue.main.async {
            self.contentView.scrollView.refreshControl?.endRefreshing()
            self.contentView.collectionView.reloadData()
            self.contentView.updateCollectionViewHeight(byCount: self.viewModel.subjects.count)
        }
    }
    
    func onFetchError(error: Error) {
        DispatchQueue.main.async {[weak self] in
            self?.contentView.scrollView.refreshControl?.endRefreshing()
            self?.showAlert(title: "Oops! An error has occured", message: error.localizedDescription)
        }
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubjectCollectionViewCell.id, for: indexPath) as? SubjectCollectionViewCell
        cell?.configureCell(with: self.viewModel.subjects[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((Int(self.contentView.collectionView.frame.width - 10) / 2)), height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subject = self.viewModel.subjects[indexPath.row]
        self.navigationController?.pushViewController(SubjectViewController(subject: subject), animated: true)
    }
}
