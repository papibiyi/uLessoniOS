//
//  RecentlyWatchedCollectionViewCell.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 03/03/2021.
//

import UIKit

class RecentlyWatchedCollectionViewCell: UICollectionViewCell {
    static let id = "\(RecentlyWatchedCollectionViewCell.self)"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellBackgroundImageView.image = nil
    }
    
    func configureCell(with data: RecentlyWatchedDataModel) {
        let resolver = SubjectDataResolver.resolve(name: data.subjectName ?? "")
        cellTitle.textColor = UIColor(named: resolver.color)
        cellTitle.text = data.subjectName
        cellSubTitle.text = data.lesson.name
        playIcon.image = playIcon.image?.withRenderingMode(.alwaysTemplate)
        playIcon.tintColor = UIColor(named: resolver.color)
        
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: data.lesson.icon ?? "") else {return}
            guard let data = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.cellBackgroundImageView.image = UIImage(data: data)
            }
        }
    }
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.of(type: Font.Mulish.semiBold.rawValue, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellSubTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var podIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pod_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(playIcon)
        playIcon.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        playIcon.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        return imageView
    }()
    
    private let playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "play_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 13
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    
    private func setupView(){
        self.contentView.layer.masksToBounds = true
        self.contentView.addSubview(cellBackgroundImageView)
        self.contentView.addSubview(podIcon)
        self.contentView.addSubview(cellTitle)
        self.contentView.addSubview(cellSubTitle)
        
        cellBackgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellBackgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellBackgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        podIcon.centerXAnchor.constraint(equalTo: cellBackgroundImageView.centerXAnchor).isActive = true
        podIcon.centerYAnchor.constraint(equalTo: cellBackgroundImageView.centerYAnchor).isActive = true


        cellTitle.centerYAnchor.constraint(equalTo: cellBackgroundImageView.centerYAnchor, constant: -20).isActive = true
        cellTitle.leftAnchor.constraint(equalTo: cellBackgroundImageView.rightAnchor, constant: 12).isActive = true
        cellTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        cellSubTitle.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 10).isActive = true
        cellSubTitle.leftAnchor.constraint(equalTo: cellBackgroundImageView.rightAnchor, constant: 12).isActive = true
        cellSubTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true

    }
}
