//
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class GetPagesResp : NSObject, Mappable{
    
    var id : String?
    var pageContantEn : String?
    var pageContantEr : String?
    var pageTitalEn : String?
    var pageTitalEr : String?
    var pageId : Int?
    var photo : AnyObject?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return GetPagesResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        pageContantEn <- map["Page_Contant_en"]
        pageContantEr <- map["Page_Contant_er"]
        pageTitalEn <- map["Page_Tital_en"]
        pageTitalEr <- map["Page_Tital_er"]
        pageId <- map["Page_id"]
        photo <- map["Photo"]
        
    }
    

    
}
