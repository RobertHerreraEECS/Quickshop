//
//  WalmartAPISearch.swift
//  WalmartAPITest
//
//  Created by Gabrielle Sanchez on 10/12/15.
//  Copyright (c) 2015 NMSU. All rights reserved.
//

import Foundation

class WalmartAPISearch {
    
    private let apiKey: String = "x9f4hry2s9b5hw743cub4xk3"
    var searchQuery: String!
    
    
    func returnURLBasedSearchQuery() -> String {
        
        
        var urlCompatibleString = searchQuery.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let WalmartSearchForProducts = "http://api.walmartlabs.com/v1/search?query=\(urlCompatibleString)&format=json&apiKey=\(apiKey)"
        return WalmartSearchForProducts
    }
    
    init(Query: String!){
        
        self.searchQuery = Query
    }
}