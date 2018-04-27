//
//  ShoppingListViewController.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController,UITableViewDataSource {
    
    var response: ShoppingResponse!
    var shoppingItems: [ShoppingItem]!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func checkRecipe(_ sender: Any) {
        performSegue(withIdentifier: "showRecipe", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemCell", for: indexPath) as? ShoppingItemCell {
            cell.setData(with: shoppingItems[indexPath.row])
            
//            let backgroundView: UIImageView
//
//            if UIImage(named: shoppingItems[indexPath.row].name + ".jpg") != nil{
//                backgroundView = UIImageView(image: UIImage(named: shoppingItems[indexPath.row].name + ".jpg")!)
//            } else {
//                backgroundView = UIImageView(image: UIImage(named: "default.jpg")!)
//            }
            
//            backgroundView.contentMode = .scaleAspectFill
//            cell.backgroundView = backgroundView

            return cell
        }
        return UITableViewCell()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? RecipeViewController)?.recipes = response.recipes
    }

}

extension ShoppingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

