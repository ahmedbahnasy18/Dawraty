//
//  CourseDetailsViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import MessageUI
import JGProgressHUD

class CourseDetailsViewController: UIViewController,MFMessageComposeViewControllerDelegate {

     
     
     @IBOutlet weak var courseImg: UIImageView!
     @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var lecturName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var details: UILabel!
    
     @IBOutlet weak var phoneBtn: UIButton!
 //    @IBOutlet weak var shareBtn: UIButton!
     @IBOutlet weak var reportBtn: UIButton!
     @IBOutlet weak var smsBtn: UIButton!
     @IBOutlet weak var mapBtn: UIButton!
     @IBOutlet weak var favBtn: UIButton!
     
     @IBOutlet weak var callImg: UIImageView!
     @IBOutlet weak var smsImg: UIImageView!
     @IBOutlet weak var reportImg: UIImageView!
     @IBOutlet weak var favImgg: UIImageView!
   //  @IBOutlet weak var shareImg: UIImageView!
     @IBOutlet weak var locImg: UIImageView!
     
     
     @IBOutlet weak var courseLabelStatic: UILabel!
       @IBOutlet weak var lectureLabelStatic: UILabel!
       @IBOutlet weak var timeLabelStatic: UILabel!
       @IBOutlet weak var startDateLabelStatic: UILabel!
       @IBOutlet weak var endDateLabelStatic: UILabel!
       @IBOutlet weak var statusLabelStatic: UILabel!
       @IBOutlet weak var feesLabelStatic: UILabel!
       @IBOutlet weak var detailsLabelStatic: UILabel!
     
     @IBOutlet weak var joinNow: UIButton!
    
     @IBOutlet var cards: [UIView]!
     
     let userDefaults = UserDefaults.standard
    var userID = 0
    var phoneNo = 0
    var courseNameSms = ""
    var courseId : Int?
    var courseDets : CourseDetailsResp?
    var report : String?
let hud = JGProgressHUD(style: .dark)
     
    override func viewDidLoad() {
        super.viewDidLoad()
     hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
     print("--------->>>>\(self.courseId!)")
        self.getCourseDetails(courseId: self.courseId!)
     setUpViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     override func viewWillAppear(_ animated: Bool) {
          
          for view in cards {
               view.layer.cornerRadius = 5
               view.layer.masksToBounds = false
               view.layer.shadowOffset = CGSize(width: -1, height: 1)
               view.layer.shadowRadius = 1
               view.layer.shadowOpacity = 0.5
               view.layer.shadowColor = UIColor.lightGray.cgColor
          }
          if let userData = UserDefaults.standard.data(forKey: "logResp") {
               print("userData exists")
               
               if userData.count == 0 {
                 
               } else {
                    let decoded  = userDefaults.object(forKey: "logResp") as! Data
                    let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                    let userId = decodedUser.iD
                    self.userID = userId!
               }
          } else {

          }
     }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToLogin"){
            _ = segue.destination as! LoginViewController
            
        }
    }
 

    @IBAction func joinCourseBtn(_ sender: Any) {
        if let userData = UserDefaults.standard.data(forKey: "logResp") {
            print("userData exists")
            
            if userData.count == 0 {
                print("userData is empty")
                   performSegue(withIdentifier: "backToLogin", sender: self)
            } else {
                print("userData is not empty, it has \(userData.count) items")

               self.enrollInCourse(userId:  self.userID , courseId: self.courseId!, url: Constants.webservices.registerCourse, title: NSLocalizedString("successfullyRegistered", comment: ""))
                
            }
        } else {
            print("userData is nil")
               performSegue(withIdentifier: "backToLogin", sender: self)
        }
   
    }
    
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.cancel, handler: { (action) in
        //self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    
    }
    
     func enrollInCourse(userId : Int, courseId : Int,url : String,title : String){
          if(userId == 0){
               self.createAlert(title: NSLocalizedString("loginFirst", comment: ""))
               self.favImgg.image = #imageLiteral(resourceName: "favouriteIconGray")
          }else{
          hud.show(in: self.view)
        RegisterCourseApi.RegisterCourseApi(userId: userId, courseId: courseId, urlConcat: url, report: "") { (success, error) in
              self.hud.dismiss()
            if(error == ""){
                self.createAlert(title: title)
            }
        }
          }
    }
    
    @IBAction func locBtnAction(_ sender: Any) {
     self.locImg.image = #imageLiteral(resourceName: "locIcon")
     self.callImg.image = #imageLiteral(resourceName: "callIconGray")
     self.smsImg.image = #imageLiteral(resourceName: "smsIconGray")
     self.reportImg.image = #imageLiteral(resourceName: "flagIconGray")
    // self.shareImg.image = #imageLiteral(resourceName: "shareIconGray")
     self.favImgg.image = #imageLiteral(resourceName: "favouriteIconGray")
    }
    
    @IBAction func smsBtnAction(_ sender: Any) {
     self.locImg.image = #imageLiteral(resourceName: "locIconGray")
     self.callImg.image = #imageLiteral(resourceName: "callIconGray")
     self.smsImg.image = #imageLiteral(resourceName: "smsIcon")
     self.reportImg.image = #imageLiteral(resourceName: "flagIconGray")
  //   self.shareImg.image = #imageLiteral(resourceName: "shareIconGray")
     self.favImgg.image = #imageLiteral(resourceName: "favouriteIconGray")
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = self.courseNameSms
            controller.recipients = [String( describing: self.phoneNo)]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func reportBtnAction(_ sender: Any) {
        self.locImg.image = #imageLiteral(resourceName: "locIconGray")
     self.callImg.image = #imageLiteral(resourceName: "callIconGray")
     self.smsImg.image = #imageLiteral(resourceName: "smsIconGray")
     self.reportImg.image = #imageLiteral(resourceName: "flagIcon")
   //  self.shareImg.image = #imageLiteral(resourceName: "shareIconGray")
     self.favImgg.image = #imageLiteral(resourceName: "favouriteIconGray")
        //1. Create the alert controller.
     
//     reportLabel = "اقتراح";
//     sendReport = "ارسل اقتراح";
        let alert = UIAlertController(title:NSLocalizedString("reportLabel", comment: ""), message: NSLocalizedString("sendReport", comment: ""), preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("sendReport", comment: "")
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: NSLocalizedString("sendReport", comment: ""), style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
            self.report = textField?.text
            self.sendReport(report: self.report!, courseId: self.courseId!, userId: self.userID)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .destructive, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
//    @IBAction func shareBtnAction(_ sender: Any) {
//     self.locImg.image = #imageLiteral(resourceName: "locIconGray")
//     self.callImg.image = #imageLiteral(resourceName: "callIconGray")
//     self.smsImg.image = #imageLiteral(resourceName: "smsIconGray")
//     self.reportImg.image = #imageLiteral(resourceName: "flagIconGray")
//  //   self.shareImg.image = #imageLiteral(resourceName: "shareIcon")
//     self.favImgg.image = #imageLiteral(resourceName: "favouriteIconGray")
//
//        // set up activity view controller
//        let textToShare = [ self.courseNameSms ]
//        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//
//        // exclude some activity types from the list (optional)
//      //  activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
//        
//        // present the view controller
//        self.present(activityViewController, animated: true, completion: nil)
//
//    }
    
    
    @IBAction func callBtnAction(_ sender: Any) {
     self.locImg.image = #imageLiteral(resourceName: "locIconGray")
     self.callImg.image = #imageLiteral(resourceName: "callIcon")
     self.smsImg.image = #imageLiteral(resourceName: "smsIconGray")
     self.reportImg.image = #imageLiteral(resourceName: "flagIconGray")
    // self.shareImg.image = #imageLiteral(resourceName: "shareIconGray")
     self.favImgg.image = #imageLiteral(resourceName: "favouriteIconGray")
        let numberPhone = self.phoneNo
        
        if let url = URL(string: "tel://\(numberPhone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    @IBAction func favBtnAction(_ sender: Any) {
     self.locImg.image = #imageLiteral(resourceName: "locIconGray")
     self.callImg.image = #imageLiteral(resourceName: "callIconGray")
     self.smsImg.image = #imageLiteral(resourceName: "smsIconGray")
     self.reportImg.image = #imageLiteral(resourceName: "flagIconGray")
  //   self.shareImg.image = #imageLiteral(resourceName: "shareIconGray")
     self.favImgg.image = #imageLiteral(resourceName: "favouriteIcon")
     self.enrollInCourse(userId:  self.userID , courseId: self.courseId!, url: Constants.webservices.addToFavs, title: NSLocalizedString("addToFavsSuccess", comment: ""))
        
    }
    
    func getCourseDetails(courseId : Int){
     hud.show(in: self.view)
   
        CourseDetailsApi.CourseDetailsApi(courseId: courseId) { (courseDetails, error) in
          self.hud.dismiss()
            if(error == ""){
                self.courseDets = courseDetails
               
               if(self.courseDets?.photo == nil){
                     print("coursName nillllll")
               }
               else
               {
                    let urlImg = Constants.webservices.baseUrlImg + (self.courseDets?.photo)!
                    print(urlImg)
                    let finalUrl = URL(string: urlImg)
                   self.courseImg.kf.setImage(with: finalUrl, placeholder: #imageLiteral(resourceName: "logo"), options: nil, progressBlock: nil, completionHandler: nil)
               }
             
               
                if(self.courseDets?.phone == nil){
                    print("coursName nillllll")
                   
                }else{
                    self.phoneNo = Int ((self.courseDets?.phone)!)!
                }
                if(self.courseDets?.coursName == nil){
                     print("coursName nillllll")
                      self.courseName.text = "No Data Available"
                }else{
                    self.courseName.text = self.courseDets?.coursName
                    self.courseNameSms =  (self.courseDets?.coursName)!
                }
                
                if(self.courseDets?.nameLecturer == nil){
                    print("nillllll")
                    self.lecturName.text = "No Data Available"
                }else{
                    self.lecturName.text = self.courseDets?.nameLecturer as? String
                }
                
                if(self.courseDets?.times == nil){
                    self.time.text  = "No Data Available"
                    print("nillllll")
                }else{
                    self.time.text = self.courseDets?.times as? String
                }
                
                if(self.courseDets?.startDate == nil){
                     self.startDate.text = "No Data Available"
                    print("nillllll")
                }else{
                    self.startDate.text = self.courseDets?.startDate
                }
                
                
                if(self.courseDets?.endDate == nil){
                  self.endDate.text = "No Data Available"
                    print("nillllll")
                }else{
                    self.endDate.text = self.courseDets?.endDate
                }
                
                
                if(self.courseDets?.status == nil){
                  self.status.text =  "No Data Available"
                    print("nillllll")
                }else{
                    self.status.text = self.courseDets?.status
                }
                
                
                if(self.courseDets?.coursefees == nil){
                    self.fees.text =   "No Data Available"
                    print("nillllll")
                }else{
                    let feess = self.courseDets?.coursefees
                    self.fees.text = String(describing: feess!)
                }
                
                if(self.courseDets?.details == nil){
                   self.details.text = "No Data Available"
                    print("nillllll")
                }else{
                    self.details.text = self.courseDets?.details
                }
                
                
            }
        }
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendReport(report : String, courseId : Int, userId : Int){
        
        
        RegisterCourseApi.RegisterCourseApi(userId: userId, courseId: courseId, urlConcat: Constants.webservices.sendReport, report: self.report!) { (success, error) in
            if(error == ""){
                self.createAlertSuccess(title: "Report sent successfully!")
                
            }
        }
    }
        
        
        func createAlertSuccess(title : String){
            let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
    
     
     func setUpViews(){
          self.joinNow.setTitle(NSLocalizedString("joinNow", comment: ""), for: .normal)
          self.courseLabelStatic.text = NSLocalizedString("courseName", comment: "")
           self.lectureLabelStatic.text = NSLocalizedString("lecture", comment: "")
           self.timeLabelStatic.text = NSLocalizedString("time", comment: "")
           self.startDateLabelStatic.text = NSLocalizedString("startDate", comment: "")
           self.endDateLabelStatic.text = NSLocalizedString("endDate", comment: "")
           self.statusLabelStatic.text = NSLocalizedString("status", comment: "")
           self.feesLabelStatic.text = NSLocalizedString("fees", comment: "")
           self.detailsLabelStatic.text = NSLocalizedString("details", comment: "")
     }
     
     
     
}
