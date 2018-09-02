//
//  AbstractViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func validateFeilds(username: String, password : String) -> Bool{
        if(username.isEmpty == true || password.isEmpty == true || username == "" ||  password == "" ){
            return false
        }else{
            return true
        }
        
    }
    
    
    class func validateFeildsRegister(username: String, password : String,email: String, contactPhone : String,address: String) -> Bool{
        if(username.isEmpty == true || password.isEmpty == true || email.isEmpty == true || contactPhone.isEmpty == true || address.isEmpty == true  || username == "" ||  password == ""  || email == "" ||  contactPhone == ""  ||  address == "" ){
            return false
        }else{
            return true
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
    class func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func getRates(rate : Float)->Double{
        
        if rate == 0.5 {
            return 0.5
        }
        if rate == 1 {
            return 1
        }
        if rate == 1.5 {
            return 1.5
        }
        if rate == 2 {
            return 2
        }
        if rate == 2.5 {
            return 2.5
        }
        if rate == 3 {
            return 3
        }
        if rate == 3.5 {
            return 3.5
        }
        if rate == 4 {
            return 4
        }
        if rate == 4.5  || rate == 4.6{
            return 4.5
        }
        if rate == 5 {
            return 5
        }
        return 1
    }
}
