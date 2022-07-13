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
    var idLable: UILabel!
    
    var detailPost: PostResult?
    var postID: String = "117"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailPost(id: postID)
    }
    
    
    func getDetailPost(id: String) {
        NetworkManager.shared.getDetailPost(for: id) { [weak self] post, error in
            if let error = error {
                print("Failed to featch apps", error)
                return
            }
            
            self?.detailPost = post?.post
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    
    func updateUI() {
        imageView.sd_setImage(with: URL(string: detailPost?.postImage ?? "nil"))
        titleLabel.text = detailPost?.title ?? "nil"
        reviewLabel.text = detailPost?.text ?? "nil"
        likesLabel.text = "❤️\(detailPost?.likesCount ?? 0)"
        dateLabel.text = "\(detailPost?.timeshamp.timeAgo() ?? "")"
    }
    
}


//        init(postID: String) {
//            self.postID = postID
//            super.init(nibName: nil, bundle: nil)
//        }
//
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }//        init(postID: String) {
//            self.postID = postID
//            super.init(nibName: nil, bundle: nil)
//        }
//
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
