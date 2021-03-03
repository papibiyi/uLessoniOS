//
//  ChapterContainerView.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import UIKit

class ChapterContainerView: UIView {
    var lessons: [Lesson] = []
    var onLessonSelected: (((lesson: Lesson, chapterTitle: String)) -> ())? = nil
    
    init(name: String, lessons: [Lesson]) {
        super.init(frame: .zero)
        setupView()
        self.chapterTitleLabel.text = name
        self.inject(data: lessons)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.of(type: Font.Itim.regular.rawValue, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChapterCollectionViewCell.self, forCellWithReuseIdentifier: ChapterCollectionViewCell.id)
        return collectionView
    }()
    
    func inject(data: [Lesson]) {
        self.lessons = data
        self.isHidden = data.isEmpty ? true : false
        self.collectionView.reloadData()
    }

    private func setupView(){
        addSubview(chapterTitleLabel)
        addSubview(collectionView)
        
        chapterTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        chapterTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 27).isActive = true
        chapterTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.chapterTitleLabel.bottomAnchor, constant: 12).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 27).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}

extension ChapterContainerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChapterCollectionViewCell.id, for: indexPath) as? ChapterCollectionViewCell
        cell?.configureCell(with: lessons[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lesson = lessons[indexPath.row]
        onLessonSelected?((lesson, chapterTitleLabel.text ?? ""))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 161, height: 160)
    }
}
