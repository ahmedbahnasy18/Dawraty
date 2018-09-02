//
//  SubCategoryResp.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

//
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class SubCategorySub : NSObject, Mappable{
    
    var id : String?
    var categoryNameEn : String?
    var categoryNameEr : String?
    var iD : Int?
    var photo : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return SubCategorySub()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        categoryNameEn <- map["CategoryName_En"]
        categoryNameEr <- map["CategoryName_er"]
        iD <- map["ID"]
        photo <- map["Photo"]
        
    }
    

    
}
