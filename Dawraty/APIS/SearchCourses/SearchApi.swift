//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class SearchApi: NSObject{
    class func SearchApi(courseName : String, completionHandler:@escaping([SearchResp]?,String)->()){
        let url = Constants.webservices.baseURL + "api/Cours/Search?courceName=\(courseName)"
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        NetWorkConnection.fetchDataArray(url: urlwithPercentEscapes!, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let subCat =
                    Mapper<SearchResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(subCat?.count != 0){
                    completionHandler(subCat!,"")
                }else{
                    completionHandler(subCat!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<SearchResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}







