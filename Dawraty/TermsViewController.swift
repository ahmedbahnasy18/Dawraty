//
//  TermsViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class TermsViewController: UIViewController {
var pageResposns : [GetPagesResp]?
    
    @IBOutlet weak var termsText: UITextView!
    
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
         self.title =  NSLocalizedString("terms", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        for pages in self.pageResposns!{
            
            if(pages.pageId == 2){
                self.termsText.text = pages.pageContantEn
                
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
