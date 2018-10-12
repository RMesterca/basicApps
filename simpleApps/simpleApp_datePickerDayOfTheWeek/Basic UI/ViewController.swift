//
//  ViewController.swift
//  Basic UI
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Choose a date"
    }

    @IBAction func didChangeDate(_ sender: UIDatePicker) {
        let date:Date = sender.date
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dayOfWeek:String = formatter.string(from: date)
        label.text = "The day is a \(dayOfWeek)"
    }
}

