//
//  RegisterationApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/26/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
//http://dawarty.alexwestschools.com/api/Users/Registration?ContactName=Rehab&ContactPhone=021328765789&ContactEmail=rehab@gmail.com&IDAuto=&ProviderType=&Password=123456&image=""&Id_Job=""&Id_Nmaber=""&NameMinister=""&gender=true


import ObjectMapper

class RegisterationApi: NSObject{
    class func RegisterationApi(ContactName: String,ContactEmail : String , ContactPhone: String ,Password : String, completionHandler:@escaping(SuccessResp?,String)->()){
        let gender = "true"
        let url = Constants.webservices.baseURL + "api/Users/Registration?ContactName=\(ContactName)&ContactPhone=\(ContactPhone)&ContactEmail=\(ContactEmail)&IDAuto=&ProviderType=&Password=\(Password)&image=\("")&Id_Job=\("")&Id_Nmaber=\("")&NameMinister=\("")&gender=\(gender)"
       
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in

            if(error==nil)
            {
                let loginResponse =
                    Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                if(loginResponse?.message == "ok"){
                    completionHandler(loginResponse!,"")
                }else{
                    completionHandler(loginResponse!,"error")
                }
            }//http://dawarty.alexwestschools.com/api/Users/login?Email=ahmed@gmail.com&Password=1234567
            else
            {
                completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }


//from facebook json enter email and contact name and IDAuto as facebook return id --->> return messag ewith id -- fro m data base --> shared preference

class func LoginFacebook(ContactName: String,ContactEmail : String , IDAuto: String , completionHandler:@escaping(SuccessResp?,String)->()){
    let gender = "true"
    let url = Constants.webservices.baseURL + "api/Users/Registration?ContactName=\(ContactName)&ContactPhone=\("")&ContactEmail=\(ContactEmail)&IDAuto=\(IDAuto)&ProviderType=\("")&Password=\("")&image=\("")&Id_Job=\("")&Id_Nmaber=\("")&NameMinister=\("")&gender=\(gender)"
    
    NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
        
        if(error==nil)
        {
            let loginResponse =
                Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
            if(loginResponse?.message != ""){
                completionHandler(loginResponse!,"")
            }else{
                completionHandler(loginResponse!,"error")
            }
        }
        else
        {
            completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
        }
        
    });
}
}
