//
//  CategoryViewController.swift
//  ToDoEy
//
//  Created by Harry Nguyen on 5/10/18.
//  Copyright © 2018 Harry Nguyen. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController

{
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadCategory()

    }

    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categoryArray.count
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
          performSegue(withIdentifier: "gotoItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory()
    {
        do
        {
        try context.save()
        }
        catch
        {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory()
    {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do
        {
            categoryArray = try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context \(error)")
        }
    }

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Category", style: UIAlertActionStyle.default)
        { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            
        }
        
        alert.addTextField { (add) in
            add.placeholder = "Add here"
            textField = add
        
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

    
    
    
}
