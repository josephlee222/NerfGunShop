//
//  CartViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 11/2/22.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartTableViewCell = cartTableView.dequeueReusableCell(withIdentifier: "cartItem", for: indexPath) as! CartTableViewCell
        cell.productName.text = cart[indexPath.row].productName
        cell.productImg.image = UIImage(named: cart[indexPath.row].image ?? "")
        cell.productQty.text = "Qty: \(cart[indexPath.row].qty)"
        cell.productPrice.text = "\(cart[indexPath.row].price) Credits"
        
        return cell
    }
    
    
    @IBOutlet var deliveryPriceLbl: UILabel!
    @IBOutlet var totalPriceLbl: UILabel!
    @IBOutlet var cartTableView: UITableView!
    
    var cart = getCart(userId: getUserId())
    var totalPrice:Int16 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print(cart)
        cartTableView.dataSource = self
        cartTableView.delegate = self
        
        calculateCart()
    }
    
    func calculateCart() {
        totalPrice = 0
        for item in cart {
            totalPrice += item.price
        }
        totalPriceLbl.text = "\(totalPrice) Credits"
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        performSegue(withIdentifier: "closeCart", sender: nil)
    }
    
    @IBAction func checkoutBtn(_ sender: Any) {
        if !cart.isEmpty {
            performSegue(withIdentifier: "toCheckout", sender: nil)
        } else {
            self.present(createSimpleAlert(title: "Cart Empty", message: "Add some items into your cart before checking out"), animated: true, completion: nil)
        }
    }
    
    @IBAction func clearAllBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Cart?", message: "Delete all items in the shopping cart?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete All", style: .destructive, handler: {action in
            deleteCart(userId: getUserId())
            self.cart = getCart(userId: getUserId())
            self.calculateCart()
            self.cartTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCheckout" {
            let destVC = segue.destination as! CheckoutViewController
            destVC.totalPrice = totalPrice
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
