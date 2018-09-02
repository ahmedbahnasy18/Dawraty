import ObjectMapper

class CourseDetailsApi: NSObject{
    class func CourseDetailsApi(courseId: Int,completionHandler:@escaping(CourseDetailsResp?,String)->()){
        let url = Constants.webservices.baseURL + "api/Cours/GetCours?Section_id=\(courseId)"
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
           
                if(error==nil)
                {
                    let loginResponse =
                        Mapper<CourseDetailsResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                    if(loginResponse?.sectionId != 0){
                        completionHandler(loginResponse!,"")
                    }else{
                        completionHandler(loginResponse!,"The user name or password is incorrect")
                    }
                }
                else
                {
                    completionHandler(Mapper<CourseDetailsResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}




