//
//  ViewController.swift
//  TaskeeApp
//
//  Created by Mondale on 6/29/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addBarItem()

    }


    private func configure(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addBarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(newButtonPressed))
    }
    
    @objc func newButtonPressed(){
        
        navigationController?.pushViewController(NewProjectVC(), animated: true)
    }
    
    
}

