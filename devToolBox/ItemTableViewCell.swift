//
//  ItemTableViewCell.swift
//  devToolBox
//
//  Created by Luis Yoshida on 12/26/15.
//  Copyright © 2015 Msen. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.thumbnailView.frame = CGRectMake(0, 0, 100, 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func prepareForReuse() {
        thumbnailView.image = nil
    }
    
}
