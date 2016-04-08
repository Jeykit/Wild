//
//  customWindow.swift
//  Wild
//
//  Created by Adaman on 4/8/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class customWindow: UIWindow {

    class var shareInstance : UIWindow {
        
        struct Static {
            
            static let instance = customWindow()
        }
        
        return Static.instance
    }
}
