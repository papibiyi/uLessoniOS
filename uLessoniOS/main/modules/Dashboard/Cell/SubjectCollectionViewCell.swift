//
//  SubjectCollectionViewCell.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellTitle: UILabel = {
        let label = UILabel()
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

    
    private func setupView(){
        
    }
}
