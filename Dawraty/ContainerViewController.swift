//
//  ContainerViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var mainContainerView: UIView!
   
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    @objc func toggleSideMenu(){
        if sideMenuOpen{
            sideMenuOpen = false
           sideMenuConstraint.constant = -240
        }
        else{
            sideMenuOpen = true
            sideMenuConstraint.constant = 0

        }
        
        UIView.animate(withDuration: 0.3 ){
            self.view.layoutIfNeeded()
        }
    }

}
