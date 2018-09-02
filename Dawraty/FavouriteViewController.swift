//
//  FavouriteViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD

class FavouriteViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var subCatTableView: UITableView!
    var ads : [AdsResp]?
    let userDefaults = UserDefaults.standard
    var userID = 0
    let hud = JGProgressHUD(style: .dark)
    var courseId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        self.title =  NSLocalizedString("favorites", comment: "")
        subCatTableView.dataSource = self
        subCatTableView.delegate = self
        if let userData = UserDefaults.standard.data(forKey: "logResp") {
            print("userData exists")
            
            if userData.count == 0 {
                print("userData is empty")
                    self.createAlertLogin(title:  NSLocalizedString("loginFirst", comment: ""))
            } else {
                print("userData is not empty, it has \(userData.count) items")
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                let userId = decodedUser.iD
                self.userID = userId!
                self.getFavs(id: self.userID)
                
            }
        } else {
            print("userData is nil")
              self.createAlertLogin(title: NSLocalizedString("loginFirst", comment: ""))
            
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if let userData = UserDefaults.standard.data(forKey: "logResp") {
//            print("userData exists")
//
//            if userData.count == 0 {
//                print("userData is empty")
//              ///         performSegue(withIdentifier: "backToLoginFromFavs", sender: self)
//            } else {
//                print("userData is not empty, it has \(userData.count) items")
//                let decoded  = userDefaults.object(forKey: "logResp") as! Data
//                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
//                let userId = decodedUser.iD
//                self.userID = userId!
//                self.getFavs(id: self.userID)
//
//            }
//        } else {
//            print("userData is nil")
//          //  self.createAlertLogin(title: "Please login first!!")
//
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.subCatTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCellTableViewCell
      
        if(self.ads?[indexPath.item].photo == ""){
        cell.photo.image = #imageLiteral(resourceName: "logotry")
        }else{
        let urlImg = Constants.webservices.baseUrlImg + (self.ads?[indexPath.item].photo)!
        print(urlImg)
        let finalUrl = URL(string: urlImg)
       cell.photo.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
    }
        
        if(ChangeLanguageViewController.currentAppleLanguage() == "en"){
           cell.courseName.text = self.ads?[indexPath.row].coursName
        }else{
           cell.courseName.text = self.ads?[indexPath.row].coursName
        }
        
        cell.deleteBtn.setTitle(NSLocalizedString("deleteFavs", comment: ""), for: .normal)
        cell.deleteBtn.addTarget(self, action: #selector(self.deleteFavs(button:)), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.ads != nil){
            return (self.ads?.count)!
        }else{
            return 0
        }
    }
    
    func getFavs(id : Int){
        hud.show(in: self.view)

        GetAds.GetAds(concaturl: Constants.webservices.concatFavs, userID: id) { (adsResp, error) in
            self.hud.dismiss()
            if(error == ""){
                self.ads = adsResp
                self.subCatTableView.reloadData()
            }
        }
        
    }
    func createAlertLogin(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
              self.performSegue(withIdentifier: "backToLoginFromFavs", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @objc func deleteFavs(button: UIButton){
        print(button.tag)
        print(self.ads?[button.tag].courseIdFavs ?? 0)
        self.courseId = self.ads?[button.tag].courseIdFavs
        let alert = UIAlertController(title: NSLocalizedString("deleteFavs", comment: ""), message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: { (action) in
            self.deleteFavorite(userId: self.userID, courseId: self.courseId!)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func deleteFavorite(userId : Int, courseId : Int){
         hud.show(in: self.view)
        DeleteFavorite.DeleteFavorite(userId: userId, courseId: courseId) { (success, error) in
          
            if(error == ""){
                 self.hud.dismiss()
                self.createALertDeleted()
                
            }else{
                 self.hud.dismiss()
            }
        }
    }
    
    func createALertDeleted(){
        let alert = UIAlertController(title: NSLocalizedString("successfullyDeleted", comment: ""), message: "", preferredStyle: UIAlertControllerStyle.alert)
       
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler:  { (action) in
            self.getFavs(id: self.userID)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
