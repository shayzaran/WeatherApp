//
//  Category.swift
//  TodoList
//
//  Created by user136891 on 3/21/18.
//  Copyright © 2018 Selahattin Hayzaran. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    
    @objc dynamic var name :String = ""
    @objc dynamic var  colour : String = ""
    let items = List<Item>()

}
