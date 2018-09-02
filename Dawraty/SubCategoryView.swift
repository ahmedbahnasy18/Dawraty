//
//  SubCategoryView.swift
//  Dawraty
//
//  Created by SourceCode on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD


class SubCategoryView: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    

    @IBOutlet weak var collectionView: UICollectionView!
    var type = 0
    let itemsPerRow : CGFloat = 2
    var subCatArr : [SubCategorySub]?
    var tabsCourse : [CourseTabsResp]?
    var tabItems = [String]()
    var tabItemIds = [Int]()
    let hud = JGProgressHUD(style: .dark)
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
      //  self.navigationItem.title = NSLocalizedString("mainTab", comment: "")
        self.title = NSLocalizedString("subCategory", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.type)
        self.getSubCats(id: self.type)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(self.subCatArr != nil){
            return (self.subCatArr?.count)!
        }else{
            return 0
        }

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        if(self.subCatArr?[indexPath.item].photo == nil){
            cell.image.image = #imageLiteral(resourceName: "logotry")
        } else{
            let urlImg = Constants.webservices.baseUrlImg + (self.subCatArr?[indexPath.item].photo)!
            print(urlImg)
            let finalUrl = URL(string: urlImg)
            cell.image.kf.setImage(with: finalUrl)
        }
    
        if(ChangeLanguageViewController.currentAppleLanguage() == "en"){
           cell.departmentName.text = self.subCatArr?[indexPath.item].categoryNameEn
        }else{
           cell.departmentName.text = self.subCatArr?[indexPath.item].categoryNameEr
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        self.getTabItems(catId: (self.subCatArr?[indexPath.item].iD)!)
    }

    func getSubCats(id : Int){
       hud.show(in: self.view)
        SubCategoryApi.SubCategoryApi(depId: id) { (arr, error) in
            print(arr?.count ?? 0)
              self.hud.dismiss()
            if(error == ""){
                self.subCatArr = arr
                self.collectionView.reloadData()
            }
            
        }
        
    }
    
    
    func getTabItems(catId : Int){
        print(catId)
        

        GetCourseTabsApi.GetCourseTabsApi(CategoryID: catId) { (courseTabs, error) in
            print(courseTabs?.count ?? 99)
            self.tabItems = []
            self.tabItemIds = []
            if(error == ""){
               self.tabsCourse = courseTabs
                for names in self.tabsCourse!{
                    print(names.sectionsNameEn ?? "")
                    self.tabItemIds.append(names.sectionId!)
                    if(ChangeLanguageViewController.currentAppleLanguage() == "en"){
                        self.tabItems.append(names.sectionsNameEn!)
                    } else {
                        self.tabItems.append(names.sectionsNameEr!)
                    }
                }
                print(self.tabItems.count)
                self.performSegue(withIdentifier: "goToCoursesTabs", sender: self)
            }else{
                self.createAlert(title: NSLocalizedString("noCoursesAvailable", comment: ""))
            }
            
        }
  
    }
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.cancel, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToCoursesTabs"){
            let des = segue.destination as! CoursesViewController
            des.items = self.tabItems
            des.tabItemIds = self.tabItemIds
           // des.tabsCourse = self.tabsCourse
            Constants.mainCategories.tabsCourse = self.tabsCourse
            
        }
    }

}
