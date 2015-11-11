//
//  File.swift
//  Cage
//
//  Created by horimislime on 2015/11/08.
//  Copyright © 2015年 horimislime. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Entry : Mappable {
    
    var name: String!
    var markdown: String?
    var tags: [String]?
    var category: String?
    var wip = true
    var message: String?
    
    var url: String?
    
    convenience init(
        name: String,
        markdown: String? = nil,
        tags: [String]? = nil,
        category: String? = nil,
        wip: Bool = true,
        message: String? = nil)
    {
        self.init()
        self.name = name
        self.markdown = markdown
        self.tags = tags
        self.category = category
        self.wip = wip
        self.message = message
    }
    
    required convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
    func mapping(map: Map) {
        name   <- map["name"]
        markdown <- map["body_md"]
        wip <- map["wip"]
        url <- map["url"]
    }
    
    func save(completion: Result<Entry, NSError> -> Void) {
        
        Alamofire.request(Router.Posts(Configuration.load(), self))
            .validate()
            .responseObject { (response: Entry?, error: ErrorType?) in
            
            if let model = response {
                completion(.Success(model))
                return
            }
                
            completion(.Failure(NSError(domain: "jp.horimislime.cage.error", code: -1, userInfo: nil)))
        }
    }
}




