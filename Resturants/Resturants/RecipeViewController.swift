//
//  RecipeViewController.swift
//  Resturants
//
//  Created by Mark on 4/26/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit
import SafariServices


class RecipeViewController: UIViewController {
    
    var recipes: [Recipe]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        // Do any additional setup after loading the view.
    }

}

extension RecipeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell {
            print("haha")
            print(recipes)
            cell.setData(with: recipes[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }
}


extension RecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: recipes[indexPath.row].url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
}
