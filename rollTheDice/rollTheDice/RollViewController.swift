//
//  ViewController.swift
//  rollTheDice
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

class RollViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rollDice" {
            guard let controller = segue.destination as? DiceViewController else {
                return
            }
            
            controller.firstValue = self.randomDiceValue()
            controller.secondValue = self.randomDiceValue()
        }
    }
    
    func randomDiceValue() -> Int {
        let randomValue = 1 + arc4random() % 6
        return Int(randomValue)
    }
}
