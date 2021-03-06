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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !addresses.isEmpty {
            let action = UIContextualAction(style: .destructive, title: "Delete", handler: {action, view, completion in
                deleteAddress(address: self.addresses[indexPath.row])
                self.addresses = getAddresses()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            return UISwipeActionsConfiguration(actions: [action])
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !addresses.isEmpty {
            let action = UIContextualAction(style: .normal, title: "Edit", handler: {action, view, completion in
                self.performSegue(withIdentifier: "toEditAddress", sender: indexPath)
            })
            
            return UISwipeActionsConfiguration(actions: [action])
        } else {
            return nil
        }
        
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
    
    @IBAction func sortBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Sort Addresses", message: "Sort addresses by", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Name", style: .default, handler: {action in
            self.addresses = getSortedAddresses(type: .name)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Address", style: .default, handler: {action in
            self.addresses = getSortedAddresses(type: .address)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        
        if segue.identifier == "toEditAddress" {
            let destVC = segue.destination as! AddAddressViewController
            let indexPath = sender as! IndexPath
            
            destVC.isEditingAddress = true
            destVC.address = addresses[indexPath.row]
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
