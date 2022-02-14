//
//  HomeTabViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 11/2/22.
//

import UIKit

class ShopSearchViewController:UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateSearchResultsTable(products:[Product]) {
        
    }
}

class HomeTabViewController: UITabBarController,UISearchResultsUpdating {

    let shopSearchController = UISearchController(searchResultsController: ShopSearchViewController())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        shopSearchController.searchBar.placeholder = "Search the store..."
        navigationItem.searchController = shopSearchController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = item.title
        if item.title == "Shop" {
            navigationItem.searchController = shopSearchController
        } else {
            navigationItem.searchController = nil
        }
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
    
    func updateSearchResults(for searchController: UISearchController) {
        
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
