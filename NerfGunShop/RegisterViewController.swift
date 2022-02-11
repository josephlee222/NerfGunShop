//
//  RegisterViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 10/2/22.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext:NSManagedObjectContext!
    
    //Components output
    @IBOutlet var usernameTf: UITextField!
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var passwordTf: UITextField!
    
    //When user presses the register btn
    @IBAction func registerBtn(_ sender: Any) {
        //Variable init for easier access
        
        let username = usernameTf.text!
        let email = emailTf.text!
        let password = passwordTf.text!
        let newId = Int16(UserDefaults.standard.integer(forKey: "userIdCount") + 1)
        
        //First check whether all fields has been filled up
        if username != "" && email != "" && password != "" {
            let userRequest:NSFetchRequest = User.fetchRequest()
            userRequest.predicate = NSPredicate(format: "username like '\(username)'")
            
            do {
                let users = try viewContext.fetch(userRequest)
                
                if users.isEmpty {
                    //Username is not used, able to create account
                    let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: viewContext) as! User
                    
                    user.username = username
                    user.email = email
                    user.password = password
                    user.credits = 200
                    user.isAdmin = false
                    user.id = newId
                    app.saveContext()
                    UserDefaults.standard.set(newId, forKey: "userIdCount")
                    
                    //Creation success, throw success alert at user before going back to home
                    let alert = UIAlertController(title: "Account created", message: "Your account has been created with a starting credit of $200 as a free gift! Thanks for joining!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {action in
                        //TODO: Replace this with direct login into app instead of return it to login screen
                        self.performSegue(withIdentifier: "unwindWelcome", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    //Username taken, throw alert
                    self.present(createSimpleAlert(title: "Username taken", message: "The username has been taken, please try again with another name."), animated: true, completion: nil)
                }
            } catch {
                print(error)
            }
        } else {
            self.present(createSimpleAlert(title: "Unable to create account", message: "Please make sure that all fields has been filled up."), animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init the viewcontext
        viewContext = app.persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        performSegue(withIdentifier: "unwindWelcome", sender: nil)
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
