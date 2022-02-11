//
//  StandardFunctions.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 10/2/22.
//

import Foundation
import UIKit

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
