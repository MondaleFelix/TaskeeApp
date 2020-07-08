//
//  ColorButton.swift
//  TaskeeApp
//
//  Created by Mondale on 7/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ColorButton: UIButton {
    
    var color : UIColor!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color:UIColor) {
        super.init(frame: .zero)
        self.color = color
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 50
        backgroundColor = color
    }
}
