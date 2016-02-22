//
//  ItemDetailViewController.swift
//  devToolBox
//
//  Created by Luis Yoshida on 2/22/16.
//  Copyright © 2016 Msen. All rights reserved.
//

import Foundation
import UIKit


class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var shortDescriptionTextView: UITextView!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    
    var item: Item? = nil
    
    override func viewDidLoad() {
        
        
        if let item = self.item {
            self.title = item.name
            shortDescriptionTextView.text = item.short_description

            
            // source: http://stackoverflow.com/questions/2454067/display-html-text-in-uitextview
            let theAttributedString = try! NSAttributedString(data: item.long_description!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!,
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            
            longDescriptionTextView.attributedText = theAttributedString
        }
        
    }

}