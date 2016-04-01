//
//  AboutViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/20/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController, SFSafariViewControllerDelegate  {
    
    @IBAction func openWebsite(sender: AnyObject) {
        let safariViewController = SFSafariViewController(URL: NSURL(string: "https://www.devtoolbox.co")!)
        presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}