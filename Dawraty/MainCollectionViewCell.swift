//
//  MainCollectionViewCell.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var departmentName: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.borderWidth = 2
        self.containerView.layer.borderColor = UIColor.darkGray.cgColor
        self.containerView.layer.masksToBounds = false
        self.containerView.layer.cornerRadius = 7.5
    }
    
}
