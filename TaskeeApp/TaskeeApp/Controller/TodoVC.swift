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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: doneToggle.bottomAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        ])
    }
    
    
    // Add left and right buttons to navigation controller
    func addBarButtons(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Task", style: .done, target: self, action: #selector(addTaskPressed))
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Return", style: .done, target: self, action: #selector(returnButtonPressed))

    }
    
    
    @objc func addTaskPressed(){
        navigationController?.pushViewController(NewTaskVC(), animated: true)
        
    }
    
    @objc func returnButtonPressed(){
        self.navigationController?.viewControllers = [HomeVC()]
    }
    
}

extension TodoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskLabel.text = "Mondale is cool"
        return cell
    }
    
    

}

extension TodoVC: UITableViewDelegate {
    
    
}
