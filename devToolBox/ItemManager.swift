//
//  ItemManger.swift
//  devToolBox
//
//  Created by Luis Yoshida on 3/30/16.
//  Copyright © 2016 Msen. All rights reserved.
//

import Foundation
import CoreData

class ItemManager {
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    var favoriteItems: [Item] = []
    
    func getFavoriteItems() -> [Item] {
        
        var results = [Item]()
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        
        do {
            results = try sharedContext.executeFetchRequest(fetchRequest) as! [Item]
            self.favoriteItems = results
        } catch let error as NSError {
            print("Error fetching core data items")
            print(error)
        }
        
        
        return results
    }
    
    // Check if the item is in the favorites list
    func isFavoriteItem(name_slug: String) -> Bool {
        
        for item in favoriteItems {
            print(item.name_slug)
            if item.name_slug == name_slug {
                return true
            }
        }
        
        return false
        
    }
    

    
}