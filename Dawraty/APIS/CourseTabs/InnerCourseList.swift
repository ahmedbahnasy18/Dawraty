//
//    RootClass.swift
//
//    Create by SourceCode on 26/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class InnerCourseList : NSObject, Mappable{
    
    var id : String?
    var address : String?
    var categoryID : AnyObject?
    var coursName : String?
    var coursefees : Float?
    var details : String?
    var endDate : String?
    var isOneYear : Bool?
    var keyWord : AnyObject?
    var mapLatitude : String?
    var mapLongitude : String?
    var nameLecturer : String?
    var phone : String?
    var photo : String?
    var sectionId : AnyObject?
    var startDate : String?
    var userID : AnyObject?
    var status : String?
    var courseId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return InnerCourseList()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        address <- map["Address"]
        categoryID <- map["CategoryID"]
        coursName <- map["Cours_name"]
        coursefees <- map["Coursefees"]
        details <- map["Details"]
        endDate <- map["EndDate"]
        isOneYear <- map["IsOneYear"]
        keyWord <- map["KeyWord"]
        mapLatitude <- map["MapLatitude"]
        mapLongitude <- map["MapLongitude"]
        nameLecturer <- map["Name_lecturer"]
        phone <- map["Phone"]
        photo <- map["Photo"]
        sectionId <- map["Section_id"]
        startDate <- map["StartDate"]
        userID <- map["UserID"]
        status <- map["status"]
        courseId <- map["id"]
        
    }
    
    
}
