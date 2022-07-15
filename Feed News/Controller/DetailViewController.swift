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
    
    var postID: String = "115"
    
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
        NetworkManager.shared.getDetailPost(for: postID) { [weak self] post, error in
            if let error = error {
                print("Failed to featch apps", error)
                return
            }
            
            DispatchQueue.main.async {
                self?.detailPost = post?.post
            }
        }
    }
}
