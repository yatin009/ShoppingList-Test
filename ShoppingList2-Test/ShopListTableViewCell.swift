//
//  ShopListTableViewCell.swift
//  ShoppingList2-Test
//
//  Created by Yatin on 21/02/17.
//  Copyright © 2017 MAPD-124. All rights reserved.
//

import UIKit

class ShopListTableViewCell: UITableViewCell {

    @IBOutlet weak var shopListNameLabel: UILabel!
    @IBOutlet weak var newListNameLabel: UILabel!
//    @IBOutlet weak var shopListDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
