//
//  FavoritesList2.swift
//  Fonts
//
//  Created by Gabrielle Sanchez on 10/11/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import Foundation

import UIKit

class FavoritesList2 {
    class var sharedFavoriteList : FavoritesList2 {
        struct Singleton {
            static let instance = FavoritesList2()
        }
        return Singleton.instance;
    }
    
    private(set) var favorites2:[String]
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("favorites") as? [String]
        favorites2 = storedFavorites != nil ? storedFavorites! : []
    }
    
    func addFavorite(fontName: String) {
        if (!contains(favorites2, fontName)) {
            favorites2.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorite(fontName: String) {
        if let index = find(favorites2, fontName) {
            favorites2.removeAtIndex(index)
            saveFavorites()
        }
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item = favorites2[from]
        favorites2.removeAtIndex(from)
        favorites2.insert(item, atIndex: to)
        saveFavorites()
    }
    
    private func saveFavorites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites2, forKey: "favorites")
        defaults.synchronize()
    }
}