//
//  ProductViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 15/2/22.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productTitle: UILabel!    
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productDesc: UILabel!
    @IBOutlet var productRating: UILabel!
    @IBOutlet var qtyTf: UITextField!
    
    var productId:Int16?
    
    @IBAction func reviewsBtn(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Details"
        if productId != nil {
            let product = getProduct(id: productId!)
            
            productImg.image = UIImage(named: product!.image ?? "")
            productTitle.text = product?.name
            productPrice.text = "\(product?.price ?? 0) Credits"
            productDesc.text = product?.about
        } else {
            self.present(createSimpleAlert(title: "Error", message: "No product ID passed in for viewing. (Broken?)"), animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cartBtn(_ sender: Any) {
        if qtyTf.text != "" && Int(qtyTf.text ?? "") != nil {
            let qty = qtyTf.text!
            let product = getProduct(id: productId!)
            if isCartItemExist(productId: productId!, userId: getUserId()) {
                let cartItem = getCartItem(productId: productId!, userId: getUserId())
                editCartQuantity(cart: cartItem, qty: (cartItem.qty + Int16(qty)!))
            } else {
                insertCart(userId: getUserId(), itemId: Int16(productId!), name: product!.name!, price: product!.price, qty: Int16(qty)!, image: (product?.image)!)
            }
            self.present(createSimpleAlert(title: "Added to Cart", message: "Product has been added to your cart"), animated: true, completion: nil)
        } else {
            self.present(createSimpleAlert(title: "Unable to Add", message: "Please specify a quantity"), animated: true, completion: nil)
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
