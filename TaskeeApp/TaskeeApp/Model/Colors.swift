//
//  Colors.swift
//  TaskeeApp
//
//  Created by Mondale on 7/7/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit

struct Colors {

    let purple = UIColor(red: 215/255, green: 157/255, blue: 252/255, alpha: 1)
    let green = UIColor(red: 110/255, green: 222/255, blue: 114/255, alpha: 1)
    let blue = UIColor(red: 98/255, green: 163/255, blue: 226/255, alpha: 1)
    let pink = UIColor(red: 253/255, green: 160/255, blue: 236/255, alpha: 1)
    let orange = UIColor(red: 255/255, green: 193/255, blue: 79/255, alpha: 1)
    let red = UIColor(red: 255/255, green: 123/255, blue: 127/255, alpha: 1)
    let lightGray = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
    let gray = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    let black = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    
}

struct ColorsList {

    let colorsList: [UIColor] = [Colors.init().purple,Colors.init().green,Colors.init().blue,Colors.init().pink,Colors.init().orange,Colors.init().red,Colors.init().lightGray,Colors.init().gray,Colors.init().black]
}
