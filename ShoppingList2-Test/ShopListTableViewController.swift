//
//  ShopListTableViewController.swift
//  ShoppingList2-Test
//
//  Created by Yatin on 21/02/17.
//  300907366
//  Mid-term test Building Shopping List.
//  Copyright © 2017 MAPD-124. All rights reserved.
//
// List of all Shopping-List

import UIKit
import RealmSwift

class ShopListTableViewController: UITableViewController, UpdateListDelegate {

    // Array of shopping list
    var shopListArray : [ShopList] = []
    // Cell identifier constant
    let cellIdentifier = "ShopListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeList(false)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // Reload the list from storage to reflect the changes on list
    func initializeList(_ isReload: Bool){
        let realm = try! Realm()
        shopListArray =  Array(realm.objects(ShopList.self))
        print(shopListArray.count)
        if(isReload){
            self.tableView.reloadData()
        }
    }
    
    // Delgate method to refresh list for reflecting changes
    func updateListTask() {
        initializeList(true)
        print("Delegate")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shopListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShopListTableViewCell

        // Configure the cell...
        let shopList = self.shopListArray[indexPath.row]
        print(shopList.name)

        cell.newListNameLabel.text = shopList.name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Swipe to delete functinality implemented
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let shopList = self.shopListArray[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(shopList)
            }
            initializeList(true)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Action for clearing the database
    @IBAction func deleteAllListner(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        // Delete all objects from the realm
        try! realm.write {
            realm.deleteAll()
        }
        initializeList(true)
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Conditional check for type of segue
        if(segue.identifier == "Add"){
            // only delegate is assigned since it's a new creation of list
            if let destinationViewController = segue.destination as? ListItemTableViewController {
                destinationViewController.delegate = self
            }
        }else{
            // various elements in DestinationViewController are set since it is edit/update list
            if let destinationViewController = segue.destination as? ListItemTableViewController {
                let row = self.tableView.indexPathForSelectedRow!.row
                let name = shopListArray[row].name;
                print(row)
                print(name)
                destinationViewController.shopList = shopListArray[row]
                destinationViewController.delegate = self
            }
        }
    }

}
