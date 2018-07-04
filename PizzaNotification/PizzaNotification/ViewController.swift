//
//  ViewController.swift
//  PizzaNotification
//
//  Created by Mac on 27/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var pizzaNumber = 0
    let pizzaSteps = ["Make Pizza", "Roll Dough", "Add Sauce", "Add Cheese", "Add the rest of ingredients", "Bake Pizza", "Done"]
    var isGrantedNotificationsAccess = false
    
    func updatePizzaStep (request: UNNotificationRequest) {
        if request.identifier.hasPrefix("message.pizza") {
            var stepNumber = request.content.userInfo["step"] as! Int
            stepNumber = (stepNumber + 1) % pizzaSteps.count
            let updatedContent = makePizzaContent()
            updatedContent.body = pizzaSteps[stepNumber]
            updatedContent.userInfo["step"] = stepNumber
            updatedContent.subtitle = request.content.subtitle
            updatedContent.attachments = pizzaStepImage(step: stepNumber)
            addNotification(trigger: request.trigger, content: updatedContent, identifier: request.identifier)
        }
    }
    
    func makePizzaContent () -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent ()
        content.title = "A Timed Pizza Step"
        content.body = "Making Pizza"
        content.userInfo = ["step":0]
        content.categoryIdentifier = "pizza.step.category"
//        content.attachments = pizzaStepImage(step: 0)
        content.attachments = usePizzaGif()
        return content
    }
    
    func addNotification (trigger: UNNotificationTrigger?, content: UNMutableNotificationContent, identifier: String) {
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){error in
            if error != nil {
                let notificationError = error?.localizedDescription
                print ("error adding Notification: \(String(describing: notificationError))")
            }
        }
    }
    
    @IBAction func schedulePizza(_ sender: UIButton) {
        if isGrantedNotificationsAccess {
            let content = UNMutableNotificationContent ()
            content.title = "A Scheduled Pizza"
            content.body = "Time to Make a Pizza!"
            content.categoryIdentifier = "snooze.category"
            
            let attachment = notificationAttachment(for: "pizza.video", resource: "PizzaMovie", type: "mp4")
//            let attachment = notificationAttachment(for: "EHuliUke.music", resource: "EHuliUke", type: "mp3")
            content.attachments = attachment
            
            let unitFlags: Set<Calendar.Component> =  [.minute, .hour, .second]
            var date = Calendar.current.dateComponents(unitFlags, from: Date())
            date.second = date.second! + 5
            
            let trigger = UNCalendarNotificationTrigger (dateMatching: date, repeats: false)
            addNotification(trigger: trigger, content: content, identifier: "message.scheduled")
        }
    }
    
    @IBAction func makePizza(_ sender: UIButton) {
        if isGrantedNotificationsAccess {
            let content = makePizzaContent()
            pizzaNumber += 1
            
            content.subtitle = "Pizza \(pizzaNumber)"
            let trigger = UNTimeIntervalNotificationTrigger (timeInterval: 7, repeats: false)
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            
            addNotification(trigger: trigger, content: content, identifier: "message.pizza.\(pizzaNumber)")
        }
    }
    
    @IBAction func nextPizzaStep(_ sender: UIButton) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            if let request = requests.first {
                if request.identifier.hasPrefix("message.pizza") {
                    self.updatePizzaStep(request: request)
                } else {
                    let content = request.content.mutableCopy() as! UNMutableNotificationContent
                    self.addNotification(trigger: request.trigger!, content: content, identifier: request.identifier)
                }
            }
        }
    }
    
    @IBAction func viewPendingPizzas(_ sender: UIButton) {
        UNUserNotificationCenter.current().getPendingNotificationRequests {(requestList) in
            print ("\(Date ()) --> \(requestList.count) requests pending")
            for request in requestList {
                print ("\(request.identifier) body: \(request.content.body)")
            }
        }
    }
    
    
    @IBAction func viewDeliveredPizzas(_ sender: UIButton) {
        UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
            print ("\(Date()) --- \(notifications.count) delivered")
            for notification in notifications {
                print ("\(notification.request.identifier)  \(notification.request.content.body)")
            }
        }
    }
    
    @IBAction func removeNotifications(_ sender: UIButton) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            if let request = requests.first {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            self.isGrantedNotificationsAccess = granted
            
            if !granted {
                //                add alert access to app not allowes
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //      MARK: - Delegates
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler ([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let action = response.actionIdentifier
        let request = response.notification.request
        
        if action == "next.step.action" {
            updatePizzaStep(request: request)
        }
        
        if action == "stop.action" {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
        }
        
        if action == "snooze.action" {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let newRequest = UNNotificationRequest(identifier: request.identifier, content: request.content, trigger: trigger)
            UNUserNotificationCenter.current().add(newRequest) { (error) in
                if error != nil {
                    debugPrint("\(error!.localizedDescription)")
                }
            }
        }
        if action == "text.input.action" {
            let textResponse = response as! UNTextInputNotificationResponse
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            
            newContent.subtitle = textResponse.userText
            addNotification(trigger: request.trigger, content: newContent, identifier: request.identifier)
            
        }
        
        completionHandler ()
    }
    
    func notificationAttachment (for identifier: String, resource: String, type: String) -> [UNNotificationAttachment] {
        let extendedIndentifier = identifier + "." + type
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
            print ("The file \(resource).\(type) was not found ")
            return []
        }
        
        let videoURL = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(identifier: extendedIndentifier, url: videoURL, options: nil)
            return [attachment]
        } catch {
            print ("The attachment was not loaded")
            return []
        }
    }
    
    func usePizzaGif () -> [UNNotificationAttachment] {
        let extendedIndentifier = "pizza.gif"
        guard let path = Bundle.main.path(forResource: "MakePizza_0", ofType: "gif") else {
            print ("The file was not found ")
            return []
        }
        
        let videoURL = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(identifier: extendedIndentifier, url: videoURL, options: [UNNotificationAttachmentOptionsThumbnailTimeKey:11])
            return [attachment]
        } catch {
            print ("The attachment was not loaded")
            return []
        }
    }
    
    func pizzaStepImage (step: Int) -> [UNNotificationAttachment]{
        let stepString = String(format: "%i", step)
        let identifier = "pizza.step." + stepString
        let resource = "MakePizza_" + stepString
        let type = "jpg"
        return notificationAttachment(for: identifier, resource: resource, type: type)
    }
}



