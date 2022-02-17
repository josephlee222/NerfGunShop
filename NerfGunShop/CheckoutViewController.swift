//
//  CheckoutViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 17/2/22.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    var totalPrice:Int16!
    var credits:Int16!
    var address:String!
    @IBOutlet var payableLbl: UILabel!
    @IBOutlet var creditsLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var payBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        credits = getLoggedInUser().credits
        
        if totalPrice != nil {
            payableLbl.text = "\(totalPrice ?? 0) Credits"
            if totalPrice > credits {
                creditsLbl.text = "\(credits ?? 0) Credits\nInsufficent Credits"
                creditsLbl.textColor = .red
                payBtn.isEnabled = false
                
            } else {
                creditsLbl.text = "\(credits ?? 0) Credits\n\(credits - totalPrice) Credits after payment"
            }
        } else {
            self.present(createSimpleAlert(title: "Unable to Checkout", message: "totalPrice is nil (code broken?)"), animated: true, completion: nil)
        }
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        performSegue(withIdentifier: "toCheckoutSuccess", sender: nil)
    }
    
    @IBAction func changeAddressBtn(_ sender: Any) {
        performSegue(withIdentifier: "toAddresses", sender: nil)
    }
    
    @IBAction func unwindToCheckout(segue:UIStoryboardSegue) {
        if segue.identifier == "fromAddressList" {
            addressLbl.text = address ?? "Error getting address"
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
