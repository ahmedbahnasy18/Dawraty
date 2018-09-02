import ObjectMapper

class LoginAPiService: NSObject{
    class func login(userName: String, password: String,completionHandler:@escaping(LoginResponse?,String)->()){
        let url = "http://dawarty.alexwestschools.com/api/Users/login?Email=\(userName)&Password=\(password)"
        
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
                        if(loginResponse?.iD != nil){
                        completionHandler(loginResponse!,"")
                    }else{
                        completionHandler(loginResponse!,"The user name orpassword is incorrect")
                }
        }//http://dawarty.alexwestschools.com/api/Users/login?Email=ahmed@gmail.com&Password=1234567
            else
            {
            completionHandler(Mapper<LoginResponse>().map(JSON:[:])!,"no_internet");
        }
    });
}
}



