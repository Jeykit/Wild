//
//  MUCommentDelegate.swift
//  Wild
//
//  Created by Adaman on 3/29/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

@objc protocol MUCommentDelegate: NSObjectProtocol {

    func submitButtonByclickError(alertText : String,flag : Bool,indexPath : NSIndexPath)
}
