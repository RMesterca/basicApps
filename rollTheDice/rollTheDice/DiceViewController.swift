//
//  DiceViewController.swift
//  rollTheDice
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import Foundation
import UIKit

class DiceViewController: UIViewController {
    
    // MARK: Properties
    var firstValue: Int?
    var secondValue: Int?
    
    // MARK: Outlets
    @IBOutlet weak var firstDie: UIImageView!
    @IBOutlet weak var secondDie: UIImageView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        generateDiceValue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.setTransparency(alpha: 1)
        }
    }
    
    // MARK: Actions
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    func generateDiceValue () {
        guard let firstValue = self.firstValue else {
            return
        }
        
        guard let secondValue = self.secondValue else {
            return
        }
        
        self.firstDie.image = UIImage(named: "d\(firstValue)")
        self.secondDie.image = UIImage(named: "d\(secondValue)")
        setTransparency(alpha: 0)
    }
    
    func setTransparency(alpha: CGFloat) {
        self.firstDie.alpha = alpha
        self.secondDie.alpha = alpha
    }
}
