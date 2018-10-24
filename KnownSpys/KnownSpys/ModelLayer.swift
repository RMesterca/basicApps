//
//  ModelLayer.swift
//  KnownSpys
//
//  Created by Raluca Mesterca on 22/10/2018.
//  Copyright © 2018 JonBott.com. All rights reserved.
//

import Foundation

typealias SpiesAndSourceBlock = (Source, [SpyDTO])->Void

protocol ModelLayer {
    func loadData(resultsLoaded: @escaping SpiesAndSourceBlock)
}

class ModelLayerImplementation: ModelLayer {
    fileprivate var networkLayer: NetworkLayer
    fileprivate var dataLayer: DataLayer
    fileprivate var translationLayer: TranslationLayer
    
    init (networkLayer: NetworkLayer, dataLayer: DataLayer, translationLayer: TranslationLayer) {
        self.networkLayer = networkLayer
        self.dataLayer = dataLayer
        self.translationLayer = translationLayer
    } 
    
    func loadData(resultsLoaded: @escaping SpiesAndSourceBlock) {
        func mainWork() {
            
            loadFromDB(from: .local)
            
            networkLayer.loadFromServer { data in
                let dtos = self.translationLayer.createSpyDTOsFromJsonData(data)
                self.dataLayer.save(dtos: dtos, translationLayer: self.translationLayer) {
                    loadFromDB(from: .network)
                }
            }
        }
        
        func loadFromDB(from source: Source) {
            dataLayer.loadFromDB { spies in
                let dtos = translationLayer.toSpyDTOs(from: spies)
                resultsLoaded(source, dtos)
            }
        }
        
        mainWork()
    }
}
