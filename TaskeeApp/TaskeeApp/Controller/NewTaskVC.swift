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
    let dueDateTextField = UIDatePicker()
    let stackView = UIStackView()
    var task : Task?
    var coreDataStack = CoreDataStack.shared
    var project: Project
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSaveButton()
        configureStackView()
        print(coreDataStack)
        
        if task != nil {
            setupValues()
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
    
    
    private func addSaveButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
    }

    @objc func saveButtonPressed(){
        if task == nil{
            let newTask = Task(context: coreDataStack.managedContext)
            newTask.dueDate = dueDateTextField.date
            newTask.title = titleTextField.text
            newTask.status = false
            newTask.projectName = project.name
            newTask.relationship = project
            coreDataStack.saveContext()
        } else {
            task?.dueDate = dueDateTextField.date
            task?.title = titleTextField.text
            task?.status = false
            coreDataStack.saveContext()
        }
        
        self.navigationController?.popViewController(animated: true)

    }
    
    func setupValues(){
      guard let task = task else { return }
      titleTextField.text = task.title
      dueDateTextField.date = task.dueDate!
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
//        dueDateLabel.text = "Due Date"
//        dueDateLabel.font = .systemFont(ofSize: 20)

        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 35),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -300)
        
        
        ])
    }

    

}
