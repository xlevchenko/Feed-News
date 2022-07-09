//
//  ViewController.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/9/22.
//

import UIKit
import ExpandableLabel

class FeedViewController: UITableViewController {

    //@IBOutlet weak var previewLabel: ExpandableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set automatic dimensions for row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
       
        //previewLabel.numberOfLines = 2
        //previewLabel.collapsed = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

