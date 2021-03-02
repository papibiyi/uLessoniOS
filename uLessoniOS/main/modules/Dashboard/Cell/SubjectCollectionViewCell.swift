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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellIconImageView.image = nil
        cellBackgroundImageView.image = nil
    }
    
    func configureCell(with subject: Subject) {
        cellTitle.text = subject.name
    }
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    
    private func setupView(){
        self.contentView.addSubview(cellBackgroundImageView)
        self.contentView.addSubview(cellTitle)
        self.contentView.addSubview(cellIconImageView)
        
        cellBackgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellBackgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellBackgroundImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        cellBackgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        
        cellIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        cellIconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true

        cellTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        cellTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true

    }
}
