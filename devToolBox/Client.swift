//
//  Client.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/20/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import Foundation

class Client {
    
    var sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext
    
    
    
    static let sharedInstance = Client()
}