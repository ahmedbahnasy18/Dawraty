//
//  MyCoursesViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD
class MyCoursesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    let itemsPerRow : CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    @IBOutlet weak var myCoursesTableView: UITableView!
    var userID = 0
    var myCourseListTable : [MyCoursesResp]?
    let userDefaults = UserDefaults.standard
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString("myCourses", comment: "")
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        
        myCoursesTableView.dataSource = self
        myCoursesTableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self

        
        //        self.subCatTableView.rowHeight = UITableViewAutomaticDimension
        //        self.subCatTableView.estimatedRowHeight = 210
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                createAlertLogin(title : NSLocalizedString("loginFirst", comment: ""))
              
                
            } else {
                print("you're logged in")
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                let userId = decodedUser.iD
                self.userID = userId!
                self.getMyCourses(userID : self.userID)
            }
        } else {
            print("you're logged in")
            createAlertLogin(title : NSLocalizedString("loginFirst", comment: ""))
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCoursesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.myCourseListTable != nil){
            return (self.myCourseListTable?.count)!
        }else{
            return 0
        }
    }
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(self.myCourseListTable != nil){
            return (self.myCourseListTable?.count)!
        }else{
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myCoursesTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCellTableViewCell
        
        let urlImg = Constants.webservices.baseUrlImg + (self.myCourseListTable?[indexPath.item].photo)!
        print(urlImg)
        let finalUrl = URL(string: urlImg)
        cell.photo.kf.setImage(with: finalUrl)
        cell.courseName.text = self.myCourseListTable?[indexPath.row].coursName
        
        
        return cell
    }

    //
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        
        let urlImg = Constants.webservices.baseUrlImg + (self.myCourseListTable?[indexPath.item].photo)!
        print(urlImg)
        let finalUrl = URL(string: urlImg)
        cell.image.kf.setImage(with: finalUrl)
        cell.departmentName.text = self.myCourseListTable?[indexPath.row].coursName
        
//        if(self.subCatArr?[indexPath.item].photo == nil){
//            cell.image.image = #imageLiteral(resourceName: "logotry")
//        } else{
//            let urlImg = Constants.webservices.baseUrlImg + (self.subCatArr?[indexPath.item].photo)!
//            print(urlImg)
//            let finalUrl = URL(string: urlImg)
//            cell.image.kf.setImage(with: finalUrl)
//        }
//
//        if(ChangeLanguageViewController.currentAppleLanguage() == "en"){
//            cell.departmentName.text = self.subCatArr?[indexPath.item].categoryNameEn
//        }else{
//            cell.departmentName.text = self.subCatArr?[indexPath.item].categoryNameEr
//        }
//
        return cell
    }
    
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func getMyCourses(userID : Int){
        hud.show(in: self.view)
    
        MyCoursesApi.MyCoursesApi(userId: userID) { (myCourseList, error) in
            self.hud.dismiss()
            if(error == ""){
                self.myCourseListTable = myCourseList
                self.myCoursesTableView.reloadData()
                
            }
        }
        
    }

    func createAlertLogin(title : String){
        let alert = UIAlertController(title: title, message:"", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: "") , style: UIAlertActionStyle.default, handler: { (action) in
              self.performSegue(withIdentifier: "goToLoginFromMyCourses", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }

}
