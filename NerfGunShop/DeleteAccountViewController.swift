//
//  DeleteAccountViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 24/2/22.
//

import UIKit

class DeleteAccountViewController: UIViewController {
    
    @IBAction func deleteBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Account?", message: "All data will be LOST FOREVER!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            deleteUser()
            self.performSegue(withIdentifier: "accountDeleted", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
