//
//  ListItemTableViewController.swift
//  ShoppingList2-Test
//
//  Created by Yatin on 21/02/17.
//  Copyright © 2017 MAPD-124. All rights reserved.
//

import UIKit
import RealmSwift

protocol UpdateListDelegate {
    func updateListTask()
}

class ListItemTableViewController: UITableViewController {

    var delegate: UpdateListDelegate?
    
    // Array of shopping list
    var itemListArray : [ListItem] = []
    // Shoplist object carrying all child elements
    var shopList : ShopList = ShopList()
    // Cell identifier constant
    let cellIdentifier = "ListItemTableViewCell"
    // alert action object
    var currentCreateAction:UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeList(false)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // Reload the list to reflect the changes on list
    func initializeList(_ isReload: Bool){
        itemListArray =  Array(shopList.listItems)
        print(itemListArray.count)
        if(isReload){
            self.tableView.reloadData()
        }
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
        return itemListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListItemTableViewCell

        // Configure the cell...
        let listItem = itemListArray[indexPath.row]
        
        cell.listItemNameLabel.text = listItem.name

        return cell
    }

    @IBAction func AddListItemListner(_ sender: UIButton) {
        displayAlertToAddTaskList()
    }

    //Alert for adding new shopping list item
    func displayAlertToAddTaskList(){
        
        let title = "Add Shop List Item"
        let doneTitle = "Create"
        
        let alertController = UIAlertController(title: title, message: "Write the name of your new list item", preferredStyle: UIAlertControllerStyle.alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.default) { (action) -> Void in
            
            let listName = alertController.textFields?.first?.text
            let realm = try! Realm()
                try! realm.write{
                    let newListItem = ListItem()
                    newListItem.name = listName!
                    self.itemListArray.append(newListItem)
                    self.shopList.listItems = List(self.itemListArray)
                    self.initializeList(true)
                }
            print(listName ?? "")
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Task List Name"
            textField.addTarget(self, action: #selector(ListItemTableViewController.listNameFieldDidChange(_:)), for: UIControlEvents.editingChanged)
//            if updatedList != nil{
//                textField.text = updatedList.name
//            }
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func listNameFieldDidChange(_ textField:UITextField){
        self.currentCreateAction.isEnabled = (textField.text?.characters.count)! > 0
    }
    
    @IBOutlet weak var SaveListListner: UIButton!
    
    // Save button listner
    @IBAction func SaveListListnerAction(_ sender: UIButton) {
        print((shopList.name == nil))
        print((shopList.name))
        if(shopList.name == nil || shopList.name == ""){
            displayAlertToSaveList()
        }else{
            let realm = try! Realm()
            try! realm.write {
//                realm.add(self.shopList)
                self.redirectToMainScreen()
            }
        }
    }
    
    // Alert for capturing List name
    func displayAlertToSaveList(){
        
        let title = "Add Shop List Name"
        let doneTitle = "Save"
        
        let alertController = UIAlertController(title: title, message: "Write the name of your list.", preferredStyle: UIAlertControllerStyle.alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.default) { (action) -> Void in
            
            var listName = alertController.textFields?.first?.text
            let realm = try! Realm()
            try! realm.write{
                if(listName == nil){
                    listName = "Shopping List"
                }
                self.shopList.name = listName!
//                realm.add(self.shopList)
                self.redirectToMainScreen()
            }
            print(listName ?? "")
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Task List Name"
            textField.addTarget(self, action: #selector(ListItemTableViewController.listNameFieldDidChange(_:)), for: UIControlEvents.editingChanged)
            //            if updatedList != nil{
            //                textField.text = updatedList.name
            //            }
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Return to main screen of list of all shopping-list
    func redirectToMainScreen(){
        delegate?.updateListTask()
        self.navigationController?.popViewController(animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
