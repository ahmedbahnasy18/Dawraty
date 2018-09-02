//
//  TecSupportViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class TecSupportViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var questionText: UITextField!
    
    
    @IBOutlet weak var whatIsQuestion: UILabel!
    
    @IBOutlet weak var contactUsLabel: UILabel!
    
    @IBOutlet weak var moreInfoNumLabel: UILabel!
    
    
    @IBOutlet weak var contactEmail: UILabel!
    
    
    @IBOutlet weak var sendImg: UIImageView!
    
    
    
    
    let hud = JGProgressHUD(style: .dark)
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
         self.title = NSLocalizedString("support", comment: "")
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendQuestion(_ sender: Any) {
        self.questionTextView.text = self.questionText.text
        self.senQuestion(question: self.questionText.text!)
        
    }
    func senQuestion(question : String){
        if let userData = UserDefaults.standard.data(forKey: "logResp") {
            print("userData exists")
            
            if userData.count == 0 {

                self.createAlert(title: NSLocalizedString("loginFirst", comment: ""))
            } else {
                print("userData is not empty, it has \(userData.count) items")
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                let userId = decodedUser.iD
                hud.show(in: self.view)
                TechnicalSupportApi.TechnicalSupportApi(question: question, userID: userId!) { (success, error) in
                    self.hud.dismiss()
                    if(error == ""){
                        self.createAlert(title:NSLocalizedString("questionSent", comment: ""))
                    }
                }
            }
        } else {
            print("userData is nil")
                 self.createAlert(title: NSLocalizedString("loginFirst", comment: ""))
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
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func setUpView(){

        self.questionText.placeholder = NSLocalizedString("writeProb", comment: "")
        self.whatIsQuestion.text = NSLocalizedString("whatIsProblem", comment: "")
          self.questionTextView.text = NSLocalizedString("whatIsProblem", comment: "")
         self.questionTextView.textColor = UIColor.lightGray
         self.contactUsLabel.text = NSLocalizedString("conatctUs", comment: "")
         self.moreInfoNumLabel.text = NSLocalizedString("forMoreInfo", comment: "")
         self.contactEmail.text = NSLocalizedString("emailUs", comment: "")
        if(ChangeLanguageViewController.currentAppleLanguage() == "en"){
            self.sendImg.image = #imageLiteral(resourceName: "sendIcon")
        }else{
            self.sendImg.image = #imageLiteral(resourceName: "sendFliiped")
        }
        
    }
}
