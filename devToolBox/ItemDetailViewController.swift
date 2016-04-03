//
//  ItemDetailViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 2/22/16.
//  Copyright © 2016 Msen. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SafariServices

class ItemDetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var shortDescriptionTextView: UITextView!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var openWebSiteButton: UIButton!
    
    var sharedContext: NSManagedObjectContext = CoreDataStackManager.sharedInstance().managedObjectContext
    
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
        
        
        if let _ = self.item!.url {
            self.openWebSiteButton.hidden = false
        }
        
        
        // Adds a right bar button on the ItemDetailView (trash icon if the current tab is the favorite tab)
        let itemManager = ItemManager()
        itemManager.getFavoriteItems()
        if itemManager.isFavoriteItem(self.item!.name_slug!) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash , target: self, action: "removeFavorite")
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save , target: self, action: "saveFavorite")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        
    }
    
    @IBAction func openWebsite(sender: UIButton) {
        viewWebSite()
    }
    
    
    func saveFavorite() {
        self.item = convertItemToSharedContext(self.item!)
        self.saveSharedContext()
        showSavedAlertView()
    }
    
    func removeFavorite() {
        sharedContext.deleteObject(self.item!)
        self.saveSharedContext()
        self.navigationController?.popViewControllerAnimated(true)
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
    
    func saveSharedContext() {
        dispatch_async(dispatch_get_main_queue(), {
            do {
                try self.sharedContext.save()
            } catch let error as NSError {
                print("Error saving item.")
                print(error)
            }
        })
    }
    
    // Create an item for the current context
    func convertItemToSharedContext(item: Item) -> Item {
        
        var dictionary = [String:AnyObject]()
        
        dictionary["name"] = item.name
        dictionary["name_slug"] = item.name_slug
        dictionary["shortDescription"] = item.short_description
        dictionary["longDescription"] = item.long_description
        dictionary["url"] = item.url
        dictionary["thumbnail"] = item.thumbnail
        dictionary["accessType"] = item.accessType
        dictionary["itemType"] = item.itemType
        dictionary["mobileApps"] = item.mobileApps
        dictionary["screenshots"] = item.screenshots
        dictionary["tags"] = item.tags
        dictionary["createdAt"] = item.createdAt
        dictionary["updatedAt"] = item.updatedAt
        dictionary["viewsCount"] = item.viewsCount
        
        return Item(item: dictionary, context: self.sharedContext)

    }
    
    // Show Alert View when the item is saved.
    func showSavedAlertView() {
        let alertController = UIAlertController(title: "Favorite", message: "This item was saved in your favorite list", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}