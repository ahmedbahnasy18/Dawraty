//
//  HelpViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD
class HelpViewController: UIViewController {

    
    @IBOutlet weak var questionView1: UIView!
    @IBOutlet weak var answerView1: UIView!
    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var plusBtn1: UIButton!
    @IBOutlet weak var answer1: UITextView!
    
    @IBOutlet weak var questionView2: UIView!
    @IBOutlet weak var answerView2: UIView!
    @IBOutlet weak var question2: UILabel!
    @IBOutlet weak var plusBtn2: UIButton!
    @IBOutlet weak var answer2: UITextView!
    @IBOutlet weak var problemsAndSolving: UILabel!
    
    let hud = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var questionOne: UILabel!
    
    @IBOutlet weak var answeOne: UITextView!
    @IBOutlet weak var questionTwo: UILabel!
    
    @IBOutlet weak var answerTwo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.title =  NSLocalizedString("faq", comment: "")
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        answerView1.isHidden = true
        answerView2.isHidden = true
        self.question1.text = NSLocalizedString("howToAddCourse", comment: "")
        self.question2.text = NSLocalizedString("howToAddAds", comment: "")
        self.problemsAndSolving.text = NSLocalizedString("problemAndSolving", comment: "")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func plusBtnAction1(_ sender: Any) {
        answerView1.isHidden = false
        answerView2.isHidden = true

    }
    
    @IBAction func plusBtnAction2(_ sender: Any) {
        answerView1.isHidden = true
        answerView2.isHidden = false

    }
    
    
    

}
