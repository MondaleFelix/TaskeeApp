//
//  TodoVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/8/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class TodoVC: UIViewController {
    
    let doneToggle = UISegmentedControl()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDoneToggle()
        configureTableView()
        addBarButtons()
    }
    
    
    // Set up View Controller's UI
    private func configure(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    
    // Sets up done toggle UI
    private func configureDoneToggle(){
        view.addSubview(doneToggle)
        doneToggle.translatesAutoresizingMaskIntoConstraints = false
        doneToggle.backgroundColor = .systemGreen
        doneToggle.insertSegment(withTitle: "TODO", at: 0, animated: true)
        doneToggle.insertSegment(withTitle: "DONE", at: 1, animated: true)
        doneToggle.selectedSegmentIndex = 0
        doneToggle.sendActions(for: UIControl.Event.valueChanged)

        
        NSLayoutConstraint.activate([
            doneToggle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            doneToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneToggle.heightAnchor.constraint(equalToConstant: 30),
            doneToggle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            doneToggle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    
    // Sets up Table View
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        
        ])
    }
    
    
    // Add left and right buttons to navigation controller
    func addBarButtons(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Task", style: .done, target: self, action: #selector(addTaskPressed))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Return", style: .done, target: self, action: #selector(returnButtonPressed))

    }
    
    
    @objc func addTaskPressed(){
        navigationController?.pushViewController(NewTaskVC(), animated: true)
        
    }
    
    @objc func returnButtonPressed(){
        self.navigationController?.viewControllers = [HomeVC()]
    }
    
}
