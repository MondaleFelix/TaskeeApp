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
    var completed: (()-> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: "TaskCell")
        configure()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addAction() {
        checkboxImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        checkboxImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(){
        completed!()
    }
    
    private func configure(){
        contentView.addSubview(checkboxImageView)
        contentView.addSubview(taskLabel)
        selectionStyle = .none
        
        checkboxImageView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        

        checkboxImageView.backgroundColor = .systemGreen
        checkboxImageView.layer.cornerRadius = 10
        
//        cell.tapCheck = {
//            if task.status {
//                task.status = false
//                self.coreDataStack.saveContext()
//                self.taskTable.reloadData()
//            }else{
//                task.status = true
//                self.coreDataStack.saveContext()
//                self.taskTable.reloadData()
//            }
//        }
//        
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
