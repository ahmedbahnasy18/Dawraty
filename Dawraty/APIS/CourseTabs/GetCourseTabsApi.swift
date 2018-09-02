//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class GetCourseTabsApi: NSObject{   //api/Sectionscats/GetSectionscat?CategoryID=1
    class func GetCourseTabsApi(CategoryID : Int,completionHandler:@escaping([CourseTabsResp]?,String)->()){
        let url = Constants.webservices.baseURL + "api/Sectionscats/GetSectionscat?CategoryID=\(CategoryID)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<CourseTabsResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<CourseTabsResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}




