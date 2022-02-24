//
//  OptionsTableViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 23/2/22.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    
    let optionTitles:[String] = ["App Theme", "Re-Initialize Product Data", "About & Acknowledgements"]
    let optionsDescriptions:[String] = ["Switch between dark and light modes" ,"Deletes all data stored and re-create products", "About the app and copyrights"]
    let optionImages = [UIImage(systemName: "paintbrush.fill"), UIImage(systemName: "repeat"), UIImage(systemName: "info.circle.fill")]
    let window = UIApplication.shared.windows.first

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return optionTitles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionItem", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = optionTitles[indexPath.row]
        cell.detailTextLabel?.text = optionsDescriptions[indexPath.row]
        cell.imageView?.image = optionImages[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: "Change Theme", message: "Switch between light and dark modes", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dark Mode", style: .default, handler: {action in
                UIView.transition (with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.window!.overrideUserInterfaceStyle = .dark //.light or .unspecified
                }, completion: nil)
                UserDefaults.standard.set("dark", forKey: "userTheme")
            }))
            alert.addAction(UIAlertAction(title: "Light Mode", style: .default, handler: {action in
                UIView.transition (with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.window!.overrideUserInterfaceStyle = .light //.light or .unspecified
                }, completion: nil)
                UserDefaults.standard.set("light", forKey: "userTheme")
            }))
            alert.addAction(UIAlertAction(title: "Use System Default", style: .default, handler: {action in
                UIView.transition (with: self.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.window!.overrideUserInterfaceStyle = .unspecified
                }, completion: nil)
                UserDefaults.standard.removeObject(forKey: "userTheme")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case 1:
            let alert = UIAlertController(title: "Refresh Product Data?", message: "Refresh Product Data? Useful when new products are added.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Refresh", style: .destructive, handler: {action in
                reinitialiseProducts()
            }))
            self.present(alert, animated: true, completion: nil)
        case 2:
            performSegue(withIdentifier: "toAbout", sender: nil)
        default:
            self.present(createSimpleAlert(title: "Error", message: "Unimplemented option (broken?)"), animated: true, completion: nil)
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
