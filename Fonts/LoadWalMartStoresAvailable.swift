//
//  LoadWalMartCateoryPath.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation

var StoreData = Array<(name: String, coordinates: Array<Double>, streetAddress: String,zip: String)>()
var StoreData2 = Array<(name: String, coordinates: Array<Double>, streetAddress: String,zip: String)>()

class LoadWalMartStoreAvailable {
    
    
    
    class func StoreArrayByTuple(Name: String, Coordinates: Array<Double>, StreetAddress: String,Zip: String){
        
        StoreData.append(name: Name,coordinates: Coordinates,streetAddress: StreetAddress,zip: Zip)
        StoreItems(StoreData)
        
    }
    
    class func StoreItems( items: Array<(name: String,coordinates: Array<Double>,streetAddress: String,zip: String)>){
        
        StoreData2 = items
        
    }
    
    class func ReturnStoreItems() -> Array<(name: String,coordinates: Array<Double>,streetAddress: String,zip: String)>{
        return StoreData2
    }
    
    class func PurgeCurrentItemPath() {
        
        
        StoreData2.removeAll(keepCapacity: false)
        print("I now have :: \(StoreData2.description)\n\n")
        
        
    }
    
    class func updateWalMartCategoryItemList(){
        var update =  Array<(name: String,coordinates: Array<Double>,streetAddress: String,zip: String)>()
        update = StoreData2
        StoreData2.removeAll(keepCapacity: true)
        StoreData2 = update
    }
    
    
    
    
    
}