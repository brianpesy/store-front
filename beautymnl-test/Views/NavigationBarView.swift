//
//  NavigationBarView.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/10/21.
//

import UIKit

class NavigationBarView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var onSaleLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var skincareLabel: UILabel!
    @IBOutlet weak var makeupLabel: UILabel!
    @IBOutlet weak var bathAndBodyCareLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    

}
