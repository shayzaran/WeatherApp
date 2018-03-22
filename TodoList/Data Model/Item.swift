//
//  Item.swift
//  TodoList
//
//  Created by user136891 on 3/21/18.
//  Copyright © 2018 Selahattin Hayzaran. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
