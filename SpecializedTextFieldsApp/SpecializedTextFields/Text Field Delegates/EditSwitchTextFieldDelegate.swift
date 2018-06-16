//
//  EditSwitchTextFieldDelegate.swift
//  SpecializedTextFields
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import Foundation
import UIKit

class EditSwitchTextfieldDelegate: NSObject, UITextFieldDelegate {
   
//    @IBOutlet weak var editingSwitch: UISwitch!
    
    override func awakeFromNib() {
//        self.editingSwitch.setOn(false, animated: false)
    }
    

    // MARK: Text Field Delegate
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if self.editingSwitch.isOn {
//            return true
//        } else {
//            return false
//        }
////        return self.editingSwitch.isOn
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
} 
