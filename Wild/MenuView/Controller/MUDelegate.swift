//
//  MUDelegate.swift
//  Wild
//
//  Created by Adaman on 1/25/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

@objc protocol MUDelegate: NSObjectProtocol {

    
    func getImage(img:UIImage)
    
    optional func handlerLoginButton(is_login : Bool)
    
   // func getRectFromCell(var rect:CGRect)
}
