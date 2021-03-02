//
//  SubjectCollectionViewCell.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    static let id = "\(SubjectCollectionViewCell.self)"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
        let resolver = SubjectDataResolver.resolve(name: subject.name ?? "")
        cellTitle.text = subject.name
        cellIconImageView.image = UIImage(named: resolver.icon)
        cellBackgroundImageView.image = UIImage(named: resolver.image)
        contentView.backgroundColor =  UIColor(named: resolver.color)
    }
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 13
        self.contentView.addSubview(cellBackgroundImageView)
        self.contentView.addSubview(cellIconImageView)
        self.contentView.addSubview(cellTitle)
        
        cellBackgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellBackgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellBackgroundImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        cellBackgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        
        cellIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        cellIconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true

        cellTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        cellTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        cellTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }
}
