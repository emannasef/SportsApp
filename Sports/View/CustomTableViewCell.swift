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
        cellImg.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
  
}
