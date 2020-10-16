//
//  UIButton + Extra.swift
//  TVManager
//
//  Created by Emad Albarnawi on 17/10/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;


extension UIButton {
    func addBoarder(with color: UIColor) {
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = color.cgColor;
        
    }
}
