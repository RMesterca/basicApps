//
//  MockedWebServer.swift
//  KnownSpys
//
//  Created by Raluca Mesterca on 22/10/2018.
//  Copyright © 2018 JonBott.com. All rights reserved.
//

import Foundation
import Swifter
import Alamofire
import Outlaw

class MockedWebServer {
    static let sharedInstance = MockedWebServer()
    
    let server: HttpServer
    let json: AnyObject
    
    fileprivate init(){
        let url = Bundle.main.url(forResource: "spies", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            
        server = HttpServer()
        server["/spies"] = { request in
            Thread.sleep(forTimeInterval: 4) //fake server delay
            return .ok(.json(self.json))
        }
    }
    
    func start() {
        try! server.start()
    }
}
