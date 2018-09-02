//
//  SideMenuVC.swift
//  Dawraty
//
//  Created by SourceCode on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    let userDefaults = UserDefaults.standard
    let menuArr = [NSLocalizedString("courses", comment: ""),NSLocalizedString("myCourses", comment: ""), NSLocalizedString("loginBtn", comment: ""),NSLocalizedString("ads", comment: ""),NSLocalizedString("favorites", comment: ""),NSLocalizedString("support", comment: ""),NSLocalizedString("terms", comment: ""),NSLocalizedString("faq", comment: ""),NSLocalizedString("language", comment: ""),NSLocalizedString("aboutUs", comment: ""),NSLocalizedString("countries", comment: ""),NSLocalizedString("logout", comment: "")]
      let menuImg = [#imageLiteral(resourceName: "homeIcon"),#imageLiteral(resourceName: "coursesIcon"),#imageLiteral(resourceName: "loginIcon"),#imageLiteral(resourceName: "adsIcon"),#imageLiteral(resourceName: "favIcon"),#imageLiteral(resourceName: "techSupportIcon"),#imageLiteral(resourceName: "termsOfUseIcon"),#imageLiteral(resourceName: "helpIcon"),#imageLiteral(resourceName: "languageIcon"),#imageLiteral(resourceName: "AboutUsIcon"),#imageLiteral(resourceName: "kuwait"),#imageLiteral(resourceName: "exitIcon")]
    
    
    override func viewDidLoad() {
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            print("Favorites exists")
            
            if favorites.count == 0 {
                print("Favorites is empty")
                self.userName.text = "Username"
                self.email.text = "Email"
            } else {
                print("Favorites is not empty, it has \(favorites.count) items")
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                print(decodedTeams.contactEmail ?? "")
                self.userName.text = decodedTeams.contactName
                 self.email.text = decodedTeams.contactEmail
            }
        } else {
            print("Favorites is nil")
            self.userName.text = "Username"
            self.email.text = "Email"
        }    }
//goToChangeLanguage
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu") , object: nil)

        switch indexPath.row {
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("showMyCourses") , object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("showLogin") , object: nil)
        case 3:
            NotificationCenter.default.post(name: NSNotification.Name("showAds") , object: nil)
        case 4:
            NotificationCenter.default.post(name: NSNotification.Name("showFav") , object: nil)
        case 5:
            NotificationCenter.default.post(name: NSNotification.Name("showTechSupport") , object: nil)
        case 6:
            NotificationCenter.default.post(name: NSNotification.Name("showTerms") , object: nil)
        case 7:
            NotificationCenter.default.post(name: NSNotification.Name("showHelp") , object: nil)
        case 8:
               NotificationCenter.default.post(name: NSNotification.Name("goToChangeLang") , object: nil)
        case 9:
            NotificationCenter.default.post(name: NSNotification.Name("showAboutus") , object: nil)
        case 10:
            NotificationCenter.default.post(name: NSNotification.Name("showCountry") , object: nil)
        case 11:
            NotificationCenter.default.post(name: NSNotification.Name("logOut") , object: nil)
        default:
            break
        }
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! SideMenuTableViewCell
        cell.menuLabel.text = menuArr[indexPath.row]
        cell.menuIcon.image = menuImg[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
