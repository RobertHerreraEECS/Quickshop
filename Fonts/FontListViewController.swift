//
//  FontListViewController.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import UIKit


struct ShopList {
    var name: String
    var id: String
    var path: String
    var Thumbmail: String
    var aisle = 0
    var SalesPrice : String
}

struct subCategoryList {
    var name: String
    var id: String
    var path: String
    var thumbnail: String
    var aisle = 0
    var SalesPrice : String
}


class FontListViewController: UITableViewController {
    
    
    @IBOutlet weak var UserSelectedCell: UITableViewCell!
    var fontNames: [String] = []
    var showsFavorites : Bool = false
    private var cellPointSize: CGFloat!
    private let cellIdentifier = "FontName"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return updateManager().FoodCategoriesFirst.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        
        cell.textLabel?.text = Array(updateManager().FoodCategoriesFirst.keys)[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showsFavorites
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            if !showsFavorites {
                return
            }
            
            if editingStyle == UITableViewCellEditingStyle.Delete {
                // Delete the row from the data source
                
                
                tableView.deleteRowsAtIndexPaths([indexPath],
                    withRowAnimation: UITableViewRowAnimation.Fade)
                
                
            }
            
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Get specific item query search from Wal-Mart and SwiftyJSON
    }
    
    
    // MARK: Navigation
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
        //LoadWalMartCategoryPath.PurgeCurrentItemPath()
        
        let selectedRow = selectedIndex?.row
        //updateManager.updateFetchedItemList()
        let sizesVC =  segue.destinationViewController as! FontSizesViewController
        sizesVC.title = " "
        sizesVC.recievedInt = selectedRow!
        
        sizesVC.reloadInputViews()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //self.tableView.reloadData()
            sizesVC.tableView.reloadData()
        })
        
    }// Seguey
    
}
