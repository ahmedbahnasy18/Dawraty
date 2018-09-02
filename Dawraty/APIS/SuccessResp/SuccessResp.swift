
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class SuccessResp : NSObject, Mappable{
    
    var id : String?
    var message : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return SuccessResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        message <- map["Message"]
        
    }
    
   
    
}
