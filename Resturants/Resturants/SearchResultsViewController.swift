//
//  SearchResultsViewController.swift
//  Resturants
//
//  Created by qin on 4/21/18.
//  Copyright © 2018 qin. All rights reserved.
//

import UIKit
import SafariServices

class SearchResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var resturants: [Resturant]!
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "resturantCell", for: indexPath) as? ResturantCell {
            cell.setData(with: resturants[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SearchResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: resturants[indexPath.row].url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
}
