//
//  Convenience.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/20/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import Foundation

extension Client {
    
    
    /* Perform login */
    func login(username: String, password: String, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        Client.sharedInstance.taskForPOSTMethod(Client.Constants.baseUrl + Client.Methods.login, parameters: nil, jsonBody: ["email": username, "password": password], completionHandler: { result, error in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: result, error: nil)
            }
        
        })
        
    }
    
    
    /* Retrieves a list of tools */
    func getRecentTools(page: Int, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        let parameters = [
            "page": String(page)
        ]
        
        Client.sharedInstance.taskForGETMethod(Client.Constants.baseUrl + Client.Methods.recentItems, parameters: parameters, completionHandler: { result, error in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: result, error: nil)
            }
        
        })
        
    }
    
}
