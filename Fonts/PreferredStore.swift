//
//  PreferredStore.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation


class PreferredStore {
    
    var currentStore = [stores]()
    var preferredStore = [stores]()
    
    static let sharedInstance = PreferredStore()
}