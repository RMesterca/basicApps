//
//  CharCountTextFieldDelegate.swift
//  SpecializedTextFields
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import Foundation
import UIKit

class CharCountTextFieldDelegate: NSObject, UITextFieldDelegate {

    weak var countLabel: UILabel!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Figure out what the new text will be, if we return true
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        // hide the label if the newText will be an empty string
        self.countLabel.isHidden = (newText.length == 0)

        
        // Write the length of newText into the label
        self.countLabel.text = String(newText.length)
        
        // returning true gives the text field permission to change its text
        return true
    }    
}
