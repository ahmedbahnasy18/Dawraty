//
//  RegisterationApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/26/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation

import ObjectMapper

class DeleteFavorite: NSObject{
    class func DeleteFavorite(userId : Int, courseId : Int, completionHandler:@escaping(SuccessResp?,String)->()){
        let url = Constants.webservices.baseURL + "api/favorites/Deletefavorite?CoursId=\(courseId)&UserId=\(userId)"
        
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
}





