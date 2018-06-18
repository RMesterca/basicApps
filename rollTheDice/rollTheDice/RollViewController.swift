//
//  ViewController.swift
//  rollTheDice
//
//  Created by Mac on 15/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit

// MARK: - RollViewController: UIViewController

class RollViewController: UIViewController {
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "rollDice" {
            
            let controller = segue.destination as! DiceViewController
            
            controller.firstValue = self.randomDiceValue()
            controller.secondValue = self.randomDiceValue()
        }
    }
    
    // MARK: Generate Dice Value
    
    // randomly generates a Int from 1 to 6
    func randomDiceValue() -> Int {
        // Generate a random Int32 using arc4Random
        let randomValue = 1 + arc4random() % 6
        
        // Return a more convenient Int, initialized with the random value
        return Int(randomValue)
    }
    
    // MARK: Actions
    
    @IBAction func rollTheDice(){
       
    }
}