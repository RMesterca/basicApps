//
//  RealmDataModel.swift
//  NoteBookApp_Realm
//
//  Created by Mac on 27/06/2018.
//  Copyright © 2018 Fig. All rights reserved.
//

import Foundation
import RealmSwift

class Note:Object {
    @objc dynamic var content = ""
    @objc dynamic var creationDate = Date()
}

class Notebook:Object {
    @objc dynamic var title = ""
    @objc dynamic var creationDate = Date()
    let notes = List<Note>()
}
