
//
//    RootClass.swift
//
//    Create by SourceCode on 26/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class SearchResp : NSObject, Mappable{
    
    var id : String?
    var address : String?
    var coursName : String?
    var coursefees : Float?
    var details : String?
    var endDate : String?
    var isOneYear : Bool?
    var mapLatitude : AnyObject?
    var mapLongitude : AnyObject?
    var nameLecturer : AnyObject?
    var photo : String?
    var sectionId : Int?
    var startDate : String?
    var times : AnyObject?
    var status : String?
    var courseID : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return SearchResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        address <- map["Address"]
        coursName <- map["Cours_name"]
        coursefees <- map["Coursefees"]
        details <- map["Details"]
        endDate <- map["EndDate"]
        isOneYear <- map["IsOneYear"]
        mapLatitude <- map["MapLatitude"]
        mapLongitude <- map["MapLongitude"]
        nameLecturer <- map["Name_lecturer"]
        photo <- map["Photo"]
        sectionId <- map["Section_id"]
        startDate <- map["StartDate"]
        times <- map["Times"]
        status <- map["status"]
        courseID <- map["id"]
    }

    
}
