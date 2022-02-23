//
//  StandardFunctions.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 10/2/22.
//

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

func getUserId() -> Int16 {
    return Int16(UserDefaults.standard.integer(forKey: "userLoginId"))
}

func getLoggedInUser() -> User {
    let userRequest:NSFetchRequest = User.fetchRequest()
    userRequest.predicate = NSPredicate(format: "id == '\(getUserId())'")
    
    var user:User!
    do {
        user = try viewContext.fetch(userRequest)[0]
    } catch {
        print(error)
    }
    
    return user
}

func editLoggedInUserEmail(email:String) {
    let user:User = getLoggedInUser()
    user.setValue(email, forKey: "email")
    
    app.saveContext()
}

func editLoggedInUserPassword(password:String) {
    let user:User = getLoggedInUser()
    user.setValue(password, forKey: "password")
    
    app.saveContext()
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
func insertProduct(name:String, description:String, price:Int16, categoryId:Int16, imageName:String) {
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

func reinitialiseProducts() {
    let Productsbatch = NSBatchDeleteRequest(fetchRequest: Product.fetchRequest())
    let Categorybatch = NSBatchDeleteRequest(fetchRequest: Category.fetchRequest())
    do {
        try app.persistentContainer.persistentStoreCoordinator.execute(Productsbatch, with: viewContext)
    } catch {
        print(error)
    }
    
    do {
        try app.persistentContainer.persistentStoreCoordinator.execute(Categorybatch, with: viewContext)
    } catch {
        print(error)
    }
    
    UserDefaults.standard.set(0, forKey: "productIdCount")
    UserDefaults.standard.set(0, forKey: "categoryIdCount")

    initializeData()
}

// Function to insert a product to a users cart
func insertCart(userId:Int16, itemId:Int16, name:String, price:Int16, qty:Int16, image:String) {
    if !checkUserDefaultsKeyExist(key: "cartIdCount") {
        UserDefaults.standard.setValue(0, forKey: "cartIdCount")
    }
    
    let id = Int16(UserDefaults.standard.integer(forKey: "cartIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: viewContext) as! Cart
    insert.itemId = itemId
    insert.userId = userId
    insert.productName = name
    insert.price = price * qty
    insert.qty = qty
    insert.image = image
    insert.id = id
    app.saveContext()
    UserDefaults.standard.set(id, forKey: "cartIdCount")
}

func getCart(userId:Int16) -> [Cart] {
    let cartRequest:NSFetchRequest = Cart.fetchRequest()
    cartRequest.predicate = NSPredicate(format: "userId == '\(userId)'")
    
    var cart:[Cart]?
    do {
        cart = try viewContext.fetch(cartRequest)
    } catch {
        print(error)
    }
    
    return cart ?? []
}

func deleteCart(userId:Int16) {
    let cartRequest:NSFetchRequest = Cart.fetchRequest()
    cartRequest.predicate = NSPredicate(format: "userId == '\(userId)'")
    
    var cart:[Cart]?
    do {
        cart = try viewContext.fetch(cartRequest)
        
        for item in cart! {
            viewContext.delete(item)
            app.saveContext()
        }
    } catch {
        print(error)
    }
}

func deleteCartItem(cartItem:Cart) {
    viewContext.delete(cartItem)
    app.saveContext()
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

// Function to get product by ID, result might be nil.
func getProduct(id:Int16) -> Product? {
    let productRequest:NSFetchRequest = Product.fetchRequest()
    productRequest.predicate = NSPredicate(format: "id = '\(id)'")
    
    var product:Product?
    do {
        let products = try viewContext.fetch(productRequest)
        if products.count != 0 {
            product = products[0]
        }
    } catch {
        print(error)
    }
    return product
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

// Function to get category by ID, result might be nil.
func getCategory(id:Int16) -> Category? {
    let categoryRequest:NSFetchRequest = Category.fetchRequest()
    categoryRequest.predicate = NSPredicate(format: "id = '\(id)'")
    
    var category:Category?
    do {
        let categories = try viewContext.fetch(categoryRequest)
        if categories.count != 0 {
            category = categories[0]
        }
    } catch {
        print(error)
    }
    return category
}

func getProductsByCategory(categoryId:Int16) -> [Product] {
    let productRequest:NSFetchRequest = Product.fetchRequest()
    productRequest.predicate = NSPredicate(format: "categoryId == '\(categoryId)'")
    var products:[Product]?
    do {
        products = try viewContext.fetch(productRequest)
        
    } catch {
        print(error)
    }
    
    return products ?? []
}

func getCategories() -> [Category] {
    let productRequest:NSFetchRequest = Category.fetchRequest()
    
    var categories:[Category]?
    do {
        categories = try viewContext.fetch(productRequest)
    } catch {
        print(error)
    }
    return categories ?? []
}

func insertAddress(name:String, location:String, isDefault:Bool) {
    if !checkUserDefaultsKeyExist(key: "addressIdCount") {
        UserDefaults.standard.setValue(0, forKey: "addressIdCount")
    }
    
    let id = Int16(UserDefaults.standard.integer(forKey: "addressIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Address", into: viewContext) as! Address
    
    insert.name = name
    insert.location = location
    insert.isDefault = isDefault
    insert.userId = getUserId()
    insert.id = id
    app.saveContext()
    UserDefaults.standard.set(id, forKey: "addressIdCount")
}

func getAddresses() -> [Address] {
    let addressRequest:NSFetchRequest = Address.fetchRequest()
    addressRequest.predicate = NSPredicate(format: "userId == '\(getUserId())'")
    
    var addresses:[Address]?
    do {
        addresses = try viewContext.fetch(addressRequest)
    } catch {
        print(error)
    }
    return addresses ?? []
}

func addCredits(amount:Int16) {
    let user = getLoggedInUser()
    
    user.setValue((user.credits + amount), forKey: "credits")
    app.saveContext()
}

func deductCredits(amount:Int16) {
    let user = getLoggedInUser()
    
    user.setValue((user.credits - amount), forKey: "credits")
    app.saveContext()
}
