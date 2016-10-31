//
//  RootViewController.swift
//  Fonts
//
// Created by Robert Herrera on 10/12/15.
//  Copyright (c) 2015 QuickShop All rights reserved.
//

import UIKit

class RootViewController: UITableViewController,UISearchBarDelegate {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"
    private var CategoryNames = "Food"
    private var SearchQuery: String!
 
    
 
    
    @IBOutlet weak var UserSearchQuery: UISearchBar!
    
    
    

    
    /*
    // Data that is obtained from API's
    // Current Font Screen Shall show available Category Paths that app offers
    // Category Paths sourced by file WalMartItemScope.json
    
    private var itemName : [String]
    private var itemInfo : String
    private var itemCategoryPath : String
    
    // 


*/

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UserSearchQuery.delegate = self
        
        familyNames = UIFont.familyNames().sort()
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        SearchQuery = searchBar.text
        print("\(SearchQuery)")
        self.performSegueWithIdentifier("BypassChoice", sender: searchBar)
    }
    
 
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNamesForFamilyName(familyName).first! as String
            return UIFont(name: fontName, size: cellPointSize)
        } else {
            return nil
        }
    }

    

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 1
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Category Paths"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // The font names list
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath)
            cell.textLabel?.text = CategoryNames
            
        
            cell.imageView?.image =  UIImage(named: "download")
            let delay = 4.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                cell.imageView?.image =  UIImage(named: "images")
            }
            dispatch_after(time, dispatch_get_main_queue()) {
                cell.imageView?.image =  UIImage(named: "images2")
            }
            
            

            return cell
        } else {
            // The favorites list
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell, forIndexPath: indexPath)
        }
    }
    
    // MARK: Navigation
    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        if segue.identifier == "NextStory" {
        //let listVC = segue.destinationViewController as! FontListViewController
        }
        else if segue.identifier == "BypassChoice"{
          let listVC = segue.destinationViewController as! FontSizesViewController
          listVC.bypassFlag = true
          listVC.NameSearchQuery = UserSearchQuery.text!
        }


    }// end Segue
}



