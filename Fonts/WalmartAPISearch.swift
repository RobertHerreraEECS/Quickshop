//
//  WalmartAPISearch.swift
//  WalmartAPITest
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation

class WalmartAPISearch {
    
    private let apiKey: String = "x9f4hry2s9b5hw743cub4xk3"
    var searchQuery: String!
    
    
    func returnURLBasedSearchQuery() -> String {
        
        
        let urlCompatibleString = searchQuery.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let WalmartSearchForProducts = "http://api.walmartlabs.com/v1/search?query=\(urlCompatibleString)&format=json&apiKey=\(apiKey)"
        
        
        return WalmartSearchForProducts
    }
    
    
    
    init(Query: String!){
        
        
        
        self.searchQuery = Query
    }
}