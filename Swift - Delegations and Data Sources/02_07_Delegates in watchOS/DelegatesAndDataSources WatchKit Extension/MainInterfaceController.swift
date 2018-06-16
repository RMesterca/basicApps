//
//  MainInterfaceController.swift
//  DelegatesAndDataSources
//
//  Created by Steven Lipton on 12/13/16.
//  Copyright © 2016 Steven Lipton. All rights reserved.
//

import WatchKit
import Foundation

//MARK: Step 6: adopt delegate protocol

class MainInterfaceController: WKInterfaceController,DessertsInterfaceControllerDelegate {
    
    
    var orderItem = OrderItem()
    @IBOutlet var dessertSelectionLabel: WKInterfaceLabel!
    
//MARK: Step 1: set up Context for segue method
    
//No destination controller in watchOS that assign values like iOS, but a context, which can be anything, most often,  dictionaries in order to send multiple values to the destination.
    
//To send by a context for a segue --> use the context for segue method. Inside, usually declare the context first using a dictionary of string for the key, and any for the value
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        var context:[String:Any]! = nil
        if segueIdentifier == "dessert"{
            
//MARK: Step 8: add another dictionary entry: delegate and self --> go back to Destination Controller (DessertsInterfaceController)
//          context = ["selection":"Desserts"]
            
            context = ["selection":"Desserts","delegate":self]
        }
        return context
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    //MARK: - Delegates
//MARK: Step 7: add protocol stop and write necessary code in delegate method
    
    func didFinishSelectingDessert(item: OrderItem) {
        orderItem = item
        dessertSelectionLabel.setText(orderItem.itemString())
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
