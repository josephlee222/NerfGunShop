//
//  AccountViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 18/2/22.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let optionTitles = ["Top-Up Credits", "Change Password", "Change E-mail Address", "Delete Account"]
    let optionDescriptions = ["Add more credit into your account", "Change your password", "Change your E-mail address", "Delete your account"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userOptions.dequeueReusableCell(withIdentifier: "optionItem", for: indexPath)
        cell.textLabel?.text = optionTitles[indexPath.row]
        cell.detailTextLabel?.text = optionDescriptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userOptions.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "toAddCredits", sender: nil)
        default:
            self.present(createSimpleAlert(title: "Error", message: "Unimplemented user option (broken?)"), animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet var userProfileImg: UIImageView!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var userOptions: UITableView!
    
    let user = getLoggedInUser()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLbl.text = user.username
        emailLbl.text = user.email
        
        userOptions.dataSource = self
        userOptions.delegate = self
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
