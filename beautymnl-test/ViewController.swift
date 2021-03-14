//
//  ViewController.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/10/21.
//

import UIKit

let carouselCellIdentifier = "CarouselViewCell"
let productCollectionViewCellIdentifier = "ProductCollectionViewCell"

private var indexOfCellBeforeDragging = 0

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
    
    let trendingImages = [
        UIImage(named: "product-t-1"),
        UIImage(named: "product-t-2"),
        UIImage(named: "product-t-3"),
        UIImage(named: "product-t-4"),
        UIImage(named: "product-t-5"),
        UIImage(named: "product-t-6"),
        UIImage(named: "product-t-7"),
        UIImage(named: "product-t-8"),
        UIImage(named: "product-t-9"),
        UIImage(named: "product-t-10"),
        UIImage(named: "product-t-11"),
        UIImage(named: "product-t-12")
    ]
    
    let productReel2Images = [
        UIImage(named: "product-6"),
        UIImage(named: "product-7"),
        UIImage(named: "product-8")
    ]
    
    let featuredImages = [
        UIImage(named: "product-9"),
        UIImage(named: "product-10"),
        UIImage(named: "product-11"),
        UIImage(named: "product-12")
    ]
    
    var lastContentOffset = CGFloat()
    var scrollDir = UISwipeGestureRecognizer.Direction.left
    
    var timer = Timer()
    var timerCtr = 0
        
    // MARK: - Setting up Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var navBarView: NavigationBarView!
    @IBOutlet weak var carouselView: UICollectionView!
    @IBOutlet weak var carouselPageControl: UIPageControl!
    @IBOutlet weak var productHorizontalReelView1: ProductHorizontalReelView!
    @IBOutlet weak var trendingView: UICollectionView!
    @IBOutlet weak var trendingPageControl: UIPageControl!
    @IBOutlet weak var featuredBrandView: FeaturedBrandView!
    @IBOutlet weak var productHorizontalReelView2: ProductHorizontalReelView!
    @IBOutlet weak var featuredView: FeaturedView!
    
    
    // MARK: - Setting up Collection Views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.carouselView {
            return self.carouselImages.count
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        if collectionView == self.carouselView {
            let cell = carouselView.dequeueReusableCell(withReuseIdentifier: carouselCellIdentifier, for: indexPath) as! CarouselViewCell
            cell.carouselImage.image = carouselImages[indexPath.row % carouselImages.count]
            return cell
        } else {
            let cell = trendingView.dequeueReusableCell(withReuseIdentifier: productCollectionViewCellIdentifier, for: indexPath) as! ProductCollectionViewCell
            cell.productImage.image = trendingImages[indexPath.row % trendingImages.count]
            cell.productLabel.text = "Item \(String(indexPath.row % trendingImages.count))"
            
            var widthConstraint = NSLayoutConstraint(item: cell,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1,
                                                    constant: (screenWidth/3) - 33)
            var heightConstraint = NSLayoutConstraint(item: cell,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: 165)
            cell.addConstraints([widthConstraint, heightConstraint])

            widthConstraint = NSLayoutConstraint(item: cell.productImage,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1,
                                                    constant: (screenWidth/3) - 43)
            var centerXConstraint = NSLayoutConstraint(item: cell.productImage,
                                        attribute: .centerX,
                                        relatedBy: .equal,
                                        toItem: cell,
                                        attribute: .centerX,
                                        multiplier: 1,
                                        constant: 0)
            cell.addConstraints([widthConstraint])
            cell.addConstraints([centerXConstraint])

            widthConstraint = NSLayoutConstraint(item: cell.productLabel,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1,
                                                    constant: (screenWidth/3) - 43)
            centerXConstraint = NSLayoutConstraint(item: cell.productLabel,
                                        attribute: .centerX,
                                        relatedBy: .equal,
                                        toItem: cell,
                                        attribute: .centerX,
                                        multiplier: 1,
                                        constant: 0)
            cell.addConstraints([widthConstraint])
            cell.addConstraints([centerXConstraint])
            
            return cell
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.carouselView {
            setupAlert(title: "Button pressed", message: "Carousel \(indexPath.row)")
        } else {
            setupAlert(title: "Button pressed", message: "Trending \(indexPath.row)")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.carouselPageControl.currentPage = Int(roundedIndex)
        
        if scrollView == self.carouselView {
            if self.lastContentOffset > scrollView.contentOffset.x {
                self.scrollDir = UISwipeGestureRecognizer.Direction.left
//                print("left")
            }
            else if self.lastContentOffset < scrollView.contentOffset.x {
                self.scrollDir = UISwipeGestureRecognizer.Direction.right
//                print("right")
            }
            self.lastContentOffset = scrollView.contentOffset.x
        }
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
        
        if let indexPath = self.carouselView?.indexPathsForVisibleItems[0] {
            print(indexPath)
            if indexPath.row == 0 && self.scrollDir == UISwipeGestureRecognizer.Direction.left {
                       //hide the collection view
                print("asdlkfj")
                self.carouselView.scrollToItem(at: [0,2], at: .centeredHorizontally, animated: true )
                carouselPageControl?.currentPage = 0
            } else if indexPath.row == 2 && self.scrollDir == UISwipeGestureRecognizer.Direction.right {
                print("HIHI!")
                self.carouselView.scrollToItem(at: [0,0], at: .centeredHorizontally, animated: true )
                carouselPageControl?.currentPage = 2
            }
        }
        

    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        // scrolling by 6 cells for trending
        if scrollView == self.trendingView {
            
            targetContentOffset.pointee = scrollView.contentOffset
            var indexes = self.trendingView.indexPathsForVisibleItems
            indexes.sort()
            var index = indexes.first!
            let cell = self.trendingView.cellForItem(at: index)!
            let position = self.trendingView.contentOffset.x - cell.frame.origin.x
            //to scroll to the 6th index (6 in a page)
            if index.row >= 6 {
                index.row = 6
            } else if index.row <= 0 {
                index.row = 0
            }
            if position > cell.frame.size.width/2 {
                index.row = index.row + 6
                trendingPageControl.currentPage = 1
            } else if position < cell.frame.size.width {
                index.row = index.row - 6
                trendingPageControl.currentPage = 0
                if self.trendingView.contentOffset.x < screenWidth + 1 {
                    trendingPageControl.currentPage = 0
                } else {
                    trendingPageControl.currentPage = 1
                }
            }
            self.trendingView.scrollToItem(at: index, at: .centeredHorizontally, animated: true )
        }
        
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
    
    @objc func tapFeaturedBrand(_ sender: UITapGestureRecognizer) {
        setupAlert(title: "Button pressed", message: "Featured Brand")
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
        
        /// Carousel auto scroll timer
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
        }
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
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
        
        /// Featured Brands taps
        
        let featuredBrandTap = UITapGestureRecognizer(target: self, action: #selector(self.tapFeaturedBrand(_:)))
        featuredBrandView.addGestureRecognizer(featuredBrandTap)
        
        /// Product reel 2 taps
        let goToTap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapGoTo(_:)))
        productHorizontalReelView2.seeAllOutlet.addGestureRecognizer(goToTap2)
        
        let seeAllTap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapSeeAll(_:)))
        productHorizontalReelView2.seeAllView.isUserInteractionEnabled = true
        productHorizontalReelView2.seeAllView.addGestureRecognizer(seeAllTap2)
        
        let productReelTap21 = UITapGestureRecognizer(target: self, action: #selector(self.tapProductReel(_:)))
        let productReelTap22 = UITapGestureRecognizer(target: self, action: #selector(self.tapProductReel2(_:)))
        let productReelTap23 = UITapGestureRecognizer(target: self, action: #selector(self.tapProductReel3(_:)))

        productHorizontalReelView2.productView.addGestureRecognizer(productReelTap21)
        productHorizontalReelView2.productView2.addGestureRecognizer(productReelTap22)
        productHorizontalReelView2.productView3.addGestureRecognizer(productReelTap23)
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
        productHorizontalReelView1.productView.brandLabel.text = "HEALTHY CARS"
        productHorizontalReelView1.productView.nameLabel.text = "Electronic Car"
        productHorizontalReelView1.productView.priceLabel.text = "₱100000"
        productHorizontalReelView1.productView.star1.image = ratingImages[0]
        productHorizontalReelView1.productView.star2.image = ratingImages[0]
        productHorizontalReelView1.productView.star3.image = ratingImages[0]
        productHorizontalReelView1.productView.star4.image = ratingImages[0]
        productHorizontalReelView1.productView.star5.image = ratingImages[1]
        productHorizontalReelView1.productView.ratingNumberLabel.text = "7"
        
        productHorizontalReelView1.productView2.productImage.image = productReelImages[1]
        productHorizontalReelView1.productView2.brandLabel.text = "LOOT-ION"
        productHorizontalReelView1.productView2.nameLabel.text = "Hand Lotion"
        productHorizontalReelView1.productView2.priceLabel.text = "₱600"
        productHorizontalReelView1.productView2.star1.image = ratingImages[0]
        productHorizontalReelView1.productView2.star2.image = ratingImages[0]
        productHorizontalReelView1.productView2.star3.image = ratingImages[0]
        productHorizontalReelView1.productView2.star4.image = ratingImages[0]
        productHorizontalReelView1.productView2.star5.image = ratingImages[0]
        productHorizontalReelView1.productView2.ratingNumberLabel.text = "2311"
        
        productHorizontalReelView1.productView3.productImage.image = productReelImages[2]
        productHorizontalReelView1.productView3.brandLabel.text = "NICE CUPS"
        productHorizontalReelView1.productView3.nameLabel.text = "Red Cup"
        productHorizontalReelView1.productView3.priceLabel.text = "₱100"
        productHorizontalReelView1.productView3.star1.image = ratingImages[0]
        productHorizontalReelView1.productView3.star2.image = ratingImages[0]
        productHorizontalReelView1.productView3.star3.image = ratingImages[1]
        productHorizontalReelView1.productView3.star4.image = ratingImages[1]
        productHorizontalReelView1.productView3.star5.image = ratingImages[1]
        productHorizontalReelView1.productView3.ratingNumberLabel.text = "498"
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        let widthConstraint = NSLayoutConstraint(item: productHorizontalReelView1.seeAllOutlet,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: screenWidth-46)
        productHorizontalReelView1.seeAllOutlet.addConstraints([widthConstraint])

        let centerXConstraint = NSLayoutConstraint(item: productHorizontalReelView1.productReelLabel,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: productHorizontalReelView1,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        let centerXConstraintBtn = NSLayoutConstraint(item: productHorizontalReelView1.seeAllOutlet,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: productHorizontalReelView1,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        
        productHorizontalReelView1.addConstraints([centerXConstraint])
        productHorizontalReelView1.addConstraints([centerXConstraintBtn])
    }
    
    func setupProductCollectionViewCell() {
        self.trendingView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: productCollectionViewCellIdentifier)
        self.trendingView.delegate = self
        self.trendingView.dataSource = self
        trendingView.isUserInteractionEnabled = true
        trendingView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func setupFeaturedBrand(){
        featuredBrandView.featuredImage.layer.cornerRadius = 5.0
        featuredBrandView.featuredImage.layer.masksToBounds = true
    }
    
    func setupProductHorizontalReel2(){
        productHorizontalReelView2.productReelLabel.text = "Skincare bestsellers"
        
        productHorizontalReelView2.seeAllOutlet.layer.cornerRadius = 5
        productHorizontalReelView2.seeAllOutlet.layer.borderWidth = 1
        productHorizontalReelView2.seeAllOutlet.layer.borderColor = UIColor.black.cgColor
        
        productHorizontalReelView2.productView.productImage.image = productReel2Images[0]
        productHorizontalReelView2.productView.brandLabel.text = "DRINKS N MORE"
        productHorizontalReelView2.productView.nameLabel.text = "Crazy Whisky"
        productHorizontalReelView2.productView.priceLabel.text = "₱700000"
        productHorizontalReelView2.productView.star1.image = ratingImages[0]
        productHorizontalReelView2.productView.star2.image = ratingImages[0]
        productHorizontalReelView2.productView.star3.image = ratingImages[1]
        productHorizontalReelView2.productView.star4.image = ratingImages[1]
        productHorizontalReelView2.productView.star5.image = ratingImages[1]
        productHorizontalReelView2.productView.ratingNumberLabel.text = "3"
        
        productHorizontalReelView2.productView2.productImage.image = productReel2Images[1]
        productHorizontalReelView2.productView2.brandLabel.text = "SPRAYZ"
        productHorizontalReelView2.productView2.nameLabel.text = "Water Spray"
        productHorizontalReelView2.productView2.priceLabel.text = "₱100"
        productHorizontalReelView2.productView2.star1.image = ratingImages[0]
        productHorizontalReelView2.productView2.star2.image = ratingImages[0]
        productHorizontalReelView2.productView2.star3.image = ratingImages[0]
        productHorizontalReelView2.productView2.star4.image = ratingImages[0]
        productHorizontalReelView2.productView2.star5.image = ratingImages[1]
        productHorizontalReelView2.productView2.ratingNumberLabel.text = "357"
        
        productHorizontalReelView2.productView3.productImage.image = productReel2Images[2]
        productHorizontalReelView2.productView3.brandLabel.text = "Bottles"
        productHorizontalReelView2.productView3.nameLabel.text = "Perfume"
        productHorizontalReelView2.productView3.priceLabel.text = "₱1350"
        productHorizontalReelView2.productView3.star1.image = ratingImages[0]
        productHorizontalReelView2.productView3.star2.image = ratingImages[0]
        productHorizontalReelView2.productView3.star3.image = ratingImages[0]
        productHorizontalReelView2.productView3.star4.image = ratingImages[1]
        productHorizontalReelView2.productView3.star5.image = ratingImages[1]
        productHorizontalReelView2.productView3.ratingNumberLabel.text = "562"
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        let widthConstraint = NSLayoutConstraint(item: productHorizontalReelView2.seeAllOutlet,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: screenWidth-46)
        productHorizontalReelView2.seeAllOutlet.addConstraints([widthConstraint])

        let centerXConstraint = NSLayoutConstraint(item: productHorizontalReelView2.productReelLabel,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: productHorizontalReelView2,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        let centerXConstraintBtn = NSLayoutConstraint(item: productHorizontalReelView2.seeAllOutlet,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: productHorizontalReelView2,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        
        productHorizontalReelView2.addConstraints([centerXConstraint])
        productHorizontalReelView2.addConstraints([centerXConstraintBtn])
    }
    
    func setupFeaturedView() {
        featuredView.seeAllOutlet.layer.cornerRadius = 5
        featuredView.seeAllOutlet.layer.borderWidth = 1
        featuredView.seeAllOutlet.layer.borderColor = UIColor.black.cgColor
                
        featuredView.productView.productImage.image = featuredImages[0]
        featuredView.productView.brandLabel.text = "LOOT-ION"
        featuredView.productView.nameLabel.text = "Not-Kombucha"
        featuredView.productView.priceLabel.text = "₱130"
        featuredView.productView.star1.image = ratingImages[0]
        featuredView.productView.star2.image = ratingImages[0]
        featuredView.productView.star3.image = ratingImages[0]
        featuredView.productView.star4.image = ratingImages[0]
        featuredView.productView.star5.image = ratingImages[1]
        featuredView.productView.ratingNumberLabel.text = "74"
        
        featuredView.productView2.productImage.image = featuredImages[1]
        featuredView.productView2.brandLabel.text = "LOOT-ION"
        featuredView.productView2.nameLabel.text = "Floating Spray"
        featuredView.productView2.priceLabel.text = "₱400"
        featuredView.productView2.star1.image = ratingImages[0]
        featuredView.productView2.star2.image = ratingImages[0]
        featuredView.productView2.star3.image = ratingImages[0]
        featuredView.productView2.star4.image = ratingImages[0]
        featuredView.productView2.star5.image = ratingImages[1]
        featuredView.productView2.ratingNumberLabel.text = "329"

        featuredView.productView3.productImage.image = featuredImages[2]
        featuredView.productView3.brandLabel.text = "LOOT-ION"
        featuredView.productView3.nameLabel.text = "Grapes (1kg)"
        featuredView.productView3.priceLabel.text = "₱100"
        featuredView.productView3.star1.image = ratingImages[0]
        featuredView.productView3.star2.image = ratingImages[0]
        featuredView.productView3.star3.image = ratingImages[0]
        featuredView.productView3.star4.image = ratingImages[1]
        featuredView.productView3.star5.image = ratingImages[1]
        featuredView.productView3.ratingNumberLabel.text = "93"
        
        featuredView.productView4.productImage.image = featuredImages[3]
        featuredView.productView4.brandLabel.text = "LOOT-ION"
        featuredView.productView4.nameLabel.text = "Lens Container"
        featuredView.productView4.priceLabel.text = "₱450"
        featuredView.productView4.star1.image = ratingImages[0]
        featuredView.productView4.star2.image = ratingImages[0]
        featuredView.productView4.star3.image = ratingImages[0]
        featuredView.productView4.star4.image = ratingImages[0]
        featuredView.productView4.star5.image = ratingImages[1]
        featuredView.productView4.ratingNumberLabel.text = "52"
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        let widthConstraint = NSLayoutConstraint(item: featuredView.seeAllOutlet,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: screenWidth-46)
        featuredView.seeAllOutlet.addConstraints([widthConstraint])

        var centerXConstraint = NSLayoutConstraint(item: featuredView.featuredLabel,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: featuredView,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        featuredView.addConstraints([centerXConstraint])

        centerXConstraint = NSLayoutConstraint(item: featuredView.featuredBrandLabel,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: featuredView,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        featuredView.addConstraints([centerXConstraint])

        centerXConstraint = NSLayoutConstraint(item: featuredView.featuredBrandImage,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: featuredView,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        featuredView.addConstraints([centerXConstraint])

        let centerXConstraintBtn = NSLayoutConstraint(item: featuredView.seeAllOutlet,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: featuredView,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
        
        featuredView.addConstraints([centerXConstraintBtn])
    }
    
    // MARK: - Functions
    
    @objc func autoScroll() {
        if timerCtr < carouselImages.count {
            let index = IndexPath.init(item: timerCtr, section: 0)
            self.carouselView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            timerCtr += 1
        } else {
            timerCtr = 0
            let index = IndexPath.init(item: timerCtr, section: 0)
            self.carouselView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            timerCtr = 1
        }
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTaps()
        setupCarousel()
        setupProductHorizontalReel1()
        setupProductCollectionViewCell()
        setupFeaturedBrand()
        setupProductHorizontalReel2()
        setupFeaturedView()
    }
    
}
