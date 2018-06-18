//
//  ViewController.swift
//  simpleApp_GoToLinkedinInSafari
//
//  Created by Mac on 18/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showWebContent(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/in/ralucamesterca/")
        UIApplication.shared.open(url!, options: ["":""], completionHandler: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("safari finished!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
