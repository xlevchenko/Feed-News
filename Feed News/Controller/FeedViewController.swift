//
//  ViewController.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/9/22.
//

import UIKit
import ExpandableLabel

class FeedViewController: UITableViewController {
    
    var arrayPreview = [Posts]()
    var states: Array<Bool>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set automatic dimensions for row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        states = [Bool](repeating: true, count: arrayPreview.count)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //arrayPreview.append(Posts(posts: [
        //Post(postID: 1, timeshamp: 2, title: "Hi", previewText: "ff", likesCount: 20)
        //]))
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPreview.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSource = arrayPreview[indexPath.row].posts
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
        cell.previewLabel.delegate = self
        
        cell.previewLabel.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .center)
        
        cell.layoutIfNeeded()
        cell.previewLabel.shouldCollapse = true
        cell.previewLabel.textReplacementType = .word
        cell.previewLabel.numberOfLines = 2
        cell.previewLabel.collapsed = states[indexPath.row]
        
        cell.titleLabel.text = currentSource[indexPath.item].title
        cell.previewLabel.text = currentSource[indexPath.item].previewText
        cell.likesCount.text = "❤️\(currentSource[indexPath.item].likesCount)"
        cell.timeshamp.text = String(currentSource[indexPath.item].timeshamp)
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
