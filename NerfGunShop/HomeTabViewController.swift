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
        print("Init")
    }
    
    var productResults:[Product] = []
    var idArray = [Int16]()
    var selectedId:Int16?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        idArray.removeAll()
        return productResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "searchItem", for: indexPath)
        tableCell.textLabel?.text = productResults[indexPath.row].name
        idArray.append(productResults[indexPath.row].id)
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clicked \(idArray)")
        selectedId = idArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "productDetail") as! ProductViewController
        vc.productId = selectedId
        self.present(vc, animated: true, completion: nil)
        //performSegue(withIdentifier: "searchToProduct", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToProduct" {
            //For when product is clicked and need to send product ID to the product view
            let destVC = segue.destination as! ProductViewController
            destVC.productId = selectedId
        }
    }
}

class HomeTabViewController: UITabBarController, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let vc = searchController.searchResultsController as! ShopSearchViewController
        vc.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchItem")
        vc.productResults = searchProducts(name: searchController.searchBar.text!)
        vc.tableView.reloadData()
    }
    

    let shopSearchController = UISearchController(searchResultsController: ShopSearchViewController())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        shopSearchController.searchBar.placeholder = "Search the store..."
        shopSearchController.searchResultsUpdater = self
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
