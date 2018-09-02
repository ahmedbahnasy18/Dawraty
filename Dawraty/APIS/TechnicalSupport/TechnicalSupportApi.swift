import ObjectMapper
//Register and Add to favorites
class TechnicalSupportApi: NSObject{
    class func TechnicalSupportApi(question : String, userID : Int, completionHandler:@escaping(SuccessResp?,String)->()){
        let url = Constants.webservices.baseURL + "PostQuestion?Question=\(question)&UserID=\(userID)"
        
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .post, parameters: [:], completionHandler: {responseObject, error in
            
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





