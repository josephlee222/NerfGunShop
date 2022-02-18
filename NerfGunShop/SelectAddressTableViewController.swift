//
//  SelectAddressTableViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 17/2/22.
//

import UIKit

class SelectAddressTableViewController: UITableViewController {
    
    var addresses:[Address] = getAddresses()

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
        
        if addresses.isEmpty {
            return 1
        } else {
            return addresses.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressItem", for: indexPath)

        // Configure the cell...
        if !addresses.isEmpty {
            cell.textLabel?.text =  addresses[indexPath.row].name
            cell.detailTextLabel?.text = addresses[indexPath.row].location
        } else {
            cell.textLabel?.text = "No Addresses Found"
            cell.detailTextLabel?.text = "Press the + button to add a address"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !addresses.isEmpty {
            let selectedCell = tableView.cellForRow(at: indexPath)
            performSegue(withIdentifier: "fromAddressList", sender: selectedCell)
        } else {
            performSegue(withIdentifier: "toAddAddress", sender: nil)
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "toAddAddress", sender: nil)
    }
    
    @IBAction func unwindToDeliveryList(segue:UIStoryboardSegue) {
        if segue.identifier == "fromAddAddress" {
            addresses = getAddresses()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAddressList" {
            let destVC = segue.destination as! CheckoutViewController
            let cell = sender as! UITableViewCell
            destVC.address = cell.detailTextLabel?.text
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
