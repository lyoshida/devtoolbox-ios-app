//
//  ItemDetailViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 2/22/16.
//  Copyright © 2016 Msen. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class ItemDetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var shortDescriptionTextView: UITextView!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var item: Item? = nil
    
    override func viewDidLoad() {
        
        
        if let item = self.item {
            
            if (item.thumbnail != nil) {
                let url = NSURL(string: item.thumbnail!)
                getDataFromUrl(url!) { (data, response, error)  in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        
                        guard let data = data where error == nil else { return }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.thumbnailImageView.image = UIImage(data: data)
                            self.thumbnailImageView.contentMode = .ScaleAspectFit
                            self.thumbnailImageView.clipsToBounds = true
                        }
                        
                    }
                }
                
            }

            
            self.title = item.name
            shortDescriptionTextView.text = item.short_description

            
            // source: http://stackoverflow.com/questions/2454067/display-html-text-in-uitextview
            
            if let longDescription = item.long_description {
            
                let theAttributedString = try! NSAttributedString(data: longDescription.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!,
                    options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                    documentAttributes: nil)
            
                longDescriptionTextView.attributedText = theAttributedString
            }
        }
        
        longDescriptionTextView.scrollRangeToVisible(NSMakeRange(-1, 0))
        
        
        // Adds a right bar button on the ItemDetailView
        if let _ = self.item!.url {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View website", style: .Plain, target: self, action: "viewWebSite")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    
    // Opens a Safari View
    func viewWebSite() {
        
        let safariViewController = SFSafariViewController(URL: NSURL(string: self.item!.url!)!)
        presentViewController(safariViewController, animated: true, completion: nil)
        
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}