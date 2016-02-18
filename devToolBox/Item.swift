//
//  Item.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/23/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)

class Item: NSManagedObject {
    
    @NSManaged var name: String?
    @NSManaged var name_slug: String?
    @NSManaged var short_description: String?
    @NSManaged var long_description: String?
    @NSManaged var url: String?
    @NSManaged var thumbnail: String?
    @NSManaged var accessType: String?
    @NSManaged var itemType: String?
    @NSManaged var mobileApps: [String]?
    @NSManaged var screenshots: [String]?
    @NSManaged var tags: [String]?
    @NSManaged var createdAt: NSDate?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var viewsCount: NSNumber
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(item: [String: AnyObject], context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        if let name = item["name"] as? String {
            self.name = name
        }
        
        if let name_slug = item["name_slug"] as? String {
            self.name_slug = name_slug
        }
        
        if let short_description = item["shortDescription"] as? String {
            self.short_description = short_description
        }
        
        if let long_description = item["longDescription"] as? String {
            self.long_description = long_description
        }
        
        if let url = item["url"] as? String {
            self.url = url
        }
        
        if let thumbnail = item["thumbnail"] as? String {
            self.thumbnail = thumbnail
        }
        
        if let accessType = item["accessType"] as? String {
            self.accessType = accessType
        }
        
        if let itemType = item["itemType"] as? String {
            self.itemType = itemType
        }
        
        if let mobileApps = item["mobileApps"] as? [String] {
            self.mobileApps = mobileApps
        }
        
        if let screenshots = item["screenshots"] as? [String] {
            self.screenshots = screenshots
        }
        
        if let tags = item["tags"] as? [String] {
            self.tags = tags
        }
        
        if let createdAt = item["createdAt"] as? NSDate {
            self.createdAt = createdAt
        }
        
        if let updatedAt = item["updatedAt"] as? NSDate {
            self.updatedAt = updatedAt
        }
        
        if let viewsCount = item["viewsCount"] as? Int {
            self.viewsCount = viewsCount
        }
        
        
    }
    
    
}