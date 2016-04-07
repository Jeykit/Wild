//
//  MUCleareCacheTool.swift
//  Wild
//
//  Created by Adaman on 3/28/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUCleareCacheTool: NSObject {

   class func CleareCache() {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("username")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("email")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("headerImage")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("bImage")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("address")
    
        NSUserDefaults.standardUserDefaults().removeObjectForKey("badges")
    
        NSUserDefaults.standardUserDefaults().synchronize()

    }
}
