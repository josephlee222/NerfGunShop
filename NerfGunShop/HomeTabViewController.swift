//
//  HomeTabViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 11/2/22.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = item.title
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Logout from Account?", message: "Logout from your account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {action in
            logoutUser()
            self.performSegue(withIdentifier: "toLogout", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func wishlistBtn(_ sender: Any) {
        self.present(createSimpleAlert(title: "Wishlist press", message: "Placeholder"), animated: true, completion: nil)
    }
    
    @IBAction func cartBtn(_ sender: Any) {
        //self.present(createSimpleAlert(title: "Cart press", message: "Placeholder"), animated: true, completion: nil)
        performSegue(withIdentifier: "toCart", sender: nil)
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) {
        
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
