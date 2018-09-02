//
//  ChangeLanguageViewController.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
let APPLE_LANGUAGE_KEY = "AppleLanguages"
class ChangeLanguageViewController: UIViewController {
    
    @IBOutlet weak var curentLangLabel: UILabel!
    @IBOutlet weak var changeBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.changeBtnOutlet.setTitle(NSLocalizedString("changeBtn" , comment: ""), for: .normal)
        if ChangeLanguageViewController.currentAppleLanguage() == "en" {
            self.curentLangLabel.text = NSLocalizedString("changeTo" , comment: "") + "العربية"
        }else{
            self.curentLangLabel.text = NSLocalizedString("changeTo" , comment: "") + " English"
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func changeLangBtn(_ sender: Any) {
        self.createAlert(title: NSLocalizedString("doYouWantToChangeLAng", comment: ""), message: "")
    }
    func changeCurrentLanguage(){
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if ChangeLanguageViewController.currentAppleLanguage() == "en" {
            ChangeLanguageViewController.setAppleLAnguageTo(lang: "ar")
            
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
        } else {
            ChangeLanguageViewController.setAppleLAnguageTo(lang: "en")
            
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "IntroductionViewController")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
    
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        print(langArray)
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }
    class func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    func createAlert(title : String, message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            self.changeCurrentLanguage()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.destructive, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

