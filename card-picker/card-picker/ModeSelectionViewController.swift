//
//  HomeViewController.swift
//  cardPicker
//
//  Created by Abhishek Kumar on 22/02/22.
//

import Foundation
import UIKit

class ModeSelectionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let tableViewRows = ["Single-Player", "Multi-Player"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ModeSelectionViewController: UITableViewDelegate {
    
    func go(to View: Int ) {
        switch View {
        case 0: performSegue(withIdentifier: "singlePlayer", sender: nil)
        case 1: performSegue(withIdentifier: "multiPlayer", sender: nil)
        default: print("View Didn't found")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        go(to: indexPath.row)
    }
}


extension ModeSelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableViewRows[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows.count
    }

}
