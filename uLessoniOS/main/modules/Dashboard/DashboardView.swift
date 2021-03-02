//
//  DashboardView.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 28/02/2021.
//

import UIKit

class DashboardView: UIView {
    
    var collectionViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Simbi"
        label.font = UIFont.of(type: Font.Itim.regular.rawValue, size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let handLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hand_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let curveLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "curve_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionViewHeightConstraint?.isActive = true
        return collectionView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(collectionView)
        return stackView
    }()
    

    func updateCollectionViewHeight(byCount: Int) {
        let heightConstant = CGFloat(88)
        if byCount == 2 || byCount == 1 {
            collectionViewHeightConstraint?.constant = heightConstant
        }else if byCount == 4 {
            collectionViewHeightConstraint?.constant = heightConstant * 2
        } else if byCount > 4 {
            collectionViewHeightConstraint?.constant = heightConstant * 3
        }else {
            collectionViewHeightConstraint?.constant = 0
        }
    }
    
    
    private func setupView(){
        self.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.933, alpha: 1)
        addSubview(handLogoImageView)
        addSubview(curveLogoImageView)
        addSubview(scrollView)
        addSubview(helloLabel)
        
        scrollView.addSubview(self.stackView)
        
        handLogoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        handLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        curveLogoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        curveLogoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        helloLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        helloLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        helloLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: self.helloLabel.bottomAnchor, constant: 20).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
    }
    
}
