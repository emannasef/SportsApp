//
//  CustomTableViewCell.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var gotToYouTube: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Round image
        
       
        cellImg.layer.cornerRadius = cellImg.frame.height / 2
        cellImg.layer.masksToBounds = true
        cellImg.layer.borderColor = UIColor.blue.cgColor
        cellImg.layer.borderWidth = 0.7
        cellImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
  
}
