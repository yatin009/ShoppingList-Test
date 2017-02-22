//
//  ShopList.swift
//  ShoppingList2-Test
//
//  Created by Yatin on 21/02/17.
//  Copyright © 2017 MAPD-124. All rights reserved.
//

import Foundation
import RealmSwift

class ShopList : Object {
    
    dynamic var name : String = ""
    var listItems = List<ListItem>()
    dynamic var dateTime : String = ""
}
