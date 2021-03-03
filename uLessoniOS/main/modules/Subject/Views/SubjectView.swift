//
//  SubjectView.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import UIKit

class SubjectView: UIView {
    var onLessonSelected: (((lesson: Lesson, chapterTitle: String)) -> ())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.of(type: Font.Mulish.bold.rawValue, size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "back_arrow_black")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func addChapters(chapters: [Chapter]) {
        for chapter in chapters {
            let chapterContainer = ChapterContainerView(name: chapter.name ?? "", lessons: chapter.lessons ?? [])
            chapterContainer.tag = chapter.id ?? 0
            chapterContainer.onLessonSelected = { lesson in
                self.onLessonSelected?(lesson)
            }
            stackView.addArrangedSubview(chapterContainer)
        }
    }
    
    private func setupView(){
        self.backgroundColor = UIColor(named: "uBackground")
        addSubview(backArrow)
        addSubview(pageTitleLabel)
        addSubview(scrollView)
        scrollView.addSubview(self.stackView)
        
        backArrow.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        backArrow.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        pageTitleLabel.centerYAnchor.constraint(equalTo: self.backArrow.centerYAnchor).isActive = true
        pageTitleLabel.leftAnchor.constraint(equalTo: self.backArrow.rightAnchor, constant: 16).isActive = true
        pageTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true

        scrollView.topAnchor.constraint(equalTo: self.pageTitleLabel.bottomAnchor, constant: 26).isActive = true
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

