//
//  ViewController.swift
//  ToDoEy
//
//  Created by Harry Nguyen on 5/1/18.
//  Copyright © 2018 Harry Nguyen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defautls = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)

        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        

        
        if let item = defautls.array(forKey: "ToDoListItem") as? [Item]
        {
            itemArray = item
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

   // MARK - Add Button Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action  = UIAlertAction(title: "ToDoEy Item", style: UIAlertActionStyle.default)
        { (aaa) in
            
            let newItem = Item()
            newItem.title = textField.text!
        
            self.itemArray.append(newItem)
            
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

