//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class SubCategoryApi: NSObject{ //api/Categories/GetCategory?Department_id=1
    class func SubCategoryApi(depId : Int,completionHandler:@escaping([SubCategorySub]?,String)->()){
        let url = Constants.webservices.baseURL + "api/Categories/GetCategory?Department_id=\(depId)"
        
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
           
                if(error==nil)
                {
                    let subCat =
                        Mapper<SubCategorySub>().mapArray(JSONObject: responseObject)//Swift 3
                    if(subCat?.count != 0){
                        completionHandler(subCat!,"")
                    }else{
                        completionHandler(subCat!,"No data")
                    }
                }
                else
                {
                    completionHandler(Mapper<SubCategorySub>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}



