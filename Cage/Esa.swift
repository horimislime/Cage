//
//  Esa.swift
//  Cage
//
//  Created by horimislime on 2015/11/07.
//  Copyright © 2015年 horimislime. All rights reserved.
//

import Alamofire
import ObjectMapper

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api.esa.io/v1"
    
    case Posts(Configuration, Entry)
    
    var method: Alamofire.Method {
        switch self {
        case .Posts:
            return .POST
        }
    }
    
    var URLString: String {
        
        let path: String = {
            switch self {
            case .Posts(let config, _):
                return "/teams/\(config.teamName!)/posts"
            }
        }()
        
        return Router.baseURLString + path
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let request = NSMutableURLRequest(URL: NSURL(string: self.URLString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = method.rawValue
        
        switch self {
            
        case .Posts(let config, let param):
            
            if let token = config.token {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            let payload = NSString(string: Mapper().toJSONString(param, prettyPrint: false)!)
            request.HTTPBody = payload.dataUsingEncoding(NSUTF8StringEncoding)
            return request
        }
    }
}