//
//  CartTableViewCell.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 12/2/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productQty: UILabel!
    @IBOutlet var productPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
