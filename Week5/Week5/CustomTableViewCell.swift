//
//  CustomTableViewCell.swift
//  Week5
//
//  Created by Aryan Bishnoi on 9/5/20.
//  Copyright © 2020 Aryan Bishnoi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var ImageV: UIImageView!
    @IBOutlet weak var Sname: UILabel!
    @IBOutlet weak var Fname: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
