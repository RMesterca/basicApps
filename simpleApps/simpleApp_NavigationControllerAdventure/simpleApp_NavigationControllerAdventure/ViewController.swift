//
//  ViewController.swift
//  simpleApp_NavigationControllerAdventure
//
//  Created by Mac on 18/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.startOver))
    }
   
    @objc func startOver() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

