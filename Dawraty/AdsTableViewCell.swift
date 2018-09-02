//
//  AdsTableViewCell.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class AdsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var joinBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func JoinBtnAction(_ sender: Any) {
        
    }
    

}
