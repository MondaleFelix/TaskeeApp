//
//  NewTaskVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/8/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController {

    let titleLabel = UILabel()
    let titleTextField = MFTextField(placeholder: "e.g Create repository")
    let dueDateLabel = UILabel()
    let dueDateTextField = MFTextField(placeholder: "mm/dd/yyyy")
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSaveButton()
        configureStackView()
    }

    private func addSaveButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
    }

    @objc func saveButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func configure(){
        title = "New Task"
        view.backgroundColor = .systemBackground
    }
    
    private func configureStackView(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(dueDateLabel)
        stackView.addArrangedSubview(dueDateTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        stackView.distribution = .fillEqually
        
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 20)
        dueDateLabel.text = "Due Date"
        dueDateLabel.font = .systemFont(ofSize: 20)

        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 35),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -300)
        
        
        ])
    }

    

}
