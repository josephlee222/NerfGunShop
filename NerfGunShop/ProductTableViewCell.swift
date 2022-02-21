//
//  ProductTableViewCell.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 16/2/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
