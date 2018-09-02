//
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginResponse : NSObject, Mappable{
    
    var id : String?
    var contactEmail : String?
    var contactName : String?
    var contactPhone : String?
    var deviceID : String?
    var iD : Int?
    var iDAuto : AnyObject?
    var iPAddress : String?
    var idJob : String?
    var idNmaber : String?
    var imageProfile : AnyObject?
    var message : String?
    var nameMinister : String?
    var gender : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["$id"]
        contactEmail <- map["ContactEmail"]
        contactName <- map["ContactName"]
        contactPhone <- map["ContactPhone"]
        deviceID <- map["DeviceID"]
        iD <- map["ID"]
        iDAuto <- map["IDAuto"]
        iPAddress <- map["IP_Address"]
        idJob <- map["Id_Job"]
        idNmaber <- map["Id_Nmaber"]
        imageProfile <- map["ImageProfile"]
        message <- map["Message"]
        nameMinister <- map["NameMinister"]
        gender <- map["gender"]
        
    }
    
  
}
