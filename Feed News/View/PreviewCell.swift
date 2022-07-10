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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
