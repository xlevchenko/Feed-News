//
//  PreviewCell.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/10/22.
//

import UIKit
import ExpandableLabel

class PreviewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: ExpandableLabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var timeshamp: UILabel!
    
    var post: Post! {
        didSet {
            titleLabel.text = post.title
            previewLabel.text = post.previewText
            likesCount.text = "❤️\(post.likesCount)"
            timeshamp.text = post.timeshamp.timeAgo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewLabel.collapsed = true
        previewLabel.text = nil
    }
}
