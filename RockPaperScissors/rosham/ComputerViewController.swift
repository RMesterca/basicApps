//
//  File.swift
//  rosham
//
//  Created by Mac on 18/04/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

class ComputerViewController: UIViewController {
    
    var computerHandValue: Int?
    var paperPressed: Bool?
    var rockPressed: Bool?
    var scissorsPressed: Bool?
   
    @IBOutlet var computerHand: UIImageView!
    @IBOutlet var matchResult: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let computerHandValue = self.computerHandValue {
            if rockPressed == true {
                switch computerHandValue {
                case 0: self.computerHand.image = UIImage (named: "Rock crushes Scissors")
                    self.matchResult.text = "Rock crushes Scissors. You win!"
                case 1: self.computerHand.image = UIImage (named: "Paper covers Rock")
                    self.matchResult.text = "Paper covers Rock. You lose!"
                case 2: self.computerHand.image = UIImage (named: "It's a Tie!")
                    self.matchResult.text = "It's a Tie!"
                default: return
                }
            }
            
            if paperPressed == true {
                switch computerHandValue {
                    case 0: self.computerHand.image = UIImage (named: "Paper covers Rock")
                        self.matchResult.text = "Paper covers Rock. You win!"
                    case 1: self.computerHand.image = UIImage (named: "Scissors cut Paper")
                        self.matchResult.text = "Scissors cut Paper. You lose!"
                    case 2: self.computerHand.image = UIImage (named: "It's a Tie!")
                        self.matchResult.text = "It's a Tie!"
                        default: return
                }
            }
            
            if scissorsPressed == true {
                switch computerHandValue {
                    case 0: self.computerHand.image = UIImage (named: "Scissors cut Paper")
                        self.matchResult.text = "Scissors cut Paper. You win!"
                    case 1: self.computerHand.image = UIImage (named: "Rock crushes Scissors")
                        self.matchResult.text = "Rock crushes Scissors. You lose!"
                    case 2: self.computerHand.image = UIImage (named: "It's a Tie!")
                        self.matchResult.text = "It's a Tie!"
                        default: return
                }
            }
        } else {
            self.computerHand.image = nil
        }
        
        self.computerHand.alpha = 0
        self.computerHand.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.computerHand.alpha = 1
            self.computerHand.alpha = 1
        }
    }
    
    /**
     * accepts a conditional Int, and returns an dice image, or nil
     */
    func imageForValue(_ value: Int?) -> UIImage? {
        return nil
    }
    
    /**
     *    dismiss this view controller
     */
 
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}



