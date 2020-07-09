//
//  ProjectTableViewCell.swift
//  TaskeeApp
//
//  Created by Mondale on 7/9/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    let colorView = UIView()
    let projectNameLabel = UILabel()
    let taskLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    init(color: UIColor, projectName: String, numberOfTask: Int) {
        super.init(style: .default, reuseIdentifier: "ProjectCell")
        
        self.colorView.backgroundColor = color
        self.projectNameLabel.text = projectName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        contentView.addSubview(colorView)
        contentView.addSubview(projectNameLabel)
        contentView.addSubview(taskLabel)
        
        contentView.backgroundColor = .systemGray6
        
        contentView.layer.cornerRadius = 10
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = 20
        projectNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                    
            colorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            colorView.widthAnchor.constraint(equalToConstant: 50),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
}
