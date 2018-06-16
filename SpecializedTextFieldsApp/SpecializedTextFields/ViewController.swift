//
//  ViewController.swift
//  SpecializedTextFields
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController, UITextFieldDelegate
protocol LabelUpdate: class {
    func updateLabel()
}

protocol EditSwitchDelegate {
    
}

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    
    let zipCodeDelegate = ZipCodeTextFieldDelegate()
    let cashDelegate = CashTextFieldDelegate()
    let switchDelegate = SwitchTextFieldDelegate()
    let randomDelegate = RandomColorTextFieldDelegate ()
    let colorizerDelegate = ColorizerTextFieldDelegate ()
    let emojiDelegate = EmojiTextFieldDelegate ()
    let charCountDelegate = CharCountTextFieldDelegate ()

    // MARK: Outlets
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var switchTextField: UITextField!
    @IBOutlet weak var randomTextField: UITextField!
    @IBOutlet weak var colorizerTextField: UITextField!
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var charCountTextField: UITextField!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var editingSwitch: UISwitch!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.zipCodeTextField.delegate = self.zipCodeDelegate
        self.cashTextField.delegate = self.cashDelegate
        self.randomTextField.delegate = self.randomDelegate
        self.colorizerTextField.delegate = self.colorizerDelegate
        self.emojiTextField.delegate = self.emojiDelegate
        
        self.charCountTextField.delegate = self.charCountDelegate
        self.charCountDelegate.countLabel = self.characterCountLabel
        
        self.switchTextField.delegate = self.switchDelegate
        self.switchDelegate.editingSwitch = self.editingSwitch 
        

        self.characterCountLabel.isHidden = true
        self.editingSwitch.setOn(false, animated: false)
    
    }
    
    @IBAction func toggleTheTextEditor(_ sender: AnyObject) {
        
        if !(sender as! UISwitch).isOn {
            self.switchTextField.resignFirstResponder()
        }
    }
}


