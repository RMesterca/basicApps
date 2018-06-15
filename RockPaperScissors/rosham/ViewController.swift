//
//  ViewController.swift
//  rosham
//
//  Created by Mac on 18/04/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet var paperButton: UIButton!
    @IBOutlet var rockButton:UIButton!
    @IBOutlet var scissorsButton:UIButton!
    
    var paperPressed: Bool = false
    var rockPressed: Bool = false
    var scissorsPressed: Bool = false
    
    /*rockButton.tag = 0
    paperButton.tag = 1
    scissorsButton = 2*/

   func randomHand () -> Int {
        let array = ["Win", "Lose", "Tie"]
        let randomValue = Int(arc4random_uniform(UInt32(array.count)))
        return Int(randomValue)
    }
    
    @IBAction func chooseHand(_sender:UIButton) {
        
        switch _sender {
            case rockButton:
                var controller: ComputerViewController
                controller = self.storyboard?.instantiateViewController(withIdentifier: "ComputerViewController") as! ComputerViewController
       
                controller.computerHandValue = self.randomHand()
                controller.rockPressed = true
                present(controller, animated: true, completion: nil)
            
            //choose match result
            
            
                //print ("rock was pressed")
            case paperButton:
                //print ("paperbutton pressed")
                self.performSegue(withIdentifier: "chooseHand", sender: self)
            case scissorsButton:
              // print ("scissors button pressed")
               return
            default:
                return
            
        }
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "chooseHand" {
                let controller = segue.destination as! ComputerViewController
                
                 controller.computerHandValue = self.randomHand()
                 controller.paperPressed = true
            }
            
            if segue.identifier == "changeHandWithScissors"{
                let controller = segue.destination as! ComputerViewController
                
                controller.computerHandValue = self.randomHand()
                controller.scissorsPressed = true
            }
        }

}
