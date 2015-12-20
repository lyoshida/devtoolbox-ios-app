//
//  Convenience.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/20/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import Foundation

extension Client {
    
    
    func login(username: String, password: String, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        Client.sharedInstance.taskForPOSTMethod(Client.Constants.baseUrl + Client.Methods.login, parameters: nil, jsonBody: ["email": username, "password": password], completionHandler: { result, error in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: result, error: nil)
            }
        
        })
        
    }
    
}
