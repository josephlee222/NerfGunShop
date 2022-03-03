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
let defaults = UserDefaults.standard

// Function to check if a userdefaults key exist
func checkUserDefaultsKeyExist(key:String) -> Bool {
    return defaults.object(forKey: key) != nil
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
    defaults.set(username, forKey: "userLoginUsername")
    defaults.set(password, forKey: "userLoginPassword")
    defaults.set(email, forKey: "userLoginEmail")
    defaults.set(credits, forKey: "userLoginCredits")
    defaults.set(isAdmin, forKey: "userLoginIsAdmin")
    defaults.set(id, forKey: "userLoginId")
}

// Function to check if an existing user is logged in
func isUserLoggedIn() -> Bool {
    let username = defaults.string(forKey: "userLoginUsername")
    let password = defaults.string(forKey: "userLoginPassword")
    
    return username != nil && password != nil
}

func getUserId() -> Int16 {
    return Int16(defaults.integer(forKey: "userLoginId"))
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
    return defaults.bool(forKey: "userLoginIsAdmin")
}

// Function to log out the user
func logoutUser() {
    defaults.removeObject(forKey: "userLoginUsername")
    defaults.removeObject(forKey: "userLoginPassword")
    defaults.removeObject(forKey: "userLoginEmail")
    defaults.removeObject(forKey: "userLoginCredits")
    defaults.removeObject(forKey: "userLoginIsAdmin")
    defaults.removeObject(forKey: "userLoginId")
}

func deleteUser() {
    let user = getLoggedInUser()
    deleteCart(userId: user.id)
    deleteAllAddresses(userId: user.id)
    logoutUser()
    viewContext.delete(user)
    app.saveContext()
}

// Function to insert a product category
func insertCategory(name:String, description:String, imageName:String) {
    if !checkUserDefaultsKeyExist(key: "categoryIdCount") {
        defaults.setValue(0, forKey: "categoryIdCount")
    }
    
    let id = Int16(defaults.integer(forKey: "categoryIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Category", into: viewContext) as! Category
    insert.name = name
    insert.about = description
    insert.image = imageName
    insert.id = id
    app.saveContext()
    defaults.set(id, forKey: "categoryIdCount")
}

// Function to insert a product
func insertProduct(name:String, description:String, price:Int16, categoryId:Int16, imageName:String) {
    if !checkUserDefaultsKeyExist(key: "productIdCount") {
        defaults.setValue(0, forKey: "productIdCount")
    }
    
    let id = Int16(defaults.integer(forKey: "productIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Product", into: viewContext) as! Product
    insert.name = name
    insert.about = description
    insert.categoryId = categoryId
    insert.image = imageName
    insert.price = price
    insert.id = id
    app.saveContext()
    defaults.set(id, forKey: "productIdCount")
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
    
    defaults.set(0, forKey: "productIdCount")
    defaults.set(0, forKey: "categoryIdCount")

    initializeData()
}

// Function to insert a product to a users cart
func insertCart(userId:Int16, itemId:Int16, name:String, price:Int16, qty:Int16, image:String) {
    if !checkUserDefaultsKeyExist(key: "cartIdCount") {
        defaults.setValue(0, forKey: "cartIdCount")
    }
    
    let id = Int16(defaults.integer(forKey: "cartIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: viewContext) as! Cart
    insert.itemId = itemId
    insert.userId = userId
    insert.productName = name
    insert.price = price * qty
    insert.qty = qty
    insert.image = image
    insert.id = id
    app.saveContext()
    defaults.set(id, forKey: "cartIdCount")
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

func isCartItemExist(productId:Int16, userId:Int16) -> Bool {
    let cartRequest:NSFetchRequest = Cart.fetchRequest()
    cartRequest.predicate = NSPredicate(format: "userId == '\(userId)' && itemId == '\(productId)'")
    
    var cart:[Cart]?
    do {
        cart = try viewContext.fetch(cartRequest)
    } catch {
        print(error)
    }
    
    return !(cart?.isEmpty ?? false)
}

func getCartItem(productId:Int16, userId:Int16) -> Cart {
    let cartRequest:NSFetchRequest = Cart.fetchRequest()
    cartRequest.predicate = NSPredicate(format: "userId == '\(userId)' && itemId == '\(productId)'")
    
    var cart:[Cart]?
    do {
        cart = try viewContext.fetch(cartRequest)
    } catch {
        print(error)
    }
    
    return cart![0]
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

func editCartQuantity(cart:Cart, qty:Int16) {
    let product = getProduct(id: cart.itemId)
    cart.setValue(qty, forKey: "qty")
    cart.setValue(product!.price * qty, forKey: "price")
    
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
        defaults.setValue(0, forKey: "addressIdCount")
    }
    
    let id = Int16(defaults.integer(forKey: "addressIdCount") + 1)
    let insert = NSEntityDescription.insertNewObject(forEntityName: "Address", into: viewContext) as! Address
    
    insert.name = name
    insert.location = location
    insert.isDefault = isDefault
    insert.userId = getUserId()
    insert.id = id
    app.saveContext()
    defaults.set(id, forKey: "addressIdCount")
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

enum addressSort{
    case name
    case address
}

func getSortedAddresses(type:addressSort) -> [Address] {
    let addressRequest:NSFetchRequest = Address.fetchRequest()
    addressRequest.predicate = NSPredicate(format: "userId == '\(getUserId())'")
    addressRequest.sortDescriptors = [NSSortDescriptor(key: type == .name ? "name" : "location", ascending: true)]
    
    var addresses:[Address]?
    do {
        addresses = try viewContext.fetch(addressRequest)
    } catch {
        print(error)
    }
    return addresses ?? []
}

func getAddress(id:Int16) -> Address {
    let addressRequest:NSFetchRequest = Address.fetchRequest()
    addressRequest.predicate = NSPredicate(format: "id == '\(id)'")
    
    var addresses:[Address]?
    do {
        addresses = try viewContext.fetch(addressRequest)
    } catch {
        print(error)
    }
    
    return addresses![0]
}

func editAddress(address:Address, name:String, location:String) {
    address.setValue(name, forKey: "name")
    address.setValue(location, forKey: "location")
    app.saveContext()
}

func deleteAddress(address:Address) {
    viewContext.delete(address)
    app.saveContext()
}

func deleteAllAddresses(userId:Int16) {
    let addressRequest:NSFetchRequest = Address.fetchRequest()
    addressRequest.predicate = NSPredicate(format: "userId == '\(userId)'")
    
    var addresses:[Address]?
    do {
        addresses = try viewContext.fetch(addressRequest)
        
        for item in addresses! {
            viewContext.delete(item)
            app.saveContext()
        }
    } catch {
        print(error)
    }
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
