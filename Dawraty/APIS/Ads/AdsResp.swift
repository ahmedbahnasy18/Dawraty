//
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class AdsResp : NSObject, Mappable{
    
    var id : String?
    var coursName : String?
    var coursesID : Int?
    var iD : Int?
    var photo : String?
    var startDate : String?
    var status : AnyObject?
    var courseIdFavs : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return AdsResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        coursName <- map["Cours_name"]
        coursesID <- map["Courses_ID"]
        iD <- map["ID"]
        photo <- map["Photo"]
        startDate <- map["StartDate"]
        status <- map["status"]
       courseIdFavs <- map["CoursId"]
        
    }
    
  
    
}
