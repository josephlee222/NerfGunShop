//
//  ViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 10/2/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext:NSManagedObjectContext!
    
    //Components output
    @IBOutlet var usernameTf: UITextField!
    @IBOutlet var passwordTf: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Checking if ID counters exists
        if !checkUserDefaultsKeyExist(key: "userIdCount") {
            UserDefaults.standard.setValue(0, forKey: "userIdCount")
        }
        
        //Init the viewcontext
        viewContext = app.persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
        if (isUserLoggedIn()) {
            performSegue(withIdentifier: "toHomeNavigation", sender: nil)
        }
    }

    @IBAction func registerBtn(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        //Variable init for easier access
        let username = usernameTf.text!
        let password = passwordTf.text!
        
        //First check whether all fields has been filled up
        if username != "" && password != "" {
            //Starts to log in the user by retriving information from database
            let userRequest:NSFetchRequest = User.fetchRequest()
            userRequest.predicate = NSPredicate(format: "username == '\(username)' AND password == '\(password)'")
            
            do {
                let users = try viewContext.fetch(userRequest)
                
                if !users.isEmpty {
                    //Correct password, login the user and set userDefaults
                    createLoginUserDefaults(user:users[0])
                    debugPrintLoginUserDefaults()
                    performSegue(withIdentifier: "toHomeNavigation", sender: nil)
                } else {
                    //Wrong password, throw alert to user to retry
                    self.present(createSimpleAlert(title: "Wrong password or username", message: "The password or username is invaild. Please try again"), animated: true, completion: nil)
                    
                }
            } catch {
                print(error)
            }
        } else {
            //Throw error about incomplete fields
            self.present(createSimpleAlert(title: "Unable to login", message: "Please make sure to fill up all the fields"), animated: true, completion: nil)
        }
        
        
        
        
    }
    
    @IBAction func unwindToWelcome(segue: UIStoryboardSegue) {
        
    }
        
}

