//
//  WalmartStoreLocatoreAPI.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation
private let apiKey =  "x9f4hry2s9b5hw743cub4xk3"

class WalmartStoreLocatoreAPI {
    
    
    class func StoreLocatorAPIUsingZip(Query: String) -> String{
        
      let APIurl =  "http://api.walmartlabs.com/v1/stores?format=json&zip=\(Query)&apiKey=\(apiKey)"
        func returnModifiedURLUsingZip()-> String {
            return APIurl
        }
        
    return returnModifiedURLUsingZip()
        
    }// end class
    
    
    class func StoreLocatorAPIUsingCity(Query: String) -> String{
        
        var new = Query.stringByReplacingOccurrencesOfString(" ", withString: "+", options: .LiteralSearch, range: nil)
        
         let APIurl = "http://api.walmartlabs.com/v1/stores?format=json&city=\(new)&apiKey=\(apiKey)"
        
        func returnModifiedURL ()-> String {
            return APIurl
        }
        
        return returnModifiedURL()
        
    }// end class
    
    class func StoreLocatorAPIUsingLatAndLong(Latitude: String, Longitude: String)->String {
        
        let APIurl = "http://api.walmartlabs.com/v1/stores?format=json&lat=\(Latitude)&lon=\(Longitude)&apiKey=\(apiKey)"
        
        func returnModifiedURL ()-> String {
            return  APIurl
        }
        return returnModifiedURL()
        
    }// end class
    
    
    class func StoreLocatorAPIUsingAll(Query: String, Latitude: String, Longitude: String, Zip: String) ->String{
        
        var City = Query.stringByReplacingOccurrencesOfString(" ", withString: "+", options: .LiteralSearch, range: nil)
        
        
        let APIurl = "http://api.walmartlabs.com/v1/stores?format=json&lat=\(Latitude)&lon=\(Longitude)&zip=\(Zip)&city=\(City)&apiKey=\(apiKey)"
        
        func returnModifiedURL ()-> String {
            return APIurl
        }
        
        return returnModifiedURL()
        
    }// end class
    
    
    
    

    
    
    init(){
        
    }
    
    
}