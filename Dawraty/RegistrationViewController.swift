//
//  RegistrationViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var registerItem: UINavigationItem!
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var phoneTextFeild: UITextField!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    
    var success = false
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if ChangeLanguageViewController.currentAppleLanguage() == "en" {
         self.backBtn.image = #imageLiteral(resourceName: "backButton")
        }else{
              self.backBtn.image = #imageLiteral(resourceName: "backFlipped")
        }
    }
    func setupView(){
      
        self.nameTextFeild.placeholder =  NSLocalizedString("nameText", comment: "")
        self.phoneTextFeild.placeholder =  NSLocalizedString("conatctNumber", comment: "")
        self.emailTextFeild.placeholder = NSLocalizedString("emailLabel", comment: "")
        self.passwordTextFeild.placeholder = NSLocalizedString("passwordLabel", comment: "")
        self.registerBtn.setTitle(NSLocalizedString("registerBtn", comment: ""), for: .normal)
        self.registerItem.title = NSLocalizedString("registerNewAccount", comment: "")
        self.welcomeLabel.text = NSLocalizedString("welcome", comment: "")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func registerActionBtn(_ sender: Any) {
        if(nameTextFeild.text == "" || emailTextFeild.text == "" || passwordTextFeild.text == "" || phoneTextFeild.text == ""){
            
            self.createAlert(title: "Please fill required!")
        }else{
            
            self.register(name: nameTextFeild.text!, email: emailTextFeild.text!, phone: phoneTextFeild.text!, password: passwordTextFeild.text!)
        }
        
        
        
    }
    
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
         if(self.success == true){
        alert.addAction(UIAlertAction(title: "Go back to Main", style: UIAlertActionStyle.default, handler: { (action) in
           
        }))
         }else{
            
            alert.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.default, handler: { (action) in
                
            }))
        }
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func register(name : String,email : String,phone : String,password : String){
        hud.show(in: self.view)
     
        RegisterationApi.RegisterationApi(ContactName: name, ContactEmail: email, ContactPhone: phone, Password: password) { (success, error) in
               self.hud.dismiss()
            if(error == ""){
                self.success = true
                self.createAlert(title:NSLocalizedString("successfullyRegistered", comment: ""))
            }
            
            
        }
        
    }
    
    
    
}
