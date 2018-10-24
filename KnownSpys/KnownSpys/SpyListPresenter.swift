//
//  SpyListPresenter.swift
//  KnownSpys
//
//  Created by Raluca Mesterca on 21/10/2018.
//  Copyright © 2018 JonBott.com. All rights reserved.
//

import Foundation

typealias BlockWithSource = (Source)->Void
typealias VoidBlock = ()->Void

protocol SpyListPresenter {
    var data: [SpyDTO] { get }
    func loadData(finished: @escaping BlockWithSource)
}

class SpyListPresenterImplementation: SpyListPresenter {
    
    var data = [SpyDTO]()
    
    fileprivate var modelLayer: ModelLayer
    
    init(modelLayer: ModelLayer){
        self.modelLayer = modelLayer
    }
    
}

//MARK: - Data Methods
extension SpyListPresenterImplementation {
    
    func loadData(finished: @escaping BlockWithSource) {
        modelLayer.loadData { [weak self] source, spies in 
            self?.data = spies
            finished(source)
        }
    }
}

