//
//  IntroductionViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD
import FacebookLogin
import FBSDKLoginKit


class IntroductionViewController: UIViewController {
 
    @IBOutlet weak var skip: UIButton!
    @IBOutlet weak var signUp: UIButton!
    var dict : [String : AnyObject]!
    var name : String?
    var email : String?
    var fbID : String?
    var loginRespFB : LoginResponse?
       var loginRespFBSav : LoginResponse?
     let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.skip.setTitle(NSLocalizedString("skip", comment: ""), for: .normal)
        self.signUp.setTitle(NSLocalizedString("registerNewAccount", comment: ""), for: .normal)
         hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        self.signUp.backgroundColor = .clear
        self.signUp.layer.cornerRadius = 10
        self.signUp.layer.borderWidth = 1.5
        self.signUp.layer.borderColor = UIColor.black.cgColor
        
        self.skip.backgroundColor = .clear
        self.skip.layer.cornerRadius = 10
        self.skip.layer.borderWidth = 1.5
        self.skip.layer.borderColor = UIColor.black.cgColor
        //creating button
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email])
        loginButton.center = view.center
        
        //adding it to view
        view.addSubview(loginButton)
        
        //if the user is already logged in
        if (FBSDKAccessToken.current()) != nil{
            getFBUserData()
        }
        
    }
    
    //when login button clicked
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                   self.createAlert(title: NSLocalizedString("somethingWrong", comment: ""))
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print(grantedPermissions)
                 print(declinedPermissions)
                 print(accessToken)
                self.getFBUserData()
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
hud.show(in: self.view)
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
              
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print("dddd")
                    print(self.dict)
                    for parmas in self.dict{
                        print(parmas.key)
                        print(parmas.value)
                        self.name = self.dict["name"] as? String
                        self.email = self.dict["email"] as? String
                        self.fbID = self.dict["id"] as? String
                    }

                    self.sendFbData(name: self.name!, email: self.email!, fbID:  self.fbID!)
                }
            })
        }
}
    
    func sendFbData(name : String, email : String, fbID : String){
        
            let whitespace = NSCharacterSet.whitespaces
            let phrase = name
            let range = phrase.rangeOfCharacter(from: whitespace)
            var finalStringName = ""
            if range != nil {
                print("whitespace found")
                finalStringName = phrase.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            }
            else {
                finalStringName = phrase
                print("whitespace not found")
            }
        RegisterationApi.LoginFacebook(ContactName: finalStringName, ContactEmail: email, IDAuto: fbID) { (success, error) in
            if(error == ""){
                self.hud.dismiss()
                self.loginRespFB = LoginResponse(contactName: self.name!, contactEmail: self.email!, iD: Int((success?.message)!)!)
                let userDefaults = UserDefaults.standard
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.loginRespFB)
                userDefaults.set(encodedData, forKey: "logResp")
                userDefaults.synchronize()
                self.createAlert(title: NSLocalizedString("loggedInFB", comment: ""))
            }else{
             self.hud.dismiss()
            }
          //  print(self.loginRespFB?.contactName)
        }
    
    }
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.cancel, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
