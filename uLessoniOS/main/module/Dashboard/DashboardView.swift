//
//  DashboardView.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 28/02/2021.
//

import UIKit

class DashboardView: UIView {
    
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
        label.font = UIFont.itimRegular(size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView(){
        self.backgroundColor = .white
        addSubview(helloLabel)
        
        helloLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        helloLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        helloLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true

    }
    
}
