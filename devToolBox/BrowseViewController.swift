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
        
        if (item.thumbnail != nil) {
            let url = NSURL(string: item.thumbnail!)
            getDataFromUrl(url!) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    cell.imageView!.image = UIImage(data: data)
                    
                    cell.imageView!.frame = CGRectMake(50, 50, 100, 100)
                    cell.imageView!.center = CGPoint(x: 50, y: 50)
                    
                    cell.imageView!.frame = (cell.imageView?.bounds)!
                    cell.contentMode = .ScaleAspectFit
                    cell.imageView!.contentMode = .ScaleAspectFit
                }
            }

        }
        
        
        cell.nameLabel.text = item.name!
        cell.shortDescriptionLabel.text = item.shortDescription!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastRowIndex = tableView.numberOfRowsInSection(0)
        if indexPath.row == lastRowIndex - 1 {
            loadItems()
        }
    }
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
            }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
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