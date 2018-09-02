import ObjectMapper

class LoginAPiService: NSObject{
    class func login(userName: String, password: String,completionHandler:@escaping(LoginResponse?,String)->()){
        let url = Constants.webservices.baseURL + "api/Users/login?Email=\(userName)&Password=\(password)"
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
                if(responseObject?.value(forKey:"error")
                    != nil)
                {
                    completionHandler(Mapper<LoginResponse>().map(JSON:[:])!,responseObject?.value(forKey:"error") as! String);
                }
                else
                    if(error==nil)
                    {
                        let loginResponse =
                            Mapper<LoginResponse>().map(JSON:responseObject as![String : Any]) //Swift 3
                        if(loginResponse?.message == "ok"){
                        completionHandler(loginResponse!,"")
                    }else{
                        completionHandler(loginResponse!,"The user name or password is incorrect")
                }
        }//http://dawarty.alexwestschools.com/api/Users/login?Email=ahmed@gmail.com&Password=1234567
            else
            {
            completionHandler(Mapper<LoginResponse>().map(JSON:[:])!,"no_internet");
        }
    });
}
    
    
    
    
    
    class func ForgetPassword(contactEmail: String, completionHandler:@escaping(SuccessResp?,String)->()){
        let url = Constants.webservices.baseURL + "api/Users/ForgetPassword?ContactEmail=\(contactEmail)"
        
        NetWorkConnection.fetchDataDic(url: url, httpmethod: .get, parameters: [:], completionHandler: {responseObject, error in
           
                if(error==nil)
                {
                    let loginResponse =
                        Mapper<SuccessResp>().map(JSON:responseObject as![String : Any]) //Swift 3
                    if(loginResponse?.message == "ok"){
                        completionHandler(loginResponse!,"")
                    }else{
                        completionHandler(loginResponse!,"no_internet")
                    }
                }//http://dawarty.alexwestschools.com/api/Users/login?Email=ahmed@gmail.com&Password=1234567
                else
                {
                    completionHandler(Mapper<SuccessResp>().map(JSON:[:])!,"no_internet");
            }
        });
    }
    
    
}



