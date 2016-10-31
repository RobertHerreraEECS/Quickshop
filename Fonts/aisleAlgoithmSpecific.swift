//
//  aisleAlgorithm.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation


class aisleAlgorithmSpecific {  // Specific Wal-Mart Aisle Algorithm (88001)
    
    var path: String
    
    var i: Int
    
    func checkAisle(){
        
        // 1
        if(path.lowercaseString.rangeOfString("produce") != nil) {
            
            return
        }
        
        //2.3
        if(path.lowercaseString.rangeOfString("ice cream") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 2
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        
        //4.5
        if(path.lowercaseString.rangeOfString("frozen pizza") != nil || path.lowercaseString.rangeOfString("dinners") != nil || path.lowercaseString.rangeOfString("frozen meals") != nil || path.lowercaseString.rangeOfString("frozen vegetables") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 4
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        
        //6.7
        if(path.lowercaseString.rangeOfString("jelly") != nil || path.lowercaseString.rangeOfString("bread") != nil || path.lowercaseString.rangeOfString("frozen breakfast") != nil || path.lowercaseString.rangeOfString("peanut butter") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 6
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //8.9
        if(path.lowercaseString.rangeOfString("coffee") != nil || path.lowercaseString.rangeOfString("pickles") != nil || path.lowercaseString.rangeOfString("ketchup") != nil || path.lowercaseString.rangeOfString("mustard") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 8
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //10.11
        if(path.lowercaseString.rangeOfString("rice") != nil || path.lowercaseString.rangeOfString("beans") != nil || path.lowercaseString.rangeOfString("hispanic foods") != nil || path.lowercaseString.rangeOfString("spaghetti sauce") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 10
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //12.13
        if(path.lowercaseString.rangeOfString("cookies") != nil || path.lowercaseString.rangeOfString("crackers") != nil || path.lowercaseString.rangeOfString("canned meats") != nil || path.lowercaseString.rangeOfString("canned pasta") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 12
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //14.15
        if(path.lowercaseString.rangeOfString("juice") != nil || path.lowercaseString.rangeOfString("boxed juice") != nil || path.lowercaseString.rangeOfString("canned fruit") != nil || path.lowercaseString.rangeOfString("canned beans") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 14
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //16.17
        if(path.lowercaseString.rangeOfString("flour") != nil || path.lowercaseString.rangeOfString("sugar") != nil || path.lowercaseString.rangeOfString("spices") != nil || path.lowercaseString.rangeOfString("gelatin") != nil ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 16
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //18.19
        if(path.lowercaseString.rangeOfString("syrup") != nil || path.lowercaseString.rangeOfString("cereal") != nil || path.lowercaseString.rangeOfString("hot cereal") != nil || path.lowercaseString.rangeOfString("cereal") != nil || path.lowercaseString.rangeOfString("toaster pastries") != nil ) {
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 18
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //20.21
        if(path.lowercaseString.rangeOfString("candy") != nil || path.lowercaseString.rangeOfString("popcorn") != nil || path.lowercaseString.rangeOfString("paper towels") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 20
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        
        //22.23
        if(path.lowercaseString.rangeOfString("trash bags") != nil || path.lowercaseString.rangeOfString("facial tissue") != nil || path.lowercaseString.rangeOfString("paper tissue") != nil || path.lowercaseString.rangeOfString("bathroom tissue") != nil) {
            print("exists")
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 25
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //27
        if(path.lowercaseString.rangeOfString("water") != nil || path.lowercaseString.rangeOfString("paper plates") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 26
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //28
        if(path.lowercaseString.rangeOfString("juices") != nil || path.lowercaseString.rangeOfString("cream cheese") != nil || path.lowercaseString.rangeOfString("eggs") != nil || path.lowercaseString.rangeOfString("bagels") != nil || path.lowercaseString.rangeOfString("dough") != nil) {
            print("exists")
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 27
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //29
        if(path.lowercaseString.rangeOfString("coffee creamer") != nil || path.lowercaseString.rangeOfString("milk") != nil ) {
            print("exists")
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 28
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //30
        if(path.lowercaseString.rangeOfString("yogurt") != nil  ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 29
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //31
        if(path.lowercaseString.rangeOfString("pudding") != nil  || path.lowercaseString.rangeOfString("jello") != nil  ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 30
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //32
        if(path.lowercaseString.rangeOfString("dip") != nil  || path.lowercaseString.rangeOfString("sour cream") != nil || path.lowercaseString.rangeOfString("cheese sticks") != nil  ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 31
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //33
        if(path.lowercaseString.rangeOfString("sandwich meats") != nil  || path.lowercaseString.rangeOfString("cold cuts") != nil || path.lowercaseString.rangeOfString("bacon") != nil  || path.lowercaseString.rangeOfString("weenie") != nil ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 32
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //34
        if(path.lowercaseString.rangeOfString("pork") != nil  || path.lowercaseString.rangeOfString("poultry") != nil ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 33
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //35
        if(path.lowercaseString.rangeOfString("meat") != nil  || path.lowercaseString.rangeOfString("red meat") != nil  || path.lowercaseString.rangeOfString("steak") != nil  || path.lowercaseString.rangeOfString("tenderloin") != nil ) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 34
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //36
        if(path.lowercaseString.rangeOfString("seafood") != nil  || path.lowercaseString.rangeOfString("fish") != nil  || path.lowercaseString.rangeOfString("shrimp") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 36
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //37
        if(path.lowercaseString.rangeOfString("seafood") != nil  || path.lowercaseString.rangeOfString("fish") != nil  || path.lowercaseString.rangeOfString("shrimp") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 37
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //38
        if(path.lowercaseString.rangeOfString("bakery") != nil  || path.lowercaseString.rangeOfString("deli") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 38
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        //39
        if(path.lowercaseString.rangeOfString("cakes") != nil  || path.lowercaseString.rangeOfString("tortillas") != nil) {
            
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 39
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        else {
            ShoppingList.sharedInstance.currentShoppingList[i].aisle = 0
            print("\(ShoppingList.sharedInstance.currentShoppingList[i].aisle)")
            return
        }
        
        
    }
    
    
    
    
    init(string: String, passedIndex: Int){
        
        self.path = string
        self.i = passedIndex
    }
    
    
}