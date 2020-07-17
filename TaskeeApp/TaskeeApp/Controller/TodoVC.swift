//
//  TodoVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/8/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import CoreData

class TodoVC: UIViewController, NSFetchedResultsControllerDelegate {
    
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
    }
    
    func fetchResultsTodo(){
        fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "relationship = %@", project)
        fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "status = false")

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("error")
        }
    }
    
    func fetchResultsDone(){
        fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "relationship = %@", project)
        fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "status = true")

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
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Return", style: .done, target: self, action: #selector(returnButtonPressed))

    }
    
    //MARK: Actions
    @objc func changeUp(){
            switch doneToggle.selectedSegmentIndex {
            case 0:
//                fetchTodoTasks()
                tableView.reloadData()
            case 1:
//                fetchDoneTasks()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.taskLabel.text = "Mondale is cool"
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
        }
    }
}
