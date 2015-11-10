//
//  Configuration.swift
//  Cage
//
//  Created by horimislime on 2015/11/08.
//  Copyright © 2015年 horimislime. All rights reserved.
//

import Foundation

class Configuration {
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    var token: String?
    var teamName: String?
    
    convenience init(
        token: String?,
        teamName: String?)
    {
        self.init()
        self.token = token
        self.teamName = teamName
    }
    
    class func load() -> Configuration {
        return Configuration(
            token: defaults.objectForKey(DefaultsKeys.token) as? String,
            teamName: defaults.objectForKey(DefaultsKeys.teamName) as? String)
    }
    
    func save() {
        Configuration.defaults.setObject(self.token, forKey: DefaultsKeys.token)
        Configuration.defaults.setObject(self.teamName, forKey: DefaultsKeys.teamName)
    }
}

