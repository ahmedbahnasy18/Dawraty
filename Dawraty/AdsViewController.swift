//
//  AdsViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD

class AdsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var subCatTableView: UITableView!
    var ads : [AdsResp]?
    var courseId : Int?
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ads", comment: "")
        subCatTableView.dataSource = self
        subCatTableView.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAds()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.ads != nil){
            return (self.ads?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.subCatTableView.dequeueReusableCell(withIdentifier: "AdsCustomCell") as! AdsTableViewCell
        if (self.ads?[indexPath.item].photo != ""){
        let urlImg = Constants.webservices.baseUrlImg + (self.ads?[indexPath.item].photo)!
                print(urlImg)
                let finalUrl = URL(string: urlImg)
            cell.photo.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        cell.courseName.text = self.ads?[indexPath.row].coursName
        cell.joinBtn.setTitle(NSLocalizedString("joinNow", comment: ""), for: .normal)
        cell.joinBtn.addTarget(self, action: #selector(self.joinNow(button:)), for: .touchUpInside)
        cell.joinBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        subCatTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getAds(){
        hud.show(in: self.view)
        GetAds.GetAds(concaturl: Constants.webservices.concatAds, userID: 0) { (adsResp, error) in
           self.hud.dismiss()
            if(error == ""){
                self.ads = adsResp
                self.subCatTableView.reloadData()
            }
        }
        
    }
    @objc func joinNow(button: UIButton){
        print(button.tag)
        print(self.ads?[button.tag].coursesID ?? 0)
        self.courseId = self.ads?[button.tag].coursesID
        self.performSegue(withIdentifier: "goToCourseDetailsFromAds", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToCourseDetailsFromAds"){
            let des = segue.destination as! CourseDetailsViewController
            des.courseId = self.courseId
            
        }
    }
}
