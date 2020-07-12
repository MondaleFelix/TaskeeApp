//
//  TaskTableViewCell.swift
//  TaskeeApp
//
//  Created by Mondale on 7/12/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    let checkboxImageView = UIImageView()
    let taskLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: "TaskCell")
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        contentView.addSubview(checkboxImageView)
        contentView.addSubview(taskLabel)
        selectionStyle = .none

        checkboxImageView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        

        checkboxImageView.backgroundColor = .systemGreen
        checkboxImageView.layer.cornerRadius = 10
        
        taskLabel.font = UIFont(name: "Helvetica", size: 20)

        
        
        
        NSLayoutConstraint.activate([
            
            checkboxImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkboxImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkboxImageView.widthAnchor.constraint(equalToConstant: 30),
            checkboxImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taskLabel.leadingAnchor.constraint(equalTo: checkboxImageView.trailingAnchor, constant: 10),
            taskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            taskLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        
    }
}
