//
//  ViewController.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/10/21.
//

import UIKit

let carouselCellIdentifier = "CarouselViewCell"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variable Delcaration
    let carouselImages = [
        UIImage(named: "carousel-1"),
        UIImage(named: "carousel-2"),
        UIImage(named: "carousel-3")
    ]
    
    let productReelImages = [
        UIImage(named: "product-2"),
        UIImage(named: "product-3"),
        UIImage(named: "product-4")
    ]
    
    let ratingImages = [
        UIImage(named: "rating-full"),
        UIImage(named: "rating-empty")
    ]
    
    // MARK: - Setting up Outlets
    @IBOutlet weak var navBarView: NavigationBarView!
    @IBOutlet weak var carouselView: UICollectionView!
    @IBOutlet weak var carouselPageControl: UIPageControl!
    @IBOutlet weak var productHorizontalReelView1: ProductHorizontalReelView!
    
    // MARK: - Setting up Collection Views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carouselImages.count
        //return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = carouselView.dequeueReusableCell(withReuseIdentifier: carouselCellIdentifier, for: indexPath) as! CarouselViewCell
        cell.carouselImage.image = carouselImages[indexPath.row % carouselImages.count]
//        carouselPageControl.currentPage = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setupAlert(title: "Button pressed", message: "Carousel \(indexPath.row)")

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.carouselPageControl.currentPage = Int(roundedIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.carouselView.scrollToNearestVisibleCollectionViewCell()
        carouselPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.carouselView.scrollToNearestVisibleCollectionViewCell()
        }
        carouselPageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)

    }
    
    
    //MARK: - Setting up Actions
    @IBAction func shopBtn(_ sender: Any) {
        setupAlert(title: "Button pressed", message: "Shop button")
    }
    
    //MARK: - Setting up Gesture Recognizer Actions
    @objc func tapNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar")
     }
    
    @objc func tapHomeNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar - Home! This is to show that it's possible to tap each individual label")
     }
    
    @objc func tapSaleNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar - On Sale! This is to show that it's possible to tap each individual label")
     }
    
    @objc func tapHealthNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar - Health! This is to show that it's possible to tap each individual label")
     }
    
    @objc func tapSkincareNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar - Skincare! This is to show that it's possible to tap each individual label")
     }
    
    @objc func tapMakeupNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar - Makeup! This is to show that it's possible to tap each individual label")
     }
    
    @objc func tapBBNavBar(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Nav bar - Bath and Body! This is to show that it's possible to tap each individual label")
     }
    
    @objc func hideKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func tapGoTo(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Go to")
    }
    
    @objc func tapSeeAll(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "See all")
    }
    
    @objc func tapProductReel(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Product reel - 1")
    }
    
    @objc func tapProductReel2(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Product reel - 2")
    }
    
    @objc func tapProductReel3(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Product reel - 3")
    }
    
    //MARK: - Tap Setup
    func setupTaps(){
        
        /// Keyboard dismiss
        //dismisses the keyboard when tapping anywhere
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)
        hideKeyboardTap.cancelsTouchesInView = false

        /// Nav Bar taps
        
        //shows an alert when tapping the navigation bar
        let navBarTap = UITapGestureRecognizer(target: self, action: #selector(self.tapNavBar(_:)))
        let navBarTapHome = UITapGestureRecognizer(target: self, action: #selector(self.tapHomeNavBar(_:)))
        let navBarTapSale = UITapGestureRecognizer(target: self, action: #selector(self.tapSaleNavBar(_:)))
        let navBarTapHealth = UITapGestureRecognizer(target: self, action: #selector(self.tapHealthNavBar(_:)))
        let navBarTapSkincare = UITapGestureRecognizer(target: self, action: #selector(self.tapSkincareNavBar(_:)))
        let navBarTapMakeup = UITapGestureRecognizer(target: self, action: #selector(self.tapMakeupNavBar(_:)))
        let navBarTapBB = UITapGestureRecognizer(target: self, action: #selector(self.tapBBNavBar(_:)))

        
        //shows we can tap individual labels
        navBarView.homeLabel.isUserInteractionEnabled = true
        navBarView.homeLabel.addGestureRecognizer(navBarTapHome)
        
        navBarView.onSaleLabel.isUserInteractionEnabled = true
        navBarView.onSaleLabel.addGestureRecognizer(navBarTapSale)
        
        navBarView.healthLabel.isUserInteractionEnabled = true
        navBarView.healthLabel.addGestureRecognizer(navBarTapHealth)
        
        navBarView.skincareLabel.isUserInteractionEnabled = true
        navBarView.skincareLabel.addGestureRecognizer(navBarTapSkincare)
        
        navBarView.makeupLabel.isUserInteractionEnabled = true
        navBarView.makeupLabel.addGestureRecognizer(navBarTapMakeup)
        
        navBarView.bathAndBodyCareLabel.isUserInteractionEnabled = true
        navBarView.bathAndBodyCareLabel.addGestureRecognizer(navBarTapBB)
        
        /// Product reel 1 taps
        
        let goToTap = UITapGestureRecognizer(target: self, action: #selector(self.tapGoTo(_:)))
        productHorizontalReelView1.seeAllOutlet.addGestureRecognizer(goToTap)
        
        let seeAllTap = UITapGestureRecognizer(target: self, action: #selector(self.tapSeeAll(_:)))
        productHorizontalReelView1.seeAllView.isUserInteractionEnabled = true
        productHorizontalReelView1.seeAllView.addGestureRecognizer(seeAllTap)
        
        let productReelTap = UITapGestureRecognizer(target: self, action: #selector(self.tapProductReel(_:)))
        let productReelTap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapProductReel2(_:)))
        let productReelTap3 = UITapGestureRecognizer(target: self, action: #selector(self.tapProductReel3(_:)))

        productHorizontalReelView1.productView.addGestureRecognizer(productReelTap)
        productHorizontalReelView1.productView2.addGestureRecognizer(productReelTap2)
        productHorizontalReelView1.productView3.addGestureRecognizer(productReelTap3)
    }

    //MARK: - Functions
    func setupCarousel() {
        self.carouselView.register(UINib(nibName: "CarouselViewCell", bundle: nil), forCellWithReuseIdentifier: carouselCellIdentifier)
        self.carouselView.delegate = self
        self.carouselView.dataSource = self
        carouselView.isUserInteractionEnabled = true
        carouselView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func setupAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupProductHorizontalReel1(){
        productHorizontalReelView1.seeAllOutlet.layer.cornerRadius = 5
        productHorizontalReelView1.seeAllOutlet.layer.borderWidth = 1
        productHorizontalReelView1.seeAllOutlet.layer.borderColor = UIColor.black.cgColor
        
        productHorizontalReelView1.productView.productImage.image = productReelImages[0]
        productHorizontalReelView1.productView.brandLabel.text = "Healthy Cars"
        productHorizontalReelView1.productView.nameLabel.text = "Electronic Car"
        productHorizontalReelView1.productView.priceLabel.text = "₱100000"
        productHorizontalReelView1.productView.star1.image = ratingImages[0]
        productHorizontalReelView1.productView.star2.image = ratingImages[0]
        productHorizontalReelView1.productView.star3.image = ratingImages[0]
        productHorizontalReelView1.productView.star4.image = ratingImages[0]
        productHorizontalReelView1.productView.star5.image = ratingImages[1]
        productHorizontalReelView1.productView.ratingNumberLabel.text = "7"
        
        productHorizontalReelView1.productView2.productImage.image = productReelImages[1]
        productHorizontalReelView1.productView2.brandLabel.text = "Loot-ion"
        productHorizontalReelView1.productView2.nameLabel.text = "Hand Lotion"
        productHorizontalReelView1.productView2.priceLabel.text = "₱600"
        productHorizontalReelView1.productView2.star1.image = ratingImages[0]
        productHorizontalReelView1.productView2.star2.image = ratingImages[0]
        productHorizontalReelView1.productView2.star3.image = ratingImages[0]
        productHorizontalReelView1.productView2.star4.image = ratingImages[0]
        productHorizontalReelView1.productView2.star5.image = ratingImages[0]
        productHorizontalReelView1.productView2.ratingNumberLabel.text = "2311"
        
        productHorizontalReelView1.productView3.productImage.image = productReelImages[2]
        productHorizontalReelView1.productView3.brandLabel.text = "Nice Cups"
        productHorizontalReelView1.productView3.nameLabel.text = "Red Cup"
        productHorizontalReelView1.productView3.priceLabel.text = "₱100"
        productHorizontalReelView1.productView3.star1.image = ratingImages[0]
        productHorizontalReelView1.productView3.star2.image = ratingImages[0]
        productHorizontalReelView1.productView3.star3.image = ratingImages[1]
        productHorizontalReelView1.productView3.star4.image = ratingImages[1]
        productHorizontalReelView1.productView3.star5.image = ratingImages[1]
        productHorizontalReelView1.productView3.ratingNumberLabel.text = "498"

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTaps()
        setupCarousel()
        setupProductHorizontalReel1()
        
    }
    
}

