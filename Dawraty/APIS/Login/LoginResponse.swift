//
//    RootClass.swift
//
//    Create by SourceCode on 25/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginResponse : NSObject, NSCoding, Mappable{
    
    var id : String?
    var contactEmail : String?
    var contactName : String?
    var contactPhone : String?
    var deviceID : String?
    var iD : Int?
    var iDAuto : String?
    var iPAddress : String?
    var idJob : String?
    var idNmaber : String?
    var imageProfile : String?
    var message : String?
    var nameMinister : String?
    var gender : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    init(contactName : String, contactEmail :String, iD : Int ) {
        self.contactName = contactName
        self.contactEmail = contactEmail
        self.iD = iD
    }
    
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
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "$id") as? String
        contactEmail = aDecoder.decodeObject(forKey: "ContactEmail") as? String
        contactName = aDecoder.decodeObject(forKey: "ContactName") as? String
        contactPhone = aDecoder.decodeObject(forKey: "ContactPhone") as? String
        deviceID = aDecoder.decodeObject(forKey: "DeviceID") as? String
        iD = aDecoder.decodeObject(forKey: "ID") as? Int
        iDAuto = aDecoder.decodeObject(forKey: "IDAuto") as? String
        iPAddress = aDecoder.decodeObject(forKey: "IP_Address") as? String
        idJob = aDecoder.decodeObject(forKey: "Id_Job") as? String
        idNmaber = aDecoder.decodeObject(forKey: "Id_Nmaber") as? String
        imageProfile = aDecoder.decodeObject(forKey: "ImageProfile") as? String
        message = aDecoder.decodeObject(forKey: "Message") as? String
        nameMinister = aDecoder.decodeObject(forKey: "NameMinister") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? Bool
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "$id")
        }
        if contactEmail != nil{
            aCoder.encode(contactEmail, forKey: "ContactEmail")
        }
        if contactName != nil{
            aCoder.encode(contactName, forKey: "ContactName")
        }
        if contactPhone != nil{
            aCoder.encode(contactPhone, forKey: "ContactPhone")
        }
        if deviceID != nil{
            aCoder.encode(deviceID, forKey: "DeviceID")
        }
        if iD != nil{
            aCoder.encode(iD, forKey: "ID")
        }
        if iDAuto != nil{
            aCoder.encode(iDAuto, forKey: "IDAuto")
        }
        if iPAddress != nil{
            aCoder.encode(iPAddress, forKey: "IP_Address")
        }
        if idJob != nil{
            aCoder.encode(idJob, forKey: "Id_Job")
        }
        if idNmaber != nil{
            aCoder.encode(idNmaber, forKey: "Id_Nmaber")
        }
        if imageProfile != nil{
            aCoder.encode(imageProfile, forKey: "ImageProfile")
        }
        if message != nil{
            aCoder.encode(message, forKey: "Message")
        }
        if nameMinister != nil{
            aCoder.encode(nameMinister, forKey: "NameMinister")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        
    }
    
}
