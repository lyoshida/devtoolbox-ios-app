//
//  BrowseViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/23/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import UIKit

class BrowseViewController: UITableViewController {
    
    @IBOutlet var itemsTable: UITableView!
    
    // The current page
    var page: Int = 1
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTable.dataSource = self
        itemsTable.delegate = self
        
        self.loadItems()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemTableViewCell
        
        let item = self.items[indexPath.row]
        
        cell.nameLabel.text = item.name!
        cell.shortDescriptionLabel.text = item.shortDescription!
        
        return cell
    }
    
    func loadItems() {
        
        let params = [
            "page": page,
            "limit": 15
        ]
        
        Client.sharedInstance.taskForGETMethod(Client.Constants.baseUrl + Client.Methods.recentItems, parameters: params) { result, error in
            
            if error != nil {
                print(error)
            } else {
                if let results = result as? [[String: AnyObject]] {
                    for result in results {
                        self.items.append(Item(item: result))
                    }
                    self.page += 1
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.itemsTable.reloadData()
                    })
                } else {
                    print("Error parsing results.")
                }
            }
            
        }
    }
    
}