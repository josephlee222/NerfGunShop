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
    insertCategory(name: "Testing Category 1", description: "This is testing category 1", imageName: "outline_question_mark_black_48pt")
    
    //Insert products
    insertProduct(name: "Testing product 1", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", price: 100, categoryId: 1, imageName: "outline_question_mark_black_48pt")
    insertProduct(name: "Testing product 2", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", price: 100, categoryId: 1, imageName: "outline_question_mark_black_48pt")
    insertProduct(name: "Testing product 3", description: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", price: 100, categoryId: 1, imageName: "outline_question_mark_black_48pt")

}
