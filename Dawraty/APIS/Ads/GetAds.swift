//
//  SubCategoryApi.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import ObjectMapper

class GetAds: NSObject{   //api/Sectionscats/GetSectionscat?CategoryID=1
    
    class func GetAds(concaturl : String, userID : Int, completionHandler:@escaping([AdsResp]?,String)->()){
        var url = ""
        if(concaturl == Constants.webservices.concatFavs){
             url = Constants.webservices.baseURL + concaturl + "userid=\(userID)"
        }else{
         url = Constants.webservices.baseURL + concaturl
        }
        NetWorkConnection.fetchDataArray(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
            
            if(error==nil)
            {
                let ads =
                    Mapper<AdsResp>().mapArray(JSONObject: responseObject)//Swift 3
                if(ads?.count != 0){
                    completionHandler(ads!,"")
                }else{
                    completionHandler(ads!,"No data")
                }
            }
            else
            {
                completionHandler(Mapper<AdsResp>().mapArray(JSONObject: []),"no_internet");
            }
        });
    }
}





