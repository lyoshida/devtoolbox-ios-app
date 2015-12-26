//
//  BrowseViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/23/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var itemsTable: UITableView!
    
    // The current page
    var page: Int = 1
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTable.dataSource = self
        itemsTable.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    func loadItems() {
        
        let params = [
            "page": page,
            "limit": 15
        ]
        
        Client.sharedInstance.taskForGETMethod(Client.Constants.baseUrl + Client.Methods.recentItems, parameters: params) { result, error in
            
            if let result = result as? [Item] {
                self.items = result
            } else {
                print("Error parsing results.")
            }
        }
    }
    
}