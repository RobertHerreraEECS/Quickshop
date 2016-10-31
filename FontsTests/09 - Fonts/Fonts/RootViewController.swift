//
//  RootViewController.swift
//  Fonts
//
//  Created by Kim Topley on 10/12/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"
    private var CategoryNames = ["Food","Houshold Essentials"]
    
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
        
        familyNames = sorted(UIFont.familyNames() as! [String])
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNamesForFamilyName(familyName).first as! String
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
        return 2
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Category Paths"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // The font names list
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = CategoryNames[indexPath.row]

            return cell
        } else {
            // The favorites list
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell, forIndexPath: indexPath) as! UITableViewCell
        }
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
}

