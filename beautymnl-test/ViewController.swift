//
//  ViewController.swift
//  beautymnl-test
//
//  Created by Brian Nicholas Sy on 3/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBarView: NavigationBarView!
    var navigationBar = NavigationBarView()
    var carousel = CarouselView()
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBAction func shopBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Button pressed", message: "Shop button", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTaps()
        
        
    }
    
    @objc func tapNavBar(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        let alert = UIAlertController(title: "Button pressed", message: "Nav bar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
     }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func setupTaps(){
        //dismisses the keyboard when tapping anywhere
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardTap)

//        navBarView.homeLabel.text = "hel"
//        navBarView.homeLabel.textColor = UIColor.red
//        navBarView.homeLabel.isUserInteractionEnabled = true
//        navBarView.homeLabel.isEnabled = true
//        navBarView.homeLabel.addGestureRecognizer(navBarTap)

        //shows an alert when tapping the navigation bar
        let navBarTap = UITapGestureRecognizer(target: self, action: #selector(self.tapNavBar(_:)))
        navBarView.addGestureRecognizer(navBarTap)
        navBarView.isUserInteractionEnabled = true
    }

}

