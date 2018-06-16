//
//  ViewController.swift
//  Plain Ol' To-Do
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtAddItem: UITextField!
    @IBOutlet weak var txtList: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func didTapButton(_ sender: Any) {
        if let text = txtAddItem.text {
            if text == "" {
                return
            }
            txtList.text.append("\(text)\n")
            txtAddItem.text = ""
            txtAddItem.resignFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

