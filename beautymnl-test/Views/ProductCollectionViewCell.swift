//
//  ProductCollectionViewCell.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/11/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    static let identifier = "ProductCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
