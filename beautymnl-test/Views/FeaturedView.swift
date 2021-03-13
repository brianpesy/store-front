//
//  FeaturedView.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/13/21.
//

import UIKit

class FeaturedView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var featuredBrandLabel: UILabel!
    @IBOutlet weak var featuredBrandImage: UIImageView!
    @IBOutlet weak var productView: ProductView!
    @IBOutlet weak var productView2: ProductView!
    @IBOutlet weak var productView3: ProductView!
    @IBOutlet weak var productView4: ProductView!
    @IBOutlet weak var seeAllOutlet: UIButton!
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
        Bundle.main.loadNibNamed("FeaturedView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
