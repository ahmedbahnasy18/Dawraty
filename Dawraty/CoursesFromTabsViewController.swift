//
//  CoursesFromTabsViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class CoursesFromTabsViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    let itemsPerRow : CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    //@IBOutlet weak var courseTableView: UITableView!
    let imageData = [#imageLiteral(resourceName: "logo") , #imageLiteral(resourceName: "logo") , #imageLiteral(resourceName: "logo")]
    let nameData = ["Course Name" , "Course Name" ,"Course Name"]
    var list = [[InnerCourseList]]()
    var tableList = [InnerCourseList]()
    var progressStatus : Int?
    var courseIdFromTabs : Int?
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = NSLocalizedString("pleaseWait", comment: "")
        self.title = ""
        list = [[]]
        tableList = []
        getCoursesList()
        //courseTableView.dataSource = self
        //courseTableView.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(progressStatus ?? 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 210
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(tableList.count == 0){
//            return 0
//        }else{
//            return tableList.count
//        }
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(tableList.count == 0){
            return 0
        }else{
            return tableList.count
        }
        
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.courseTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCellTableViewCell
//
//        if(self.tableList[indexPath.item].photo == ""){
//            cell.photo.image = #imageLiteral(resourceName: "logo")
//        } else{
//            let urlImg = Constants.webservices.baseUrlImg + (self.tableList[indexPath.item].photo)!
//            print(urlImg)
//            let finalUrl = URL(string: urlImg)
//           cell.photo.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
//        }
//            cell.courseName.text = tableList[indexPath.row].coursName
//
//        return cell
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        
        if(self.tableList[indexPath.item].photo == ""){
            cell.image.image = #imageLiteral(resourceName: "logo")
        } else{
            let urlImg = Constants.webservices.baseUrlImg + (self.tableList[indexPath.item].photo)!
            print(urlImg)
            let finalUrl = URL(string: urlImg)
            cell.image.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        cell.departmentName.text = tableList[indexPath.row].coursName
        
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
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseDetailsViewController") as! CourseDetailsViewController
        self.courseIdFromTabs = self.tableList[indexPath.row].courseId!
        vc.courseId = self.courseIdFromTabs
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getCoursesList(){
      
            //loop on the 40 element to get the day yhat equaual the progress status
        for i in 0..<(Constants.mainCategories.tabsCourse?.count)!{
                if(Constants.mainCategories.tabsCourse![i].sectionId == progressStatus){
                    list.append((Constants.mainCategories.tabsCourse?[i].cource)!)
                }
            }

        for course in list{
            for s in course{
                 self.tableList.append(s)
            }
        }
     
}
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        self.courseIdFromTabs = self.tableList[indexPath.row].courseId!
//        self.performSegue(withIdentifier: "detailsFromCourseTabs", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "detailsFromCourseTabs"){
//            let destination = segue.destination as! CourseDetailsViewController
//            destination.courseId = self.courseIdFromTabs
//        }
//    }
}
