//
//  MainViewController.swift
//  DelegatesAndDataSources
//
//  Created by Steven Lipton on 12/7/16. Modified 2/1/18
//  Copyright © 2016 Steven Lipton. All rights reserved.
//

import UIKit


//    MARK: Step 4: In the Source Controller, adopt the the delegate protocol

class MainViewController: UIViewController,BeverageViewControllerDelegate, PizzaViewControllerDelegate, DessertViewControllerDelegate {
    
    
    @IBOutlet weak var orderView: UIView!
    var orderedItems = OrderList()
    var orderTableVC = OrderTableViewController()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderedItems.add(name: "Huli Chips", size: "Small")
        orderTableVC.updateTable(orderList: orderedItems)
    }

//    MARK: Step 5: Delegates and Data Sources - add Protocol Stubs and do necessary changes
    
    func didChooseDessert(dessert: OrderItem) {
        orderedItems.add(orderItem: dessert)
        orderTableVC.updateTable(orderList: orderedItems)
    }
    
    func didChooseBeverage(beverage: OrderItem) {
        orderedItems.add(orderItem: beverage)
        orderTableVC.updateTable(orderList: orderedItems)
        
        
    }
    
    func didSelectPizza(pizza: OrderItem) {
        orderedItems.add(orderItem: pizza)
        orderTableVC.updateTable(orderList: orderedItems)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "desserts"{
            let vc = segue.destination as! DessertViewController
            vc.lastSelection = orderedItems.lastSelection
            
//    MARK: Step 6: Important!! do not forget to assign the Delegate to the Source Controller, (delegate has value nil in the Destination Controller)
            
            vc.delegate = self
        }
        
        if segue.identifier == "beverage"{
            let beverageViewController = segue.destination as! BeverageViewController
            beverageViewController.delegate = self
        }
        
        if segue.identifier == "order table"{ //embedded view -- keep controller around
            orderTableVC = segue.destination as! OrderTableViewController
        }
        
        if segue.identifier == "pizza"{
            let pizzaViewController = segue.destination as! PizzaViewController
            pizzaViewController.delegate = self
        }
        
        
    }
}























