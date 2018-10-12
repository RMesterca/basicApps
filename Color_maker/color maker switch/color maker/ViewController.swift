//
//  ViewController.swift
//  color maker
//
//  Created by Mac on 16/04/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redControl: UISwitch!
    @IBOutlet weak var greenControl: UISwitch!
    @IBOutlet weak var blueControl: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColorComponent()
    }
    
    @IBAction func changeColorComponent() {
        let r: CGFloat = self.redControl.isOn ? 1 : 0
        let g: CGFloat = self.greenControl.isOn ? 1 : 0
        let b: CGFloat = self.blueControl.isOn ? 1 : 0
        
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
