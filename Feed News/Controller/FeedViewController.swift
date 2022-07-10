//
//  ViewController.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/9/22.
//

import UIKit
import ExpandableLabel

class FeedViewController: UITableViewController {
    
    var arrayPosts = [Post]()
    var states: Array<Bool>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set automatic dimensions for row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        states = [Bool](repeating: true, count: arrayPosts.count)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPosts()
        tableView.reloadData()
    }

    
    func getPosts() {
        NetworkManager.shared.getPosts { posts, error in
            if let error = error {
                print("Failed to featch apps", error)
                return
            }
            
            self.arrayPosts = posts?.posts ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPosts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSource = arrayPosts[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
        //cell.previewLabel.delegate = self
        
        //cell.previewLabel.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .center)
        
//        cell.layoutIfNeeded()
//        cell.previewLabel.shouldCollapse = true
//        cell.previewLabel.textReplacementType = .word
//        cell.previewLabel.numberOfLines = 2
//        cell.previewLabel.collapsed = states[indexPath.row]
        
        cell.titleLabel.text = currentSource.title
        cell.previewLabel.text = currentSource.previewText
        cell.likesCount.text = "❤️\(currentSource.likesCount)"
        cell.timeshamp.text = String(currentSource.timeshamp)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//// MARK: - ExpandableLabel Delegate
//extension FeedViewController: ExpandableLabelDelegate {
//
//
//    func willExpandLabel(_ label: ExpandableLabel) {
//        tableView.beginUpdates()
//    }
//
//
//    func didExpandLabel(_ label: ExpandableLabel) {
//        let point = label.convert(CGPoint.zero, to: tableView)
//        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            states[indexPath.row] = false
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//        tableView.endUpdates()
//    }
//
//
//    func willCollapseLabel(_ label: ExpandableLabel) {
//        tableView.beginUpdates()
//    }
//
//
//    func didCollapseLabel(_ label: ExpandableLabel) {
//        let point = label.convert(CGPoint.zero, to: tableView)
//        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            states[indexPath.row] = true
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//        tableView.endUpdates()
//    }
//}