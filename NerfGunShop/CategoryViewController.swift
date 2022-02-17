//
//  CategoryViewController.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 16/2/22.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        IdArray = []
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "categoryProductItem", for: indexPath) as! ProductTableViewCell
        
        cell.productImg.image = UIImage(named: products[indexPath.row].image ?? "")
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = "$\(products[indexPath.row].price)"
        cell.productDesc.text = products[indexPath.row].about
        productsTableViewConstraint.constant = productsTableView.contentSize.height * CGFloat(products.count + 1)
        IdArray.append(products[indexPath.row].id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productsTableView.deselectRow(at: indexPath, animated: true)
        selectedId = IdArray[indexPath.row]
        performSegue(withIdentifier: "categoryToProduct", sender: nil)
    }
    

    @IBOutlet var productsTableView: UITableView!
    @IBOutlet var productsTableViewConstraint: NSLayoutConstraint!
    @IBOutlet var categoryImg: UIImageView!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryDesc: UILabel!
    
    var categoryId:Int16!
    var products:[Product]!
    var IdArray:[Int16]!
    var selectedId:Int16!
    var category:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        products = getProductsByCategory(categoryId: categoryId)
        category = getCategory(id: categoryId)
        
        if category != nil {
            categoryImg.image = UIImage(named: category.image ?? "")
            categoryName.text = category.name
            categoryDesc.text = category.about
            
            productsTableView.dataSource = self
            productsTableView.delegate = self
        } else {
            self.present(createSimpleAlert(title: "Invaild categoryId", message: "CategoryId is not found"), animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToProduct" {
            let destVC = segue.destination as! ProductViewController
            destVC.productId = selectedId
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
