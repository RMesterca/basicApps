//
//  SwitchTextFieldDelegate.swift
//  SpecializedTextFields
//
//  Created by Mac on 16/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import Foundation
import UIKit

class SwitchTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    weak var editingSwitch = UISwitch()
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.editingSwitch!.isOn
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true;
    }
    
    
}

