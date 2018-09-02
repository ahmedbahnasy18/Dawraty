//
//  MainCategoryView.swift
//  Dawraty
//
//  Created by SourceCode on 7/22/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainCategoryView: UIViewController , UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource{
    
    

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainCategoryItem: UINavigationItem!
    @IBOutlet weak var adsItemBarButton: UIBarButtonItem!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var searchButton: UIButton!
    
    
    let hud = JGProgressHUD(style: .dark)
    var images:[String] = ["imageSlide1" , "imageSlide2" , "imageSlide3" , "imageSlide1"]
    var frame = CGRect(x:0 , y:0 , width: 0 , height:0)
    var type = 0
     let userDefaults = UserDefaults.standard
    var pageResposns : [GetPagesResp]?
    let listArr = [UIImage(named: "APLLICATION 2 -41"),#imageLiteral(resourceName: "APLLICATION 2 -39"),#imageLiteral(resourceName: "APLLICATION 2 -40"),#imageLiteral(resourceName: "APLLICATION 2 -42"),#imageLiteral(resourceName: "APLLICATION 2 -43")]
  
    let listArrLabel = [NSLocalizedString("dept3", comment: ""),NSLocalizedString("dept1", comment: ""),NSLocalizedString("dept2", comment: ""),NSLocalizedString("dept4", comment: ""),NSLocalizedString("dept5", comment: "")]
    override func viewDidLoad() {
        super.viewDidLoad()
         getAppPages()
        self.adsItemBarButton.title = NSLocalizedString("ads", comment: "")
        self.searchButton.setTitle(NSLocalizedString("searchCourse", comment: ""), for: .normal)
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        self.mainCategoryItem.title = NSLocalizedString("mainCategory", comment: "")
        pageControl.numberOfPages = images.count
        
        for index in 0..<images.count{
            frame.origin.x = imageScrollView.frame.size.width * CGFloat(index)
            frame.size = imageScrollView.frame.size
            
            
            let imageView = UIImageView(frame: frame)
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imageView.autoresizesSubviews = true
            //imageView.frame = frame
            imageView.image = UIImage(named: images[index])
            self.imageScrollView.addSubview(imageView)
        }
        
        imageScrollView.contentSize = CGSize(width: (imageScrollView.frame.size.width * CGFloat(images.count)) , height: imageScrollView.frame.size.height)
        
        imageScrollView.delegate = self
        
        
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showLogin),
                                               name: NSNotification.Name("showLogin"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAds),
                                               name: NSNotification.Name("showAds"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showFav),
                                               name: NSNotification.Name("showFav"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAboutus),
                                               name: NSNotification.Name("showAboutus"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showTerms),
                                               name: NSNotification.Name("showTerms"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showTechSupport),
                                               name: NSNotification.Name("showTechSupport"),
                                               object: nil)
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showMyCourses),
                                               name: NSNotification.Name("showMyCourses"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHelp),
                                               name: NSNotification.Name("showHelp"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logOut),
                                               name: NSNotification.Name("logOut"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeLang),
                                               name: NSNotification.Name("goToChangeLang"),
                                               object: nil)
    
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCountry),
                                               name: NSNotification.Name("showCountry"),
                                               object: nil)
    
    }
    
    
    @objc func showMyCourses(){
        performSegue(withIdentifier: "myCoursesIdentifier", sender: nil)
    }
    @objc func showLogin(){
  
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                   performSegue(withIdentifier: "loginIdentifier", sender: nil)
               
            } else {
              print("you're logged in")
                self.createAlert(title:  "you're logged in")
            }
        } else {
           print("you're logged in")
             performSegue(withIdentifier: "loginIdentifier", sender: nil)
        }
    }
    @objc func showAds(){
        performSegue(withIdentifier: "adsIdentifier", sender: nil)
    }
    @objc func showFav(){
        performSegue(withIdentifier: "favIdentifier", sender: nil)
    }
    @objc func showAboutus(){
        performSegue(withIdentifier: "aboutUsIdentifier", sender: nil)
    }
    @objc func showTerms(){
        performSegue(withIdentifier: "termsIdentifier", sender: nil)
    }
    @objc func showTechSupport(){
        performSegue(withIdentifier: "tecSupportIdentifier", sender: nil)
    }
    @objc func showHelp(){
        performSegue(withIdentifier: "helpIdentifier", sender: nil)
    }

    @objc func logOut(){
        //performSegue(withIdentifier: "logOut", sender: nil)
        self.createAlertLogout(title: NSLocalizedString("confirmLog", comment: ""))
    }
    
    @objc func changeLang(){
        performSegue(withIdentifier: "goToChangeLanguage", sender: nil)
    }
    
    @objc func showCountry(){
        print("countryy")
        performSegue(withIdentifier: "goToCountries", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            print("Favorites exists")
            
            if favorites.count == 0 {
                print("Favorites is empty")
            } else {
                print("Favorites is not empty, it has \(favorites.count) items")
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginResponse
                print(decodedTeams.contactEmail ??  "" )
                
                
            }
        } else {
            print("Favorites is nil")
        }
    }

    //  ================================ ScrollView Method ===================================

    func scrollViewDidEndDecelerating(_ imageScrollView: UIScrollView)
    {
        let pageNumber = imageScrollView.contentOffset.x / imageScrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

    
    @IBAction func onMoreTapped(){
        
        print("Toggle Side Menu")
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu") , object: nil)
    }
    
    //MARK:- IBActions Btns
    //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToSubIdentifier"){
            let destination = segue.destination as! SubCategoryView
            destination.type = self.type
        }else if(segue.identifier == "aboutUsIdentifier") {
            let destination = segue.destination as! AboutUsViewController
            destination.pageResposns = self.pageResposns
            
            
        }else if(segue.identifier == "termsIdentifier") {
            let destination = segue.destination as! TermsViewController
            destination.pageResposns = self.pageResposns
            
            
        }else if (segue.identifier == "goToChangeLanguage"){
            let destination = segue.destination as! ChangeLanguageViewController
          //  destination.pageResposns = self.pageResposns
        }else if (segue.identifier == "goToCountries"){
            let destination = segue.destination as! ChooseCountriesViewController
            destination.title = NSLocalizedString("chooseCountry", comment: "")
        }
    }
    func createAlert(title : String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    func createAlertLogout(title : String){
        let alert = UIAlertController(title: title, message: NSLocalizedString("wantToLogout", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yesString", comment: "") , style: UIAlertActionStyle.default, handler: { (action) in
            self.logOutFromApp()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("noString", comment: ""), style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
   
    
    @IBAction func adsFromTabsAction(_ sender: Any) {
        performSegue(withIdentifier: "adsIdentifier", sender: nil)
    }
    
    
    func getAppPages(){
        
        hud.show(in: self.view)

        GetPagesAp.GetPagesAp { (pageResp, error) in
              self.hud.dismiss()
            if(error == ""){
                
                self.pageResposns = pageResp
                
            }
        }
        
    }
    
    func logOutFromApp(){
        let idForUserDefaults = "logResp"
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: idForUserDefaults)
        userDefaults.synchronize()
        print(userDefaults.data(forKey: "logResp")?.count ?? 0)
        self.createAlert(title: NSLocalizedString("loggedOutSuccess", comment: ""))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArrLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCatCell", for: indexPath) as! MainCategoryTableViewCell
        cell.listImg.image = listArr[indexPath.row]
        cell.listLabel.text = listArrLabel[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.row == 0){
            self.type = Constants.mainCategories.dep3
             performSegue(withIdentifier: "goToSubIdentifier", sender: self)
        }else  if(indexPath.row == 1){
            self.type = Constants.mainCategories.dep2
            performSegue(withIdentifier: "goToSubIdentifier", sender: self)
        }else  if(indexPath.row == 2){
            self.type = Constants.mainCategories.dep1
            performSegue(withIdentifier: "goToSubIdentifier", sender: self)
        }else  if(indexPath.row == 3){
            self.type = Constants.mainCategories.dep4
            performSegue(withIdentifier: "goToSubIdentifier", sender: self)
        }else  if(indexPath.row == 4){
            self.type = Constants.mainCategories.dep5
            performSegue(withIdentifier: "goToSubIdentifier", sender: self)
        }
    }
}
