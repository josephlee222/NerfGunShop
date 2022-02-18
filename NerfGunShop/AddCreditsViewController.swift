//
//  AddCreditsViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 18/2/22.
//

import UIKit

class AddCreditsViewController: UIViewController {
    
    @IBOutlet var currentBalanceLbl: UILabel!
    @IBOutlet var finalBalanceLbl: UILabel!
    @IBOutlet var creditsTf: UITextField!
    
    var isCheckout:Bool = false
    let credits = getLoggedInUser().credits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalanceLbl.text = "\(credits) Credits"
        finalBalanceLbl.text = "\(credits) Credits"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBalanceValueChanged(_ sender: UITextField) {
        let amount = Int16(creditsTf.text!) ?? 0
        finalBalanceLbl.text = "\(credits + amount) Credits"
    }
    
    
    @IBAction func addBtn(_ sender: Any) {
        let amount = Int16(creditsTf.text!) ?? 0
        if amount != 0 || amount > 1000 {
            addCredits(amount: amount)
            let alert = UIAlertController(title: "Credits Added", message: "Successfully added credits to account", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: isCheckout ? "Back to Checkout" : "Back to Home", style: .default, handler: {action in
                self.performSegue(withIdentifier: self.isCheckout ? "fromAddCredit" : "addCreditToHome", sender: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.present(createSimpleAlert(title: "Unable to Add", message: "Please enter a vaild amount of credits to add"), animated: true, completion: nil)
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
