//
//  NewProjectVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/6/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NewProjectVC: UIViewController {

    let projectNameTF = MFTextField(placeholder: "Name your project")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton()
        configure()
        
    }
    

    // UI Setup
    private func configure(){
        title = "New Project"
        view.backgroundColor = .systemBackground
        view.addSubview(projectNameTF)
        
        NSLayoutConstraint.activate([
            projectNameTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            projectNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            projectNameTF.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    
    // Adds "Save" button to Navigation Controller
    private func addBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
    }
    
    
    // Saves Project Model
    @objc func saveButtonPressed(){
        self.navigationController?.popViewController(animated: true)

    }
}
