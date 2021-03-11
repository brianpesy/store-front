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
    
    // MARK: - Setting up Outlets
    @IBOutlet weak var navBarView: NavigationBarView!
    @IBOutlet weak var carouselView: UICollectionView!
    @IBOutlet weak var carouselPageControl: UIPageControl!
    
    
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
    
    //MARK: - Tap Setup
    func setupTaps(){
        //dismisses the keyboard when tapping anywhere
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)
        hideKeyboardTap.cancelsTouchesInView = false

//        navBarView.homeLabel.text = "hel"
//        navBarView.homeLabel.textColor = UIColor.red
//        navBarView.homeLabel.isUserInteractionEnabled = true
//        navBarView.homeLabel.isEnabled = true
//        navBarView.homeLabel.addGestureRecognizer(navBarTap)

        //shows an alert when tapping the navigation bar
        let navBarTap = UITapGestureRecognizer(target: self, action: #selector(self.tapNavBar(_:)))
        let navBarTapHome = UITapGestureRecognizer(target: self, action: #selector(self.tapHomeNavBar(_:)))
        let navBarTapSale = UITapGestureRecognizer(target: self, action: #selector(self.tapSaleNavBar(_:)))
        let navBarTapHealth = UITapGestureRecognizer(target: self, action: #selector(self.tapHealthNavBar(_:)))
        let navBarTapSkincare = UITapGestureRecognizer(target: self, action: #selector(self.tapSkincareNavBar(_:)))
        let navBarTapMakeup = UITapGestureRecognizer(target: self, action: #selector(self.tapMakeupNavBar(_:)))
        let navBarTapBB = UITapGestureRecognizer(target: self, action: #selector(self.tapBBNavBar(_:)))
//        navBarView.addGestureRecognizer(navBarTap)
//        navBarView.isUserInteractionEnabled = true
        
        //shows we can tap individual labels
        navBarView.homeLabel.isUserInteractionEnabled = true
        navBarView.homeLabel.addGestureRecognizer(navBarTapHome)
        
        //generic tap for the others
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
        
        
        
//        navBarView.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTaps()
        setupCarousel()

        
    }
    
}

