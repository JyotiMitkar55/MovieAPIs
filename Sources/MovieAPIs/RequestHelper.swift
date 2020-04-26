//
//  RequestHelper.swift
//
//  Created by Jyoti on 23/01/18.
//

import UIKit

class RequestHelper: NSObject {
    
    class func getMoviesAPIRequest(relativePath :String, dictionary: [String:Any]) -> URLRequest{
        
        let appendString = self.encodeDictionary(dictionary: dictionary)
        let urlString =  API.BaseURL.prod + "movie/" + relativePath + "?" + appendString
        
        print("API URL : \(urlString)")
        
        let requestURL:NSURL = NSURL(string: urlString)!;
        var request:URLRequest = URLRequest(url: requestURL as URL)
        request.httpMethod = "GET"
        request.timeoutInterval = TimeInterval(REQUEST_TIME_OUT)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        
        return request;
    }
    
    class func getAPIRequest(relativePath :String, dictionary: [String:Any]) -> URLRequest{
        
        let appendString = self.encodeDictionary(dictionary: dictionary)
        let urlString =  API.BaseURL.prod + relativePath + "?" + appendString
        
        print("API URL : \(urlString)")
        
        let requestURL:NSURL = NSURL(string: urlString)!;
        var request:URLRequest = URLRequest(url: requestURL as URL)
        request.httpMethod = "GET"
        request.timeoutInterval = TimeInterval(REQUEST_TIME_OUT)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        
        return request;
    }

    
    class func encodeDictionary(dictionary :[String:Any]) -> String{
        
        let parts = NSMutableArray();
        for (key, value) in dictionary {
            
            let encodedKey:String =  (key as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let encodedValue:String =  (value as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let joinedValue:String = encodedKey + "=" + encodedValue;
            parts.add(joinedValue)
        }
        let encodedString:String = parts.componentsJoined(by: "&")
        return encodedString
    }
}
