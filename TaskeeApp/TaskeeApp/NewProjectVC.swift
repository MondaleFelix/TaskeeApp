//
//  NewProjectVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/6/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NewProjectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Project"
        view.backgroundColor = .systemBackground
        addBarButton()
    }
    

    private func addBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
    }
    
    @objc func saveButtonPressed(){
        self.navigationController?.popViewController(animated: true)

    }
}
