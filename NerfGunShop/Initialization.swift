//
//  Initialization.swift
//  NerfGunShop
//
//  Created by Joseph Lee on 14/2/22.
//

import Foundation
import UIKit

//This function runs the first time when the app is open in a new device or a reset happens
//Usually run in ViewController.swift
func initializeData() {
    
    //Insert Categories
    insertCategory(name: "Testing Category 1", description: "This is testing category 1", imageName: "questionmark.diamond.fill")
    
    //Insert products
    insertProduct(name: "Testing product 1", description: "This is testing product 1 inside the testing category", price: 100, categoryId: 1, imageName: "questionmark.diamond.fill")

}
