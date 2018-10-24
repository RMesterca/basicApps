//
//  SecretDetailsPresenter.swift
//  KnownSpys
//
//  Created by Raluca Mesterca on 21/10/2018.
//  Copyright © 2018 JonBott.com. All rights reserved.
//

import Foundation

protocol SecretDetailsPresenter {
    var password: String { get }
}

class SecretDetailsPresenterImplementation: SecretDetailsPresenter {
    var spy: SpyDTO
    var password: String { return spy.password }
    
    init (with spy: SpyDTO) {
        self.spy = spy
    }
}
