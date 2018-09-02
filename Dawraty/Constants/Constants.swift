//
//  Constants.swift
//  Dawraty
//
//  Created by SourceCode on 7/25/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import Foundation
struct Constants{
    struct mainCategories{
        static let dep1 = 4
        static let dep2 = 5
        static let dep3  = 23
        static let dep4 = 7
        static let dep5  = 6
        static var tabsCourse : [CourseTabsResp]?
        
    }
    
    struct webservices{
        
                            /**  CHANGE HERE ***/
        static let baseURL = "http://api.dawraty-kw.com/"
        static let baseUrlImg = "http://api.dawraty-kw.com/Content/img/"
        

        
        static let registerCourse  = "api/RegistrationCours/PostRegistrationCours?"
         static let addToFavs  = "api/favorites/Postfavorites?"
        static let sendReport = "api/ReportCoures/PostReportCoure?"
        static let concatAds = "api/Ads/GetAds"
        static let concatFavs = "api/favorites/Getfavorites?"
        
        
    }
    
}
