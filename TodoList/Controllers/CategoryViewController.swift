//
//  CategoryViewController.swift
//  TodoList
//
//  Created by user136891 on 3/19/18.
//  Copyright © 2018 Selahattin Hayzaran. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.separatorStyle = .none
        
        loadCategories()
        
    }

    @IBAction func addButtonPressed(_	 sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK : Table View Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row]{
            
            cell.textLabel?.text = category.name
            
            guard let categoryColour = UIColor(hexString: category.colour) else{fatalError()}
            
            cell.backgroundColor = categoryColour
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    //MARK : Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row] 
        }
        
    }
    
    //MARK : Data Manipualiton Methods
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
    }
    
    func save(category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving \(error)")
        }
       
        tableView.reloadData()
    }
    
    // Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting category \(error)")
            }
        }
    }
    
}


