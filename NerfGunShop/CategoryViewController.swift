//
//  CategoryViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 16/2/22.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "categoryProductItem", for: indexPath) as! ProductTableViewCell
        
        cell.productImg.image = UIImage(named: products[indexPath.row].image ?? "")
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = "$\(products[indexPath.row].price)"
        cell.productDesc.text = products[indexPath.row].about
        
        return cell
    }
    

    @IBOutlet var productsTableView: UITableView!
    @IBOutlet var productsTableViewConstraint: NSLayoutConstraint!
    @IBOutlet var categoryImg: UIImageView!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryDesc: UILabel!
    
    var categoryId:Int16!
    var products:[Product]!
    var category:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        products = getProductsByCategory(categoryId: categoryId)
        category = getCategory(id: categoryId)
        
        categoryImg.image = UIImage(named: category.image ?? "")
        categoryName.text = category.name
        categoryDesc.text = category.about
        
        productsTableView.dataSource = self
        //productsTableViewConstraint.constant = productsTableView.contentSize.height
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
