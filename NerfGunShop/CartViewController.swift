//
//  CartViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 11/2/22.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet var deliveryPriceLbl: UILabel!
    @IBOutlet var totalPriceLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        performSegue(withIdentifier: "closeCart", sender: nil)
    }
    
    @IBAction func checkoutBtn(_ sender: Any) {
        self.present(createSimpleAlert(title: "Checkout press", message: "Placeholder"), animated: true, completion: nil)
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
