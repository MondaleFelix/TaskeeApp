//
//  Project.swift
//  TaskeeApp
//
//  Created by Mondale on 7/12/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

struct Project {
    var name: String
    var color: UIColor
    var tasksList: [Task] = []
}

struct ProjectList {
    var projectList : [Project] = []
    
    mutating func deleteProject(index: Int) {
        projectList.remove(at: index)
    }
     
    mutating func addProject(name: String, color: UIColor){
        projectList.append(Project(name: name, color: color))
        print(self.projectList)
    }
}
