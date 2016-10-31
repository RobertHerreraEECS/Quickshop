//
//  ItemListViewController.swift
//  Fonts
//
//  Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import UIKit






class ItemListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var TableViewItem: UITableView!
    @IBOutlet weak var guideSwitch: UISwitch!
    @IBOutlet weak var aisleNumber: UILabel!
    @IBOutlet weak var aisleNumberLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    var startIndex = 0
    @IBOutlet weak var priceLabel: UILabel!
    
    let cellIdentifier = "ItemCell"
    
     var RecievedArray = [ShopList]()
     var copyList = [ShopList]()

    var x: String = " "
    var y: String = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        guideSwitch.on = false
        aisleNumber.hidden = true
        aisleNumberLabel.hidden = true
        priceLabel.hidden = true
        // Do any additional setup after loading the view.
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        
        itemImage.addGestureRecognizer(leftSwipe)
        itemImage.addGestureRecognizer(rightSwipe)
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        guard let nameArray = defaults.objectForKey("SavedNames") else { return }
        guard let idArray = defaults.objectForKey("SavedIDs") else { return }
        guard let pathArray = defaults.objectForKey("SavedPaths") else { return }
        guard let thumbArray = defaults.objectForKey("SavedThumbnails") else { return }
        guard let priceArray = defaults.objectForKey("SavedPrices") else { return }
        
        
        ShoppingList.sharedInstance.currentShoppingList.removeAll()
        
        for (i,_) in  (nameArray as! [String]).enumerate() {
            
            let tempName = nameArray[i] as! String
            let tempId = idArray[i] as! String
            let tempPath = pathArray[i] as! String
            let tempThumb = thumbArray[i] as! String
            let tempPrice = priceArray[i] as! String
            
            ShoppingList.sharedInstance.currentShoppingList.append(ShopList(name: tempName, id: tempId, path: tempPath, Thumbmail: tempThumb,aisle: 0,SalesPrice: tempPrice))
            
        }
        
        var total = 0.00
        for var i = 0;i < ShoppingList.sharedInstance.currentShoppingList.count; i++ {
            
         let temp = ShoppingList.sharedInstance.currentShoppingList[i].SalesPrice
         let temp2 = (temp as NSString).doubleValue
         total += temp2
        }
        total = total*(1.0825)
        priceLabel.hidden = false
        priceLabel.text = String(format: "%.2f", total)
        
        
        defaults.synchronize()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        guard let nameArray = defaults.objectForKey("SavedNames") else { return }
        guard let idArray = defaults.objectForKey("SavedIDs") else { return }
        guard let pathArray = defaults.objectForKey("SavedPaths") else { return }
        guard let thumbArray = defaults.objectForKey("SavedThumbnails") else { return }
        guard let priceArray = defaults.objectForKey("SavedPrices") else { return }
        
        
        ShoppingList.sharedInstance.currentShoppingList.removeAll()
        
        for (i,_) in  (nameArray as! [String]).enumerate() {
            
            let tempName = nameArray[i] as! String
            let tempId = idArray[i] as! String
            let tempPath = pathArray[i] as! String
            let tempThumb = thumbArray[i] as! String
            let tempPrice = priceArray[i] as! String
            
            ShoppingList.sharedInstance.currentShoppingList.append(ShopList(name: tempName, id: tempId, path: tempPath, Thumbmail: tempThumb,aisle: 0,SalesPrice: tempPrice))
            
        }
        
        
        defaults.synchronize()
    }
    override func viewWillDisappear(animated: Bool) {
        
        
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

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        
        if(sender.direction == .Left){
            shoppingGuide()
        }
        if(sender.direction == .Right){
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingList.sharedInstance.currentShoppingList.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) 
        
        cell.textLabel?.text = ShoppingList.sharedInstance.currentShoppingList[indexPath.row].name
        
        
        if let url = NSURL(string: ShoppingList.sharedInstance.currentShoppingList[indexPath.row].Thumbmail) {
            if let data = NSData(contentsOfURL: url){
                cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
        let passLabel = ShoppingList.sharedInstance.currentShoppingList[indexPath.row].path
        aisleAlgorithm(string: passLabel, passedIndex: indexPath.row).checkAisle()
        
  
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            ShoppingList.sharedInstance.currentShoppingList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
            
            var total = 0.00
            for var i = 0;i < ShoppingList.sharedInstance.currentShoppingList.count; i++ {
                
                let temp = ShoppingList.sharedInstance.currentShoppingList[i].SalesPrice
                let temp2 = (temp as NSString).doubleValue
                total += temp2
            }
            total = total*(1.0825)
            priceLabel.hidden = false
            priceLabel.text = String(format: "%.2f", total)
            
            
            
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
            
        }
    }

    @IBAction func beginShop(sender: UISwitch) {
        if sender.on == true {
         aisleNumber.hidden = false
        aisleNumberLabel.hidden = false
      
       shoppingGuide()
            
            
            
            
        } else {
            
            
            aisleNumber.hidden = true
            aisleNumberLabel.hidden = true
            startIndex = 0
            
            for var k = 0; k < ShoppingList.sharedInstance.currentShoppingList.count; k++ {
                TableViewItem.cellForRowAtIndexPath(NSIndexPath(forItem: k, inSection: 0))?.backgroundColor = UIColor.whiteColor()
            }
            
            
        }
    }
    
    func reorderTableCells (){
       
    }
    
    @IBAction func deleteCurrentShoppingList(sender: UIButton) {

        let uiAlert = UIAlertController(title: "Shopping List", message: "Are you sure you want to delete your list?", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { action in
            ShoppingList.sharedInstance.currentShoppingList.removeAll(keepCapacity: false)
            
            
            
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
            
            defaults.removeObjectForKey("SavedNames")
            defaults.removeObjectForKey("SavedIDs")
            defaults.removeObjectForKey("SavedPaths")
            defaults.removeObjectForKey("SavedThumbnails")
            defaults.removeObjectForKey("SavedPrices")
            
            defaults.synchronize()  // saved list
            
            
            
            
            
            self.TableViewItem.reloadData()
            self.guideSwitch.on = false
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            return
        }))
       priceLabel.text = "0.00"
        
    }
    
    
    
    func shoppingGuide() {
        
        if PreferredStore.sharedInstance.preferredStore.isEmpty == true {
            let title = "My Store"
            let message = "Please choose a store to load store guide."
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
            alert.addAction(okayButton)
            
            self.presentViewController(alert, animated: true, completion: nil)
            guideSwitch.on = false
            aisleNumber.hidden = true
            
            return
            
        }
        
        if ShoppingList.sharedInstance.currentShoppingList.isEmpty == true {
            let title = "Shopping List"
            let message = "List is empty. Please build list to continue."
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
            alert.addAction(okayButton)
            
            self.presentViewController(alert, animated: true, completion: nil)
            guideSwitch.on = false
            aisleNumber.hidden = true
            
            return
            
        }
     
    

        let newArr = ShoppingList.sharedInstance.currentShoppingList.sort { (lhs: ShopList, rhs: ShopList) -> Bool in
            // you can have additional code here
            
            return lhs.aisle < rhs.aisle
        }
        ShoppingList.sharedInstance.currentShoppingList = newArr
        
        if startIndex >= (ShoppingList.sharedInstance.currentShoppingList.count) {
            let title = "Shopping Complete"
            var message = " "
            
            if ShoppingList.sharedInstance.currentShoppingList.count <= 20 {
                message = "Proceed to 20 items or less cashier"
            } else {
                message = "Proceed to cashier"
            }
            
            
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okayButton = UIAlertAction(title: okText, style: .Cancel, handler: nil)
            alert.addAction(okayButton)
            
            self.presentViewController(alert, animated: true, completion: nil)
            guideSwitch.on = false
            aisleNumber.hidden = true
            
            return
        }
        
        
       aisleNumber.text = String(ShoppingList.sharedInstance.currentShoppingList[startIndex].aisle)
        
        if ShoppingList.sharedInstance.currentShoppingList[startIndex].aisle == 0 {
            aisleNumber.text = "Aisle Not Found" 
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.TableViewItem.reloadData()
            self.TableViewItem.reloadInputViews()
        })

 
        TableViewItem.reloadData()

        if startIndex == 0 {
           TableViewItem.cellForRowAtIndexPath(NSIndexPath(forItem: startIndex, inSection: 0))?.backgroundColor = UIColor.greenColor()
        }
        else {
            
             TableViewItem.cellForRowAtIndexPath(NSIndexPath(forItem: (startIndex-1), inSection: 0))?.backgroundColor = UIColor.whiteColor()
            
               TableViewItem.cellForRowAtIndexPath(NSIndexPath(forItem: startIndex, inSection: 0))?.backgroundColor = UIColor.greenColor()
        }
        
        
        if let url = NSURL(string: ShoppingList.sharedInstance.currentShoppingList[startIndex].Thumbmail) {
            if let data = NSData(contentsOfURL: url){
                itemImage.contentMode = UIViewContentMode.ScaleAspectFit
                itemImage.image = UIImage(data: data)
            }
        }
       startIndex++
        
    }
    

}


