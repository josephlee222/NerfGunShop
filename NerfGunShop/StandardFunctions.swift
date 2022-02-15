//
//  StandardFunctions.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 10/2/22.
//

import Foundation
import UIKit
import CoreData

let app = UIApplication.shared.delegate as! AppDelegate
var viewContext:NSManagedObjectContext = app.persistentContainer.viewContext

// Function to check if a userdefaults key exist
func checkUserDefaultsKeyExist(key:String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

// Function to create a simple dialog and return a UIALertController
func createSimpleAlert(title:String, message:String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
    return alert
}

// Function to add logged in user to userDefaults
func createLoginUserDefaults(user:User) {
    let username = user.username
    let password = user.password
    let email = user.email
    let credits = user.credits
    let isAdmin = user.isAdmin
    let id = user.id
    
    //Set the userDefaults
    UserDefaults.standard.set(username, forKey: "userLoginUsername")
    UserDefaults.standard.set(password, forKey: "userLoginPassword")
    UserDefaults.standard.set(email, forKey: "userLoginEmail")
    UserDefaults.standard.set(credits, forKey: "userLoginCredits")
    UserDefaults.standard.set(isAdmin, forKey: "userLoginIsAdmin")
    UserDefaults.standard.set(id, forKey: "userLoginId")
}

// Function to check if an existing user is logged in
func isUserLoggedIn() -> Bool {
    let username = UserDefaults.standard.string(forKey: "userLoginUsername")
    let password = UserDefaults.standard.string(forKey: "userLoginPassword")
    
    return username != nil && password != nil
}

// Function to check if the logged in user is an adnin
func isLoggedUserAdmin()  -> Bool {
    return UserDefaults.standard.bool(forKey: "userLoginIsAdmin")
}

// Function to log out the user
func logoutUser() {
    UserDefaults.standard.removeObject(forKey: "userLoginUsername")
    UserDefaults.standard.removeObject(forKey: "userLoginPassword")
    UserDefaults.standard.removeObject(forKey: "userLoginEmail")
    UserDefaults.standard.removeObject(forKey: "userLoginCredits")
    UserDefaults.standard.removeObject(forKey: "userLoginIsAdmin")
    UserDefaults.standard.removeObject(forKey: "userLoginId")
}


// Debug function to print all logged in userDefaults (To be deleted later)
func debugPrintLoginUserDefaults() {
    print(UserDefaults.standard.string(forKey: "userLoginUsername")!)
    print(UserDefaults.standard.string(forKey: "userLoginPassword")!)
    print(UserDefaults.standard.string(forKey: "userLoginEmail")!)
    print(UserDefaults.standard.string(forKey: "userLoginCredits")!)
    print(UserDefaults.standard.string(forKey: "userLoginIsAdmin")!)
    print(UserDefaults.standard.string(forKey: "userLoginId")!)
}

// Function to insert a product category
func insertCategory(name:String, description:String, imageName:String) {
    if !checkUserDefaultsKeyExist(key: "categoryIdCount") {
        UserDefaults.standard.setValue(0, forKey: "categoryIdCount")
    }
    
    let id = Int16(UserDefaults.standard.integer(forKey: "categoryIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Category", into: viewContext) as! Category
    insert.name = name
    insert.about = description
    insert.image = imageName
    insert.id = id
    app.saveContext()
    UserDefaults.standard.set(id, forKey: "categoryIdCount")
}

// Function to insert a product
func insertProduct(name:String, description:String, price:Float, categoryId:Int16, imageName:String) {
    if !checkUserDefaultsKeyExist(key: "productIdCount") {
        UserDefaults.standard.setValue(0, forKey: "productIdCount")
    }
    
    let id = Int16(UserDefaults.standard.integer(forKey: "productIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Product", into: viewContext) as! Product
    insert.name = name
    insert.about = description
    insert.categoryId = categoryId
    insert.image = imageName
    insert.price = price
    insert.id = id
    app.saveContext()
    UserDefaults.standard.set(id, forKey: "productIdCount")
}

// Function to insert a product to a users cart
func insertCart(userId:Int16, itemId:Int16, qty:Int16) {
    if !checkUserDefaultsKeyExist(key: "cartIdCount") {
        UserDefaults.standard.setValue(0, forKey: "cartIdCount")
    }
    
    let id = Int16(UserDefaults.standard.integer(forKey: "cartIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: viewContext) as! Cart
    insert.itemId = itemId
    insert.userId = userId
    insert.id = id
    app.saveContext()
    UserDefaults.standard.set(id, forKey: "cartIdCount")
}

// Function to get all products
func getProducts() -> [Product] {
    let productRequest:NSFetchRequest = Product.fetchRequest()
    
    var products:[Product]?
    do {
        products = try viewContext.fetch(productRequest)
    } catch {
        print(error)
    }
    return products ?? []
}

func searchProducts(name:String) -> [Product] {
    let productRequest:NSFetchRequest = Product.fetchRequest()
    productRequest.predicate = NSPredicate(format: "name contains[c] '\(name)'")
    var products:[Product]?
    do {
        products = try viewContext.fetch(productRequest)
        
    } catch {
        print(error)
    }
    
    return products ?? []
}
