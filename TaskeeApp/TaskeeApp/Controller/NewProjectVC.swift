//
//  NewProjectVC.swift
//  TaskeeApp
//
//  Created by Mondale on 7/6/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class NewProjectVC: UIViewController {
    
    let colorsList = ColorsList().colorsList
    
    let projectNameTF = MFTextField(placeholder: "Name your project")
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton()
        configure()
        configureCollectionView()

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
    
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(equalTo: projectNameTF.bottomAnchor,constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        
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

extension NewProjectVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension NewProjectVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsList.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        cell.backgroundColor = self.colorsList[indexPath.item]
        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.clipsToBounds = true
        return cell
    }
    
}

extension NewProjectVC: UICollectionViewDelegateFlowLayout {
    
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      //2
      return CGSize(width: 60  , height: 60)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return  UIEdgeInsets(top: 20 , left: 20  ,  bottom: 20, right: 20)
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}


