//
//  ViewController.swift
//  color maker slider
//
//  Created by Mac on 16/04/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redControl: UISlider!
    @IBOutlet weak var greenControl: UISlider!
    @IBOutlet weak var blueControl: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func colorChanged() {
        
    if self.redControl == nil {
        return
    }
    let r: CGFloat = CGFloat (self.redControl.value)
    let g: CGFloat = CGFloat(self.greenControl.value)
    let b: CGFloat = CGFloat (self.blueControl.value)
            
    self.colorView.backgroundColor = UIColor (red: r, green: g, blue: b, alpha:1)
        }
}
