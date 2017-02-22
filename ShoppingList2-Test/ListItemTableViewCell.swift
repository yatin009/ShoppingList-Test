//
//  ListItemTableViewCell.swift
//  ShoppingList2-Test
//
//  Created by Yatin on 21/02/17.
//  Copyright © 2017 MAPD-124. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var listItemNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
