//
//  DetailViewController.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/12/22.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var containerView: UIView!
    var postID: String!
    
    var detailPost: PostResult! {
        didSet {
            imageView.sd_setImage(with: URL(string: detailPost.postImage))
            titleLabel.text = detailPost.title
            reviewLabel.text = detailPost.text
            likesLabel.text = "❤️\(detailPost.likesCount)"
            dateLabel.text = String(detailPost.timeshamp.timeAgo())
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailPost()
    }
    
    
    func getDetailPost() {
        showLoadingView()
        
        NetworkManager.shared.getDetailPost(for: postID) { [weak self] post, error in
            self?.dismissLoadingView()
            if let error = error {
                print("Failed to featch apps", error)
                return
            }
            
            DispatchQueue.main.async {
                self?.detailPost = post?.post
                
            }
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 1.0 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
