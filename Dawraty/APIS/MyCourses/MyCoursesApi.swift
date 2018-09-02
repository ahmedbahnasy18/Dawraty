//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class MyCoursesApi: NSObject{
    class func MyCoursesApi(userId : Int, completionHandler:@escaping([MyCoursesResp]?,String)->()){
        let url = Constants.webservices.baseURL + "api/RegistrationCours/GetRegistrationCours?UserID=\(userId)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<MyCoursesResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<MyCoursesResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}






