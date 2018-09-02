//
//  CourseTabsResp.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
//
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class CourseTabsResp : NSObject, Mappable{
    
    var id : String?
    var categoryID : AnyObject?
    var sectionsNameEn : String?
    var sectionsNameEr : String?
    var cource : [InnerCourseList]?
    var photo : AnyObject?
    var sectionId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return CourseTabsResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        categoryID <- map["CategoryID"]
        sectionsNameEn <- map["SectionsName_en"]
        sectionsNameEr <- map["SectionsName_er"]
        cource <- map["cource"]
        photo <- map["photo"]
        sectionId <- map["id"]
        
    }

    
}
