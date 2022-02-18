//
//  ShopViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 12/2/22.
//

import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet var randomProductImg: UIImageView!
    @IBOutlet var randomProductName: UILabel!
    @IBOutlet var randomProductDesc: UILabel!
    @IBOutlet var carouselPageControl: UIPageControl!
    @IBOutlet var carouselImg: UIImageView!
    
    var randomProductId:Int16?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Init the random item, returns ID in case user clicks the product
        randomProductId = initRandomProduct()
    }
    
    // Function to init the random item view
    func initRandomProduct() -> Int16 {
        let products = getProducts()
        let maximumLength = products.count
        let randomNumber = maximumLength < 2 ? 0 : Int.random(in: 0...maximumLength - 1)
        
        if maximumLength != 0 {
            let product = products[randomNumber]
            randomProductName.text = product.name
            randomProductDesc.text = product.about
            randomProductImg.image = UIImage(named: product.image ?? "shippingbox.fill")
        } else {
            
            randomProductName.text = "No Products"
            randomProductDesc.text = "No products to randomise"
        }
        return Int16(randomNumber + 1)
    }
    
    @IBAction func tappedRandomItem(_ sender: Any) {
        performSegue(withIdentifier: "homeToProduct", sender: nil)
    }
    
    @IBAction func tappedCategories(_ sender: Any) {
        performSegue(withIdentifier: "homeToCategories", sender: nil)
    }
    
    @IBAction func tappedNerfGuns(_ sender: Any) {
        performSegue(withIdentifier: "homeToCategoryGuns", sender: nil)
    }
    
    @IBAction func tappedDarts(_ sender: Any) {
        performSegue(withIdentifier: "homeToCategoryDarts", sender: nil)
    }
    
    
    @IBAction func swipeCarouselImg(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            // Swiped forward
            print("Swiped left")
            if carouselPageControl.numberOfPages - 1 == carouselPageControl.currentPage {
                carouselPageControl.currentPage = 0
            } else {
                carouselPageControl.currentPage += 1
            }
        } else if sender.direction == .right {
            // Swiped backward
            print("Swiped right")
            if carouselPageControl.currentPage == 0 {
                carouselPageControl.currentPage = 3
            } else {
                carouselPageControl.currentPage -= 1
            }
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToProduct" {
            //For when random product is clicked and need to send product ID to the product view
            let destVC = segue.destination as! ProductViewController
            destVC.productId = randomProductId
        }
        
        if segue.identifier == "homeToCategoryGuns" {
            let destVC = segue.destination as! CategoryViewController
            destVC.categoryId = 1
        }
        
        if segue.identifier == "homeToCategoryDarts" {
            let destVC = segue.destination as! CategoryViewController
            destVC.categoryId = 3
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
