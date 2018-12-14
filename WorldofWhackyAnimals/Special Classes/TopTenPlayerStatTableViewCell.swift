//
//  TopTenPlayerStatTableViewCell.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-12-13.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//
//  Primary Author: Anthony Rella
//
//  TopTenPlayerStatTableViewCell is used to set the variables to be used in the top ten table

import UIKit

class TopTenPlayerStatTableViewCell: UITableViewCell {
    
    @IBOutlet var name : UILabel!
    @IBOutlet var score : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
