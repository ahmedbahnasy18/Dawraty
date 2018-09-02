//
//  SearchViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var searchTableView: UITableView!
    let imageData = [#imageLiteral(resourceName: "logo") , #imageLiteral(resourceName: "logo") , #imageLiteral(resourceName: "logo")]
    let nameData = ["Course Name" , "Course Name" ,"Course Name"]
    var courses : [SearchResp]?
    let hud = JGProgressHUD(style: .dark)
    var courseIdFromSearch : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString("searchCourse", comment: "")
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        self.searchBar.placeholder = NSLocalizedString("searchCourse", comment: "")
        searchTableView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.courses != nil){
            return (self.courses?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCellTableViewCell
        if(self.courses?[indexPath.item].photo == nil){
            cell.photo.image = #imageLiteral(resourceName: "logo")
        } else{
                let urlImg = Constants.webservices.baseUrlImg + (self.courses?[indexPath.item].photo)!
                print(urlImg)
                let finalUrl = URL(string: urlImg)
               cell.photo.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        

        cell.courseName.text = self.courses?[indexPath.row].coursName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.courseIdFromSearch = self.courses?[indexPath.row].courseID
        performSegue(withIdentifier: "goToCourseDetailsFromSerach", sender: self)
    }
    func searchCourse(courseName : String){
        hud.show(in: self.view)

        SearchApi.SearchApi(courseName: courseName) { (search, error) in
                self.hud.dismiss()
            if(error == ""){
                self.courses = search
                self.searchTableView.isHidden = false
                self.searchTableView.reloadData()
            }else{
                self.createAlert(title: NSLocalizedString("noDataAvailable", comment: ""))
            }
            
        }
    }
    
    @IBAction func searchCourseBtn(_ sender: Any) {
        if(self.searchBar.text != ""){
            
            self.searchCourse(courseName: self.searchBar.text!)
        }else{
          self.createAlert(title: NSLocalizedString("enterCourseName", comment: ""))
            
        }
        
    }
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
    
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToCourseDetailsFromSerach"){
            let destination = segue.destination as! CourseDetailsViewController
            destination.courseId = self.courseIdFromSearch
        }
    }

}
