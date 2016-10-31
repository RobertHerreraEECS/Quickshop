//
//  Singleton.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation

class ShoppingList {
    
    var currentShoppingList = [ShopList]()
    
    
    //    func saveShoppingList () {
    //
    //        let defaults = NSUserDefaults.standardUserDefaults()
    //        copyList = ShoppingList.sharedInstance.currentShoppingList
    //
    //        defaults.setObject(copyList, forKey: "savedList")
    //
    //    }
    
    func readSaveData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.objectForKey("savedLists")
    }
    
    static let sharedInstance = ShoppingList()
}