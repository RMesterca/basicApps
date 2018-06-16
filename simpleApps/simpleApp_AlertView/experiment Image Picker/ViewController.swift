//
//  ViewController.swift
//  experiment Image Picker
//
//  Created by Mac on 17/04/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func experiment (sender:UIButton){
       // let image = UIImage ()
        //let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //let nextController = UIImagePickerController()
       // present(nextController, animated: true, completion: nil)
        
        let controller = UIAlertController()
        controller.title = "Test Alert"
        controller.message = "This is a test"
        
        let okAction = UIAlertAction (title: "OK", style: UIAlertActionStyle.default){
            action in self.dismiss(animated: true, completion: nil)
        }
        
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
       // dismiss(animated: true, completion: nil)
    }
    
}

