//
//  CheckoutSuccessViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 17/2/22.
//

import UIKit

class CheckoutSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
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
