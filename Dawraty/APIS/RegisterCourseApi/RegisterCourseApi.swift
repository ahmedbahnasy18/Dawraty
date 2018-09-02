import ObjectMapper
//Register and Add to favorites
class RegisterCourseApi: NSObject{
    class func RegisterCourseApi(userId: Int, courseId: Int,urlConcat : String,report : String, completionHandler:@escaping(SuccessResp?,String)->()){
        var url = ""
        if(urlConcat == Constants.webservices.sendReport){
            url = Constants.webservices.baseURL + urlConcat + "userid=\(userId)&Cource_id=\(courseId)&Report=\(report)"
        }else{
             url = Constants.webservices.baseURL + urlConcat + "userid=\(userId)&Cource_id=\(courseId)"
            }
      
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
          
                if(error==nil)
                {
                    let loginResponse =
                        Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                    if(loginResponse?.message == "ok"){
                        completionHandler(loginResponse!,"")
                    }else{
                        completionHandler(loginResponse!,"error")
                    }
                }//http://dawarty.alexwestschools.com/api/Users/login?Email=ahmed@gmail.com&Password=1234567
                else
                {
                    completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
}




