//
//  ProductHorizontalReelView.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/11/21.
//

import UIKit

class ProductHorizontalReelView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var seeAllOutlet: UIButton!
    @IBOutlet weak var productReelLabel: UILabel!
    @IBOutlet weak var productView: ProductView!
    @IBOutlet weak var productView2: ProductView!
    @IBOutlet weak var productView3: ProductView!
    @IBOutlet weak var seeAllView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ProductHorizontalReelView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
