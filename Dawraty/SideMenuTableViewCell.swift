//
//  SideMenuTableViewCell.swift
//  Dawraty
//
//  Created by SourceCode on 8/7/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuIcon: UIImageView!
    
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
