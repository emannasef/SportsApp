//
//  CustomTableViewCell.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImg: UIImageView!
    
    @IBOutlet weak var cellTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
