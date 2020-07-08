//
//  NewTaskVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/8/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSaveButton()

    }

    
    private func configure(){
        title = "New Task"
        view.backgroundColor = .systemBackground
        
    }
    
    
    private func addSaveButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
    }

    @objc func saveButtonPressed(){
        print("Save hit")
    }
    
}
