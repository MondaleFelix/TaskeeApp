//
//  ViewController.swift
//  TaskeeApp
//
//  Created by Mondale on 6/29/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController {

    let tableView = UITableView()
    var coreDataStack = CoreDataStack.shared
    
    lazy var fetchedResultsController: NSFetchedResultsController<Project> = {
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        fetchRequest.sortDescriptors = []
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addBarItem()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchResults()
    }
    
    func fetchResults(){
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("error")
        }
    }

    private func configure(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelectionDuringEditing = true

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    // Adds "New" to the Navigation Controller
    private func addBarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(newButtonPressed))
        navigationItem.leftBarButtonItem = editButtonItem


    }

    
    // Pushes
    @objc func newButtonPressed(){
        let vc = NewProjectVC()
        vc.coreDataStack = coreDataStack
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if tableView.isEditing == true {
            let vc = NewProjectVC()
            let project = fetchedResultsController.object(at: indexPath)
            vc.project = project
            vc.coreDataStack = coreDataStack
            navigationController?.pushViewController(vc, animated: true)
            
            
        } else {
            
            let project = fetchedResultsController.object(at: indexPath)
            navigationController?.pushViewController(TodoVC(project: project), animated: true)

        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool){
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataStack.managedContext.delete(fetchedResultsController.object(at: indexPath))
            coreDataStack.saveContext()
        }
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo =
            fetchedResultsController.sections?[section] else {
                return 0
        }
        return sectionInfo.numberOfObjects
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectTableViewCell
        configure(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        <#code#>
//    }
}

extension HomeVC{
    func configure(cell: UITableViewCell, for indexPath: IndexPath){
        guard let cell = cell as? ProjectTableViewCell else { return }
        let project = fetchedResultsController.object(at: indexPath)
        let taskNumber = project.relationship as! Set<Task>
        cell.projectNameLabel.text = project.name
        cell.taskLabel.text = "\(taskNumber.count) pending tasks"

        if let colorTag = project.color {
            cell.colorView.backgroundColor = colorTag
        } else {
            cell.colorView.backgroundColor = nil
        }
    }
}


extension HomeVC: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
      switch type {
      case .insert:
        tableView.insertRows(at: [newIndexPath!], with: .automatic)
      case .delete:
        tableView.deleteRows(at: [indexPath!], with: .automatic)
      case .update:
        let cell = tableView.cellForRow(at: indexPath!) as! ProjectTableViewCell
        configure(cell: cell, for: indexPath!)
      case .move:
        tableView.deleteRows(at: [indexPath!], with: .automatic)
        tableView.insertRows(at: [newIndexPath!], with: .automatic)
      }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      tableView.endUpdates()
    }
}
