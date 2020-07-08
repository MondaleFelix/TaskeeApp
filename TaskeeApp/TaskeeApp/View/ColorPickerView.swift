//
//  ColorPickerView.swift
//  TaskeeApp
//
//  Created by Mondale on 7/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {

    let colors = Colors()
    let firstRow = UIStackView()
    let secondRow = UIStackView()
    let thirdRow = UIStackView()
    let colorsStackView = UIStackView()

    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func configureFirstRow(){
//        firstRow.addArrangedSubview(<#T##view: UIView##UIView#>)
//    }
//    
}
