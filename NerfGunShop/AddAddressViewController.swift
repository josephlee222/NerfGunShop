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
    @IBOutlet var saveBtnOutlet: UIBarButtonItem!
    var isEditingAddress = false
    var address:Address!

    override func viewDidLoad() {
        super.viewDidLoad()
        if isEditingAddress && address != nil  {
            title = "Edit Address"
            saveBtnOutlet.image = UIImage(systemName: "checkmark")
            saveBtnOutlet.title = "Save Changes"
            addressName.text = address.name
            addressLocation.text = address.location
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let name = addressName.text!
        let location = addressLocation.text!
        
        if isEditingAddress {
            if name != "" && location != "" {
                editAddress(address: address, name: name, location: location)
                successAlert(title: "Address Edited", message: "Successfully edited address")
            } else {
                self.present(createSimpleAlert(title: "Unable to add address", message: "Please make sure that all the fields are filled in"), animated: true, completion: nil)
            }
        } else {
            if name != "" && location != "" {
                insertAddress(name: name, location: location, isDefault: false)
                successAlert(title: "Address Created", message: "Delivery location has been added")
            } else {
                self.present(createSimpleAlert(title: "Unable to add address", message: "Please make sure that all the fields are filled in"), animated: true, completion: nil)
            }
        }
        
    }
    
    func successAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Return to List", style: .default, handler: {action in
            self.performSegue(withIdentifier: "fromAddAddress", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
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
