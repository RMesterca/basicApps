//
//  SpyListPresenter.swift
//  KnownSpys
//
//  Created by Raluca Mesterca on 21/10/2018.
//  Copyright © 2018 JonBott.com. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

typealias BlockWithSource = (Source)->Void

struct SpySection {
    var header: String
    var items: [Item]
}

extension SpySection: SectionModelType {
    typealias Item = SpyDTO
    
    init(original: SpySection, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol SpyListPresenter {
    var sections: Variable<[SpySection]> { get }
    func loadData(finished: @escaping BlockWithSource)
    func makeSomeDataChange()
}

class SpyListPresenterImplementation: SpyListPresenter {
    
    var sections = Variable<[SpySection]> ([])
    
    fileprivate var bag = DisposeBag()
    fileprivate var spies = Variable<[SpyDTO]>([])
    fileprivate var modelLayer: ModelLayer
    
    init(modelLayer: ModelLayer){
        self.modelLayer = modelLayer
        setupObservers()
    }
}

// - Rx
extension SpyListPresenterImplementation {
    func setupObservers() {
        spies
            .asObservable()
            .subscribe(onNext: { [weak self] newSpies in
                self?.updateSections(with: newSpies)
            })
            .disposed(by: bag)
    }
    
    func updateSections(with newSpies: [SpyDTO]) {
        func mainWork() {
            sections.value = filter(spies: newSpies)
        }
        
        func filter(spies: [SpyDTO]) -> [SpySection] {
            let incognitoSpies = spies.filter{ $0.isIncognito }
            let everydaySpies = spies.filter{ !$0.isIncognito }
            
            return [SpySection(header: "Sneaky Spies", items: incognitoSpies), SpySection(header: "Plain Ol' Spies", items: everydaySpies)]
        }
        
        mainWork()
    }
}

//MARK: - Data Methods
extension SpyListPresenterImplementation {
    
    func makeSomeDataChange() {
        let newSpy = SpyDTO(age: 23, name: "Adam Smith", gender: .male, password: "wealth", imageName: "AdamSmith", isIncognito: true)
        spies.value.insert(newSpy, at: 0)
    }
    func loadData(finished: @escaping BlockWithSource) {
        modelLayer.loadData { [weak self] source, spies in 
            self?.spies.value = spies
            finished(source)
        }
    }
}

