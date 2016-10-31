//
//  updateManager.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import Foundation


class updateManager {
    
    var FoodCategoriesFirst = [
        "Bakery & Bread":"976759_976779","Baking":"976759_976780","Beverages":"976759_976782",
        "Breakfast & Cereal":"976759_976783","Candy & Gum":"976759_1096070",
        "Canned Good & Soups":"976759_976785","Coffee":"976759_1086446",
        "Condiments, Sauces & Spices":"976759_976786","Dairy, Eggs & Cheese":"976759_976788",
        "Deli":"976759_976789","Food Gifts":"976759_1089004","Fresh Food":"976759_1071964",
        "Frito-Lay":"976759_1231294","Frozen Foods":"976759_976791",
        "Gluten-Free Foods":"976759_1228023","International Foods":"976759_1228025",
        "Meal Solutions, Grains & Pasta":"976759_976794",
        "Meat, Seafood & Poultry":"976759_976796","Organic Foods":"976759_1228024",
        "Produce":"976759_976793","Snacks, Cookies & Chips":"976759_976787"]
    
    class func updateFetchedItemList(){
        LoadWalMartCategoryPath.updateWalMartCategoryItemList()
    }
    
}