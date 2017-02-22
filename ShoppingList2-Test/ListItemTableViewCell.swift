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
    @IBOutlet weak var quantityEditListner: UIButton!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func quantityEditActionListner(_ sender: UIButton) {
        var quant = Int(quantityLabel.text!)
        if(sender.titleLabel?.text == "+"){
            quant = (quant! + 1)
        }else {
            if(quant == 0 ){
                return
            }else{
                quant = (quant! - 1)
            }
        }
        quantityLabel.text = String(quant!)
    }

}
