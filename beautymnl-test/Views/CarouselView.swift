//
//  CarouselView.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/10/21.
//

import UIKit

class CarouselView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var carLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
