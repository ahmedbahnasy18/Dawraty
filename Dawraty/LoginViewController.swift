//
//  LoginViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var forgotPass: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    var logRespStat : LoginResponse?
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
         setupView()
        self.title =  NSLocalizedString("loginBtn", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func loginBtnAction(_ sender: Any) {
        if(emailTextFeild.text! == "" || passwordTextFeild.text! == ""){
            self.createAlert(title:  NSLocalizedString("pleaseFillRequired", comment: ""))
        }else{
        
            hud.show(in: self.view)

        LoginAPiService.login(userName: emailTextFeild.text!, password: passwordTextFeild.text!) { (logResp, error) in
                      self.hud.dismiss()
            if(error == ""){
                self.logRespStat = logResp
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.logRespStat)
                userDefaults.set(encodedData, forKey: "logResp")
                userDefaults.synchronize()
                
                //self.createAlert(title: NSLocalizedString("successLogin", comment: ""))
                
                let alert = UIAlertController(title: NSLocalizedString("successLogin", comment: ""), message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: .cancel) { (action) in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainCategoryView") as! MainCategoryView
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.createAlert(title: NSLocalizedString("wrongData", comment: ""))
            }
        }
    }
    }
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func setupView(){
        self.loginBtn.setTitle( NSLocalizedString("loginBtn", comment: ""), for: .normal)
        self.emailTextFeild.placeholder = NSLocalizedString("emailLabel", comment: "")
        self.passwordTextFeild.placeholder = NSLocalizedString("passwordLabel", comment: "")
        self.registerBtn.setTitle( NSLocalizedString("registerNewAccount", comment: ""),for: .normal)
        self.welcome.text = NSLocalizedString("welcome", comment: "")
        self.forgotPass.setTitle( NSLocalizedString("forgotPassword", comment: ""),for: .normal)
        
    }
    
    @IBAction func ForgotPAssword(_ sender: Any) {
      
            let alert = UIAlertController(title:NSLocalizedString("sendEmail", comment: ""), message:"", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.placeholder = NSLocalizedString("emailLabel", comment: "")
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: NSLocalizedString("send", comment: ""), style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                print("Text field: \(textField?.text ?? "")")
                
                self.checkEmail(email: (textField?.text)!, type: 2 )
                
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive, handler: nil))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }
    func checkEmail (email : String, type : Int){
        if(AbstractViewController.isValidEmail(testStr: email)){
            
            
            
        }else{
            
            self.createAlert(title: NSLocalizedString("validEmail", comment: "") )
        }
    }
    func changePAssword(email : String){
        LoginAPiService.ForgetPassword(contactEmail: email) { (success, error) in
            if(error == ""){
                 self.createAlert(title: NSLocalizedString("passwordCahngesSuccess", comment: "") )
            }else{
                
            }
        }
    }
}
