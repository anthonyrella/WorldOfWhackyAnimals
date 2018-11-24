//
//  ProgramTableViewCell.swift
//  WorldofWhackyAnimals
//
//  Created by Raj on 2018-11-20.
//  Copyright © 2018 Raj. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblLevel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
