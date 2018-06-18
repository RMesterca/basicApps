//
//  ViewController.swift
//  simpleApp_GetMeToYourLinkedin
//
//  Created by Mac on 18/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showWebContent(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/in/ralucamesterca/")
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true) {
            print("presented!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

