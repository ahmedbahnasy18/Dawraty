//
//    RootClass.swift
//
//    Create by SourceCode on 26/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class MyCoursesResp : NSObject, Mappable{
    
    var id : String?
    var courceId : Int?
    var coursName : String?
    var photo : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return MyCoursesResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        courceId <- map["Cource_Id"]
        coursName <- map["Cours_name"]
        photo <- map["Photo"]
        
    }
    
 
    
}
