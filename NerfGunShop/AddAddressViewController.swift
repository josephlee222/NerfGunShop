//
//  AddAddressViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 17/2/22.
//

import UIKit

class AddAddressViewController: UIViewController {
    
    @IBOutlet var addressName: UITextField!
    @IBOutlet var addressLocation: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let name = addressName.text!
        let location = addressLocation.text!
        
        if name != "" && location != "" {
            insertAddress(name: name, location: location, isDefault: false)
            let alert = UIAlertController(title: "Address Created", message: "Delivery location has been added", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return to List", style: .default, handler: {action in
                self.performSegue(withIdentifier: "fromAddAddress", sender: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.present(createSimpleAlert(title: "Unable to add address", message: "Please make sure that all the fills are filled in"), animated: true, completion: nil)
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
