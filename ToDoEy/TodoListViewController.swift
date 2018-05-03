//
//  ViewController.swift
//  ToDoEy
//
//  Created by Harry Nguyen on 5/1/18.
//  Copyright © 2018 Harry Nguyen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["First Comment", "Second Comment", "Third Comment"]
    
    let defautls = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let item = defautls.array(forKey: "ToDoListItem") as? [String]
        {
            itemArray = item
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

   // MARK - Add Button Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action  = UIAlertAction(title: "ToDoEy Item", style: UIAlertActionStyle.default)
        { (aaa) in
        
            self.itemArray.append(textField.text!)
            
            self.defautls.set(self.itemArray, forKey: "ToDoListItem")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (aaa) in
            aaa.placeholder = "Add here"
            textField = aaa
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

