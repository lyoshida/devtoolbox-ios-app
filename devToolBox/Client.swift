//
//  Client.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/20/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import Foundation

class Client: NSObject {
    
    var session: NSURLSession
    var sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext
    
    var token: String?
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    static let sharedInstance = Client()
    
    
    func taskForGETMethod(url: String, parameters: [String: AnyObject]?, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // Build the URL
        var urlString : String
        if let params = parameters {
            urlString = "\(url)\(Client.escapedParameters(params))"
        } else {
            urlString = "\(url)"
        }
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        
        let task = session.dataTaskWithRequest(request) { data, response, downloadError in
            
            if let error = downloadError {
                
                completionHandler(result: nil, error: error)
                print("Error in GET request. URL: \(url)")
                print(parameters)
                
            } else {
                Client.parseJSONWithCompletionHandler(data!, removeStart: true, completionHandler: completionHandler)
            }
        }
        
        task.resume()
        
        return task
        
    }
    
    func taskForPOSTMethod(url: String, parameters: [String: AnyObject]?, jsonBody: [String: AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // Build the URL
        var urlString : String
        if let params = parameters {
            urlString = "\(url)\(Client.escapedParameters(params))"
        } else {
            urlString = "\(url)"
        }
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        
        // Request setup
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonBody, options: [])
        } catch let error as NSError {
            completionHandler(result: nil, error: error)
        }
        
        // Make the request
        let task = session.dataTaskWithRequest(request) { data, response, downloadError in
            
            if let error = downloadError {
                
                completionHandler(result: nil, error: downloadError)
                
            } else {
                
                Client.parseJSONWithCompletionHandler(data!, removeStart: true, completionHandler: completionHandler)
                
            }
        }
        
        task.resume()
        
        return task
        
    }

    
    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
        
    }
    
    /* Helper: Given raw JSON, return a usable Foundation object */
    class func parseJSONWithCompletionHandler(data: NSData, removeStart: Bool, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        do {
            let parsedResult: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            
            completionHandler(result: parsedResult, error: nil)
        } catch let error as NSError {
            print("Error parsing JSON.")
            completionHandler(result: nil, error: error)
        }
        
    }

    
}