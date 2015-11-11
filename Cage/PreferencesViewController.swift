//
//  PreferencesViewController.swift
//  Cage
//
//  Created by horimislime on 2015/11/07.
//  Copyright © 2015年 horimislime. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var tokenField: NSTextField!
    @IBOutlet weak var teamNameField: NSTextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tokenField.delegate = self
        
        let config = Configuration.load()
        
        if let token = config.token {
            self.tokenField.stringValue = token
        }
        
        if let teamName = config.teamName {
            self.teamNameField.stringValue = teamName
        }
    }
    
    override func viewDidDisappear() {
        Configuration(
            token: self.tokenField.stringValue,
            teamName: self.teamNameField.stringValue)
            .save()
    }
}
