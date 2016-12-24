//
//  TFollowerTableViewCell.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 23/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import UIKit

class TFollowerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backgroundColoredView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
