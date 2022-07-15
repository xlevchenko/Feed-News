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
    var states : Array<Bool>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        sortedButton()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 177
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    
    func getPosts() {
        NetworkManager.shared.getPosts { [weak self] posts, error in
            if let error = error {
                print("Failed to featch apps", error)
                return
            }

            DispatchQueue.main.async {
                self?.arrayPosts = posts?.posts ?? []
                self?.states = [Bool](repeating: true, count: (self?.arrayPosts.count)!)
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func sortedButton() {
        let sortMenu = UIMenu(title: "", children: [
            UIAction(title: "Like",state: .off, handler: { _ in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell

        cell.previewLabel.delegate = self
        cell.previewLabel.collapsedAttributedLink = NSAttributedString(string: "More", attributes: [.foregroundColor:UIColor.black])
        cell.previewLabel.setLessLinkWith(lessLink: "Less", attributes: [.foregroundColor:UIColor.red], position: .left)
        
        cell.layoutIfNeeded()
        cell.previewLabel.shouldCollapse = true
        cell.previewLabel.shouldExpand = true
        cell.previewLabel.numberOfLines = 2
        cell.previewLabel.collapsed = states[indexPath.row]
        
        cell.post = arrayPosts[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let postId = String(arrayPosts[indexPath.item].postID)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailController") as? DetailViewController else { return }
        vc.postID = postId
        navigationController?.pushViewController(vc, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow?.row{
                let selectedRow = indexPath
                let detailVC = segue.destination as! DetailViewController
            detailVC.postID = String(self.arrayPosts[selectedRow].postID)
        } else {
            print("nil")
        }
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
            states[indexPath.row] = false
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
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
}
