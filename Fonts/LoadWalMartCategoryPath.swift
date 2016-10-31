//
//  LoadWalMartCateoryPath.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation

var data = Array<(name: String, id: String, path: String,Thumbnail: String)>()
var data2 = Array<(name: String, id: String, path: String,Thumbnail: String)>()

class LoadWalMartCategoryPath {
    

    
    class func StoreArrayByTuple(Name: String, ID: String, Path: String,Thumbnail: String){
        
    //data.removeAll(keepCapacity: true)
    data.append(name: Name,id: ID,path: Path,Thumbnail: Thumbnail)

        
    }
    
 
    
    class func ReturnStoreItems() -> Array<(name: String, id: String, path: String,Thumbnail: String)>{
        return data
    }
    
    class func PurgeCurrentItemPath() {
        
    
        for var index = 0; index < data2.count ; index++ {
            data2[index].name = " "
            data2[index].path = " "
            data2[index].id = " "
            data2[index].Thumbnail = " "
        }


    }
    
    class func updateWalMartCategoryItemList(){
        var update =  Array<(name: String, id: String, path: String,Thumbnail: String)>()
        update = data2
        data2.removeAll(keepCapacity: true)
        data2 = update
    }
 
 
    


}