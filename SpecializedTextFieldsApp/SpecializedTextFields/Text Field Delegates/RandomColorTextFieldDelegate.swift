//
//  RandomColorTextFieldDelegate.swift
//  SpecializedTextFields
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import Foundation
import UIKit

class RandomColorTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let colors = [UIColor.red,
                  UIColor.orange, UIColor.yellow,
                  UIColor.green, UIColor.blue,
                  UIColor.purple, UIColor.brown];
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = self.randomColor()
        
        return true
    }
    
    func randomColor() -> UIColor {
        let randomIndex = Int(arc4random() % UInt32(colors.count))
        
        return colors[randomIndex]
    }
}

