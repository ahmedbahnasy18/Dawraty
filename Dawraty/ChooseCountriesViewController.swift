//
//  ChooseCountriesViewController.swift
//  Dawraty
//
//  Created by SourceCode on 8/8/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class ChooseCountriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let imagArr = [#imageLiteral(resourceName: "kuwait"),#imageLiteral(resourceName: "ksa"),#imageLiteral(resourceName: "bahrain"),#imageLiteral(resourceName: "algeria"),#imageLiteral(resourceName: "tunisia")]
    let labelArr = [NSLocalizedString("kuwait", comment: ""),NSLocalizedString("ksa", comment: ""),NSLocalizedString("bahrain", comment: ""),NSLocalizedString("algeria", comment: ""),NSLocalizedString("tunisia", comment: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! ChooseCountryTableViewCell
        cell.countryImg.image = imagArr[indexPath.row]
        cell.countryName.text = labelArr[indexPath.row]
     
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
