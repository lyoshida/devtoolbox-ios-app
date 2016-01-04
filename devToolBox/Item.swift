//
//  Item.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/23/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import Foundation

struct Item {
    
    var name: String?
    var name_slug: String?
    var shortDescription: String?
    var longDescription: String?
    var url: String?
    var thumbnail: String?
    var accessType: String?
    var itemType: String?
    var mobileApps: [String]?
    var screenshots: [String]?
    var tags: [String]?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var viewsCount: Int?
    
    init(item: [String: AnyObject]) {
        
        if let name = item["name"] as? String {
            self.name = name
        }
        
        if let name_slug = item["name_slug"] as? String {
            self.name_slug = name_slug
        }
        
        if let shortDescription = item["shortDescription"] as? String {
            self.shortDescription = shortDescription
        }
        
        if let longDescription = item["longDescription"] as? String {
            self.longDescription = longDescription
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
        
//        if let plans = item["plans"] as? [AnyObject] {
//            self.plans = plans
//        }
        
        if let screenshots = item["screenshots"] as? [String] {
            self.screenshots = screenshots
        }
        
//        if let social = item["social"] as? [String] {
//            self.social = social
//        }
        
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