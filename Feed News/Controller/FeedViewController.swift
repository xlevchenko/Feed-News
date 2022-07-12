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
        tableView.estimatedRowHeight = 144
        states = [Bool](repeating: true, count: arrayPosts.count)
        sortedButton()
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
    
    
    func sortedButton() {
        let sortMenu = UIMenu(title: "", children: [
            UIAction(title: "Like",state: .on, handler: { _ in
                self.arrayPosts.sort { post1, post2 in
                    return post1.likesCount < post2.likesCount
                }
                self.tableView.reloadData()
            }),
            UIAction(title: "Date", state: .off, handler: { _ in
                self.arrayPosts.sort { post1, post2 in
                    return post1.timeshamp < post2.timeshamp
                }
                
                self.tableView.reloadData()
            })
        ])
        
        let button = UIBarButtonItem(title: "Sort", menu: sortMenu)
        navigationItem.rightBarButtonItem = button
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSource = arrayPosts[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
        cell.previewLabel.delegate = self
        
        cell.previewLabel.collapsedAttributedLink = NSAttributedString(string: "Read More", attributes: [.foregroundColor:UIColor.black])
        cell.previewLabel.setLessLinkWith(lessLink: "Read Less", attributes: [.foregroundColor:UIColor.red], position: .natural)
        
        cell.layoutIfNeeded()
        cell.previewLabel.shouldCollapse = true
        cell.previewLabel.shouldExpand = true
        cell.previewLabel.textReplacementType = .word
        cell.previewLabel.numberOfLines = 2
        cell.previewLabel.collapsed = true
        
        
        cell.titleLabel.text = currentSource.title
        cell.previewLabel.text = currentSource.previewText
        cell.likesCount.text = "❤️\(currentSource.likesCount)"
        cell.timeshamp.text = currentSource.timeshamp.timeAgo()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - ExpandableLabel Delegate
extension FeedViewController: ExpandableLabelDelegate {
    
    
    func willExpandLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
    
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
}
