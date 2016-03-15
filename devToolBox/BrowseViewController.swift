//
//  BrowseViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/23/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import UIKit
import CoreData

enum Tab {
    case BrowseNavigationController, FavoritesNavigationController
}

class BrowseViewController: UITableViewController {
    
    @IBOutlet var itemsTable: UITableView!
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    var selectedTab: Tab? {
        if self.navigationController?.restorationIdentifier == "BrowseNavigationController" {
            return Tab.BrowseNavigationController
        }
        
        return Tab.FavoritesNavigationController
    }
    
    // The current page
    var page: Int = 1
    
    var items: [Item] = []
    var selectedItem: Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTable.dataSource = self
        itemsTable.delegate = self
        
        if selectedTab == Tab.BrowseNavigationController {
            self.loadItems()
        } else if selectedTab == Tab.FavoritesNavigationController {
            self.items = loadFavorites()
        }
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemTableViewCell
    
        if self.items.count == 0 {
            return cell
        }
        
        let item = self.items[indexPath.row]
        
        if (item.thumbnail != nil) {
            let url = NSURL(string: item.thumbnail!)
            getDataFromUrl(url!) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    
                    guard let data = data where error == nil else { return }
                    dispatch_async(dispatch_get_main_queue()) {
                        cell.thumbnailView!.image = UIImage(data: data)
                        cell.thumbnailView!.contentMode = .ScaleAspectFit
                        cell.thumbnailView!.clipsToBounds = true
                    }
                    
                }
            }

        }
        
        
        cell.nameLabel.text = item.name!
        cell.shortDescriptionLabel.text = item.short_description!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastRowIndex = tableView.numberOfRowsInSection(0)
        if indexPath.row == lastRowIndex - 1 {
            loadItems()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedItem = items[indexPath.row]
        
        performSegueWithIdentifier("showItem", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showItem") {
            let itemDetailView = segue.destinationViewController as! ItemDetailViewController
            itemDetailView.item = self.selectedItem
        }
    }
    
    // Load items from API
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
                        self.items.append(Item(item: result, context: self.sharedContext))
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
    
    // Load favorites from Core Data
    func loadFavorites() -> [Item] {
        
        var results = [Item]()
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        
        do {
            results = try sharedContext.executeFetchRequest(fetchRequest) as! [Item]
            print(results)
        } catch let error as NSError {
            print("Error fetching core data items")
            print(error)
        }
        
        return results
        
    }
    
    // Helper methods
    
    func downloadImage(url: NSURL) {
        
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
        
    }
    
}