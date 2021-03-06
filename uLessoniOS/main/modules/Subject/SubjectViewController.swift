//
//  SubjectViewController.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import UIKit

class SubjectViewController: CustomViewController<SubjectView> {
    var subject: Subject
    
    init(subject: Subject) {
        self.subject = subject
        super.init(nibName: nil, bundle: nil)
        setupBackArrowAction()
        onLessonSelected()
        self.contentView.pageTitleLabel.text = subject.name
        self.contentView.addChapters(chapters: subject.chapters ?? [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func didPressBackArrow(){
        self.navigationController?.popViewController(animated: true)
    }
        
    private func setupBackArrowAction(){
        self.contentView.backArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressBackArrow)))
    }
    
    private func onLessonSelected(){
        self.contentView.onLessonSelected = { data in
            RecentlyWatchedData.saveToRecetlyWatched(data: RecentlyWatchedDataModel(chapterTitle: data.chapterTitle, subjectName: self.subject.name ?? "", lesson: data.lesson))
            self.navigationController?.pushViewController(VideoPlayerViewController(chapterTitle: data.chapterTitle, lesson: data.lesson), animated: true)
        }
    }
}
