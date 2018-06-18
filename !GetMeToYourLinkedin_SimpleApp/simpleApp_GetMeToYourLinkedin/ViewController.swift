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
    }
    
    @IBAction func showWebContent(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/in/ralucamesterca/")
        UIApplication.shared.open(url!, options: ["":""], completionHandler: nil)
    }
}

