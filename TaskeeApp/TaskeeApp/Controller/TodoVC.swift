//
//  TodoVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/8/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import CoreData

class TodoVC: UIViewController{
    
    let doneToggle = UISegmentedControl()
    let tableView = UITableView()
    var coreDataStack = CoreDataStack.shared
    var project: Project

    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "projectName == %@", project.name ?? "")
        fetchRequest.sortDescriptors = []
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchResultsTodo()
        
        tableView.reloadData()
    }
    
    
    func fetchResultsTodo(){
        let relationship = NSPredicate(format: "relationship = %@", project)
        let status = NSPredicate(format: "status = false")

        fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [relationship,status])
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("error")
        }
    }
    
    func fetchResultsDone(){
        let relationship = NSPredicate(format: "relationship = %@", project)
        let status = NSPredicate(format: "status = true")

        fetchedResultsController.fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [relationship,status])
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("error")
        }
    }

    // This extends the superclass.
    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDoneToggle()
        configureTableView()
        addBarButtons()
        fetchResultsTodo()
        tableView.reloadData()
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
        doneToggle.addTarget(self, action: #selector(changeUp), for: .valueChanged)
        
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


    }
    
    //MARK: Actions
    @objc func changeUp(){
            switch doneToggle.selectedSegmentIndex {
            case 0:
                fetchResultsTodo()
                tableView.reloadData()
            case 1:
                fetchResultsDone()
                tableView.reloadData()
            default:
                break
            }
        }
    
    
    @objc func addTaskPressed(){
        navigationController?.pushViewController(NewTaskVC(project:project), animated: true)
        
    }
    
    @objc func returnButtonPressed(){
        self.navigationController?.viewControllers = [HomeVC()]
    }
    
}

//MARK: Extensions3
extension TodoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasksCount =
            fetchedResultsController.fetchedObjects?.count else {
                return 0
        }
        return tasksCount
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskLabel.text = task.title
        cell.completed = {
            
            if task.status {
                task.status = false
                self.coreDataStack.saveContext()
                self.tableView.reloadData()
            }else{
                task.status = true
                self.coreDataStack.saveContext()
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    

}

extension TodoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewTaskVC(project: project)
        let task = fetchedResultsController.object(at: indexPath)
        vc.project = project
        vc.task = task
        vc.coreDataStack = coreDataStack

        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataStack.managedContext.delete(fetchedResultsController.object(at: indexPath))
            coreDataStack.saveContext()
//            tableView.reloadData()
        }
    }
}

extension TodoVC: NSFetchedResultsControllerDelegate{
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
        let cell = tableView.cellForRow(at: indexPath!) as! TaskTableViewCell
        //configure
      case .move:
        tableView.deleteRows(at: [indexPath!], with: .automatic)
        tableView.insertRows(at: [newIndexPath!], with: .automatic)
      }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      tableView.endUpdates()
    }
}
