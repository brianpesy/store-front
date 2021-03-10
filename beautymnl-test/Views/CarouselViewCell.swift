//
//  CarouselViewCell.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/10/21.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {
    @IBOutlet weak var carouselImage: UIImageView!
    static let identifier = "CarouselViewCell"
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        contentView.addSubview(carouselImage)
//        
//        let images = [
//            UIImage(named: "carousel-1"),
//            UIImage(named: "carousel-2"),
//            UIImage(named: "carousel-3")
//        ]
//    }
//    
//    required init?(coder: NSCoder){
//        fatalError()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        carouselImage.frame = contentView.bounds
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
