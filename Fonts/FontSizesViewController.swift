//
//  FontSizesViewController.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import UIKit



class FontSizesViewController: UITableViewController {

   var NameSearchQuery = " "
    var recievedInt: Int = 0
    var TableCellCount = 3
    var bypassFlag : Bool = false
    private let cellIdentifier = "FontNameAndSize"
    
    
    
    @IBOutlet weak var internetIndicator: UIActivityIndicatorView!

  
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
         if self.bypassFlag == false {
            
            
            let query = Array(updateManager().FoodCategoriesFirst.values)[self.recievedInt]
            
            
            let temp =  WalmartItemIDSearch(Query: query)
            let temp2 = temp.returnURLBasedSearchQuery()
            // UserInput = temp2
            
            
        
            DataManager.getUpdatedSearchURLwithQuery(temp2)
            DataManager.getSearchQueryDataFromWalMartWithSuccess { (ItemQueryData) -> Void in
                
                self.internetIndicator.startAnimating()
                let json = JSON(data: ItemQueryData)
    
                
                if let searchItemCategories = json["items"].array {
                    
                    CategoryList.sharedInstance.newCatArray.removeAll(keepCapacity: false)
                    
                    for searchItemInfo in searchItemCategories {
                        var tempData = [( " ", " ", " ", " "," "), ( " ", " ", " ", " "," "), ( " ", " ", " ", " "," "),( " ", " ", " ", " "," "),( " ", " ", " ", " "," ")]
                        
                        if let itemName = searchItemInfo["name"].string {
                            tempData[0] = ( itemName, " ", " ", " "," ")
                        }
                        if let itemId = searchItemInfo["itemId"].int {
                            tempData[1] = ( " ", String(itemId), " ", " "," ")
                            
                        }
                        if let itemPath = searchItemInfo["categoryPath"].string {
                            tempData[2] = ( " ", " ", itemPath , " "," ")
                            
                        }
                        if let thumbnail = searchItemInfo["thumbnailImage"].string {
                            tempData[3] = ( " ", " ", " " , thumbnail," ")
                        }
                        if let price     = searchItemInfo["salePrice"].double {
                            tempData[4] = ( " ", " ", " " , " ",String(stringInterpolationSegment: price))
                        }
                        
                        
                        CategoryList.sharedInstance.newCatArray.append(subCategoryList(name: tempData[0].0, id: tempData[1].1, path: tempData[2].2, thumbnail: tempData[3].3,aisle: 0,SalesPrice: tempData[4].4))
                        

                        
                    }// end for loop
                    
                    
                }// end for in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.internetIndicator.stopAnimating()
                })
            
                
            } // end dataManager
       
            // end if
         } else {
            
            
            
            let temp = WalmartAPISearch(Query: NameSearchQuery)
            let temp2 = temp.returnURLBasedSearchQuery()
            print("\(temp2)\n")
            // UserInput = temp2
            
            
            DataManager.getUpdatedSearchURLwithQuery(temp2)
            DataManager.getSearchQueryDataFromWalMartWithSuccess { (ItemQueryData) -> Void in
                let json = JSON(data: ItemQueryData)
                
                if let totalResults = json["totalResults"].int {
                    if totalResults == 0 {
                        let title = "Item Search"
                        let message = "Sorry, no items were found.\n Consider using other key words."
                        let okText = "Continue"
                        
                        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                        let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
                        alert.addAction(okayButton)
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        return
                    }
                }
                
                
                self.internetIndicator.startAnimating()
                if let searchItemCategories = json["items"].array {
                    
                    CategoryList.sharedInstance.newCatArray.removeAll(keepCapacity: false)
                    for searchItemInfo in searchItemCategories {
                        
                        var tempData = [( " ", " ", " ", " "," "), ( " ", " ", " ", " "," "), ( " ", " ", " ", " "," "),( " ", " ", " ", " "," "),( " ", " ", " ", " "," ")]
                        
                        if let itemName = searchItemInfo["name"].string {
                            tempData[0] = ( itemName, " ", " ", " "," ")
                        }
                        if let itemId = searchItemInfo["itemId"].int {
                            tempData[1] = ( " ", String(itemId), " ", " "," ")
                            
                        }
                        if let itemPath = searchItemInfo["categoryPath"].string {
                            tempData[2] = ( " ", " ", itemPath , " "," ")
                            
                        }
                        if let thumbnail = searchItemInfo["thumbnailImage"].string {
                            tempData[3] = ( " ", " ", " " , thumbnail," ")
                        }
                        if let price     = searchItemInfo["salePrice"].double {
                            tempData[4] = ( " ", " ", " " , " ",String(stringInterpolationSegment: price))
                        }
                        
                        
                        CategoryList.sharedInstance.newCatArray.append(subCategoryList(name: tempData[0].0, id: tempData[1].1, path: tempData[2].2, thumbnail: tempData[3].3,aisle: 0,SalesPrice: tempData[4].4))
                        
  
                    }// end for loop
                    
                    
                }// end for in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.internetIndicator.stopAnimating()
                })
            } // end dataManager
            //Get specific item query search from Wal-Mart and SwiftyJSON
            
            
            
        }
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
  

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillDisappear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            
        })
    }
    

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         Return the number of rows in the section
 
       let x =  CategoryList.sharedInstance.newCatArray.count
        return x
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) 

        
cell.textLabel?.text = CategoryList.sharedInstance.newCatArray[indexPath.row].name
cell.detailTextLabel?.text = "$\(String(stringInterpolationSegment: CategoryList.sharedInstance.newCatArray[indexPath.row].SalesPrice))"

        
        if let url = NSURL(string: CategoryList.sharedInstance.newCatArray[indexPath.row].thumbnail) {
            if let data = NSData(contentsOfURL: url){
                cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                cell.imageView?.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let tempName = CategoryList.sharedInstance.newCatArray[indexPath.row].name
        let tempId = CategoryList.sharedInstance.newCatArray[indexPath.row].id
        let tempPath = CategoryList.sharedInstance.newCatArray[indexPath.row].path
        let tempThumb = CategoryList.sharedInstance.newCatArray[indexPath.row].thumbnail
        let tempPrice = CategoryList.sharedInstance.newCatArray[indexPath.row].SalesPrice
        
        ShoppingList.sharedInstance.currentShoppingList.append(ShopList(name: tempName, id: tempId, path: tempPath, Thumbmail: tempThumb,aisle: 0,SalesPrice: tempPrice))
        
        var tempNameArray = [String]()
        var tempIDArray = [String]()
        var tempPathArray = [String]()
        var tempThumbArray = [String]()
        var tempPriceArray = [String]()
        
        
        for item in ShoppingList.sharedInstance.currentShoppingList {
            
            tempNameArray.append(item.name)
            tempIDArray.append(item.id)
            tempPathArray.append(item.path)
            tempThumbArray.append(item.Thumbmail)
            tempPriceArray.append(item.SalesPrice)
            
        }
        
        let defaults  = NSUserDefaults.standardUserDefaults()
        
         defaults.setObject(tempNameArray, forKey: "SavedNames")
         defaults.setObject(tempIDArray, forKey: "SavedIDs")
         defaults.setObject(tempPathArray, forKey: "SavedPaths")
         defaults.setObject(tempThumbArray, forKey: "SavedThumbnails")
         defaults.setObject(tempPriceArray, forKey: "SavedPrices")
        
        
         defaults.synchronize()  // saved list
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
    
    
    
    
    @IBAction func spendSmartButton(sender: UIButton) {
        
        let newArr =  CategoryList.sharedInstance.newCatArray.sort { (lhs: subCategoryList, rhs: subCategoryList) -> Bool in
            // you can have additional code here
            
            let left = (lhs.SalesPrice as NSString).doubleValue
            let right = (rhs.SalesPrice as NSString).doubleValue
            
            return left < right
        }
        CategoryList.sharedInstance.newCatArray = newArr
        self.tableView.reloadInputViews()
        self.tableView.reloadData()
    }
    
    
    

}
