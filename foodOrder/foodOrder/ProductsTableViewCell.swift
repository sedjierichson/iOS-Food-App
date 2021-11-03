//
//  ProductsTableViewCell.swift
//  foodOrder
//
//  Created by Richson Sedjie on 08/10/21.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    var addToCartTapped : (()->())?
    var addTapped : (()->())?
    var minusTapped : (()->())?
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addQuantity: UIButton!
    @IBOutlet weak var minusQuantity: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    
    @IBAction func cartButton(_ sender: UIButton) {
        self.addToCartTapped?()
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        self.minusTapped?()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.addTapped?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
