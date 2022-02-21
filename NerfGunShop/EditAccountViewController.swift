//
//  EditAccountViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 20/2/22.
//

import UIKit

class EditAccountViewController: UIViewController {
    
    @IBOutlet var editFieldLbl: UILabel!
    @IBOutlet var editTf: UITextField!
    @IBOutlet var confirmPasswordTf: UITextField!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var navSaveBtn: UIBarButtonItem!
    
    var editType:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch editType {
        case "email":
            editFieldLbl.text = "New E-mail"
            editTf.placeholder = "New E-Mail..."
            title = "Edit E-mail"
        case "password":
            editFieldLbl.text = "New Password"
            editTf.placeholder = "New Password..."
            editTf.isSecureTextEntry = true
            editTf.textContentType = .password
            title = "Edit Password"
        default:
            saveBtn.isEnabled = false
            navSaveBtn.isEnabled = false
            self.present(createSimpleAlert(title: "Error", message: "No edit type specified. (Broken?)"), animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if editTf.text != "" && confirmPasswordTf.text != "" {
            let user:User = getLoggedInUser()
            if user.password == confirmPasswordTf.text {
                if editType == "email" {
                    editLoggedInUserEmail(email: editTf.text ?? "")
                    showEditedAlert(title: "E-mail changed", message: "Your E-mail address has been successfully changed")
                } else if editType == "password" {
                    editLoggedInUserPassword(password: editTf.text ?? "")
                    showEditedAlert(title: "Password changed", message: "Your password has been successfully changed")
                }
            } else {
                self.present(createSimpleAlert(title: "Unable to save", message: "Existing password is incorrect"), animated: true, completion: nil)
            }
        } else {
            self.present(createSimpleAlert(title: "Unable to save", message: "Please make sure that all fields are filled up"), animated: true, completion: nil)
        }
    }
    
    func showEditedAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to Account", style: .default, handler: {action in
            self.performSegue(withIdentifier: "fromEditUser", sender: nil)
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
