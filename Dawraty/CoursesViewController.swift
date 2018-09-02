//
//  CoursesViewController.swift
//  Dawraty
//
//  Created by SourceCode on 7/24/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import CarbonKit
import JGProgressHUD

class CoursesViewController: UIViewController,CarbonTabSwipeNavigationDelegate {
    var curentIndex:Int32?=0
    var valuesOfStatus = [Int]()
    var items = [String]()
    var tabsCourse : [CourseTabsResp]?
     var tabItemIds = [Int]()
    let hud = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        valuesOfStatus =  [1,2,3,4]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items , delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        self.style(carbonTabSwipeNavigation: carbonTabSwipeNavigation)
        hud.textLabel.text =  NSLocalizedString("pleaseWait", comment: "")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        let currentTab   = self.storyboard!.instantiateViewController(withIdentifier:"CoursesFromTabsViewController") as! CoursesFromTabsViewController
        currentTab.progressStatus = tabItemIds[Int(index)]
       // print(currentTab.progressStatus ?? 0)
        return currentTab
        
    }
    
    func style(carbonTabSwipeNavigation:CarbonTabSwipeNavigation) {
        let color: UIColor = #colorLiteral(red: 0.8196078431, green: 0, blue: 0, alpha: 1)
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.setIndicatorColor(color)
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        carbonTabSwipeNavigation.setCurrentTabIndex(UInt(0),withAnimation: true)
       carbonTabSwipeNavigation.setSelectedColor(color, font: UIFont(name: "Cairo-Regular", size: 14)!)
        carbonTabSwipeNavigation.setNormalColor(#colorLiteral(red: 0.03137254902, green: 0.007843137255, blue: 0.2549019608, alpha: 1), font: UIFont(name: "Cairo-Regular", size: 14)!)
        carbonTabSwipeNavigation.setTabExtraWidth(0)
        carbonTabSwipeNavigation.setTabBarHeight(53)
        for i in 0..<self.items.count{
            let tabWidth=Double(self.view.frame.width)/3.0
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(CGFloat(tabWidth), forSegmentAt: i)
        }
    }
    
    
}

