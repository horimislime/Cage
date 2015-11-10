//
//  ViewController.swift
//  Cage
//
//  Created by horimislime on 2015/11/07.
//  Copyright © 2015年 horimislime. All rights reserved.
//

import Cocoa
//import ObjectMapper
//import Alamofire

class SidebarMenuButton: NSButton {
    
    override func awakeFromNib() {
        self.focusRingType = .None
    }
    
    override func drawRect(dirtyRect: NSRect) {
        
        let point1 = CGPoint(x: dirtyRect.width, y: 35)
        let point2 = CGPoint(x: dirtyRect.width, y: dirtyRect.height - 35)
        let point3 = CGPoint(x: dirtyRect.width - 10, y: dirtyRect.height / 2)
        
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextSetStrokeColor(context, CGColorGetComponents(NSColor.whiteColor().CGColor))
        CGContextSetFillColor(context, CGColorGetComponents(NSColor.whiteColor().CGColor))
        CGContextMoveToPoint(context, point1.x, point1.y)
        CGContextAddLineToPoint(context, point2.x, point2.y)
        CGContextAddLineToPoint(context, point3.x, point3.y)
        CGContextAddLineToPoint(context, point1.x, point1.y)
        
        CGContextFillPath(context)
        
        super.drawRect(dirtyRect)
    }
}

class ViewController: NSViewController {
    
    // MARK: Sidebar
    @IBOutlet weak var sideBar: NSView!
    @IBOutlet weak var newPostButton: SidebarMenuButton!
    @IBOutlet weak var postsButton: NSButton!
    
    
    // MARK: Editor
    @IBOutlet weak var editorBackgroundView: NSView!
    @IBOutlet weak var titleTextField: NSTextField!
    
    @IBOutlet var bodyTextView: NSTextView! {
        didSet {
            bodyTextView.font = NSFont.systemFontOfSize(22)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        
        self.editorBackgroundView.layer?.backgroundColor = NSColor.whiteColor().CGColor
        sideBar.layer?.backgroundColor = NSColor.Cage.green.CGColor
        
        self.titleTextField.placeholderString = "category1/category2/Input document title #tag1 #tag2"
        self.titleTextField.focusRingType = .None
        
        self.titleTextField.delegate = self
    }
}

extension ViewController {
    
    @IBAction func wipButtonClicked(sender: NSButton) {
        Entry(name: self.titleTextField.stringValue, markdown: self.bodyTextView.string, wip: true).save { result in
            switch result {
            case .Success(let model):
                NSWorkspace.sharedWorkspace().openURL(NSURL(string: model.url!)!)
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func shipItButtonClicked(sender: NSButton) {
        Entry(name: self.titleTextField.stringValue, markdown: self.bodyTextView.string, wip: false).save { result in
            switch result {
            case .Success(let model):
                NSWorkspace.sharedWorkspace().openURL(NSURL(string: model.url!)!)
            case .Failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: NSTextFieldDelegate {
    
    func control(control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        debugPrint(fieldEditor)
        
        return true
    }
    
    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        
        if commandSelector == "moveDown:" || commandSelector == "insertNewline:" {
            self.view.window?.makeFirstResponder(bodyTextView)
        }
        
        return true
    }
}








