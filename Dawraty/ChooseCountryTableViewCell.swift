//
//  ChooseCountryTableViewCell.swift
//  Dawraty
//
//  Created by SourceCode on 8/8/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class ChooseCountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
