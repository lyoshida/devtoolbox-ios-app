//
//  FavoritesViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 3/14/16.
//  Copyright © 2016 Msen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FavoritesViewController: UIViewController {
    
//    var sharedContext: NSManagedObjectContext {
//        return CoreDataStackManager.sharedInstance().managedObjectContext
//    }
//    
//    // The current page
//    var page: Int = 1
//    
//    var items: [Item] = []
//    var selectedItem: Item? = nil
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        itemsTable.dataSource = self
//        itemsTable.delegate = self
//        
//        self.loadItems()
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.items.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemTableViewCell
//        
//        
//        
//        let item = self.items[indexPath.row]
//        
//        if (item.thumbnail != nil) {
//            let url = NSURL(string: item.thumbnail!)
//            getDataFromUrl(url!) { (data, response, error)  in
//                dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                    
//                    guard let data = data where error == nil else { return }
//                    dispatch_async(dispatch_get_main_queue()) {
//                        cell.thumbnailView!.image = UIImage(data: data)
//                        cell.thumbnailView!.contentMode = .ScaleAspectFit
//                        cell.thumbnailView!.clipsToBounds = true
//                    }
//                    
//                }
//            }
//            
//        }
//        
//        
//        cell.nameLabel.text = item.name!
//        cell.shortDescriptionLabel.text = item.short_description!
//        
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        let lastRowIndex = tableView.numberOfRowsInSection(0)
//        if indexPath.row == lastRowIndex - 1 {
//            loadItems()
//        }
//    }

    
}