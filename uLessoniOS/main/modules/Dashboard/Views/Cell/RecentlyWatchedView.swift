//
//  RecentlyWatchedView.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 03/03/2021.
//

import UIKit

class RecentlyWatchedView: UIView {
    var collectionViewHeightConstraint: NSLayoutConstraint?
    var onRecentlyWatchedSelected: ((RecentlyWatchedDataModel) -> ())? = nil
    var data: [RecentlyWatchedDataModel] = []
    var tempData: [RecentlyWatchedDataModel] = []
    var showMore = false
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(data: [RecentlyWatchedDataModel]) {
        self.data = data
        if data.count > 2 {
            showMore = true
            button.setTitle("Show More", for: .normal)
            tempData = []
            tempData.insert(data[1], at: 0)
            tempData.insert(data[0], at: 0)
        }else {
            showMore = false
            button.setTitle("Show Less", for: .normal)
            tempData = data
        }
        
        self.isHidden = tempData.isEmpty ? true : false
        collectionViewHeightConstraint?.constant = CGFloat(110 * tempData.count)
        self.collectionView.reloadData()
    }

    let recentlyWatchedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recently watched topics"
        label.font = UIFont.of(type: Font.Itim.regular.rawValue, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "buttonImage"), for: .normal)
        button.setTitle("SEE MORE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 12)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(RecentlyWatchedCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyWatchedCollectionViewCell.id)
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionViewHeightConstraint?.isActive = true
        return collectionView
    }()
    
    @objc func onButtonPressed() {
        if showMore {
            tempData = data
            button.setTitle("Show Less", for: .normal)
            showMore = false
        }else {
            showMore = true
            button.setTitle("Show More", for: .normal)
            tempData = []
            tempData.insert(data[1], at: 0)
            tempData.insert(data[0], at: 0)
        }
        collectionViewHeightConstraint?.constant = CGFloat(110 * tempData.count)
        collectionView.reloadData()
    }

    func setupButtonAction() {
        button.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)
    }

    private func setupView(){
        setupButtonAction()
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(recentlyWatchedLabel)
        addSubview(collectionView)
        addSubview(button)
        
        recentlyWatchedLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        recentlyWatchedLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        recentlyWatchedLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.recentlyWatchedLabel.bottomAnchor, constant: 12).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        button.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 16).isActive = true
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
    }
}


extension RecentlyWatchedView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyWatchedCollectionViewCell.id, for: indexPath) as? RecentlyWatchedCollectionViewCell
        cell?.configureCell(with: tempData[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onRecentlyWatchedSelected?(tempData[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 100)
    }
}
