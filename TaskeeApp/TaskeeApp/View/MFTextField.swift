//
//  MFTextField.swift
//  TaskeeApp
//
//  Created by Mondale on 7/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class MFTextField: UITextField {

    var placeholderText: String?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder : String) {
        super.init(frame: .zero)
        self.placeholderText = placeholder
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        placeholder = self.placeholderText
        textColor = .black
        font = .systemFont(ofSize: 25)
        
        
        
    }
}
