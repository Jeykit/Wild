//
//  MUButtonBdageTool.swift
//  Wild
//
//  Created by Adaman on 3/29/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUButtonBdageTool: NSObject {

   class func buttonBadge() -> Bool {
        
        var result = false
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("badges") != nil) {
            
            let badgeObject = NSUserDefaults.standardUserDefaults().valueForKey("badges") as! Int
            
            if badgeObject != 0 {
                
                result = true
            }
        }else{
            
            return result
        }
        
        return result
    }
    
  class func getButtonBadgeValues() -> Int {
        
        let badgeValueObject = NSUserDefaults.standardUserDefaults().valueForKey("badges") as! Int
        
        return badgeValueObject
    }
    
   class func initButtonBadgeValues(badge : Int) {
        
        NSUserDefaults.standardUserDefaults().setObject(badge, forKey: "badges")
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
   class func buttonBadgeObject() -> Bool {
        
        var  result = false
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("badges") != nil) {
            
            result = true
        }
        
        return result
    }
    
    class func setAddButtonBadgeValues() {
        
        var badgeValuesbject = NSUserDefaults.standardUserDefaults().valueForKey("badges") as! Int
        
        badgeValuesbject = badgeValuesbject + 1
        
        NSUserDefaults.standardUserDefaults().setObject(badgeValuesbject, forKey: "badges")
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func setDecrementsButtonBadgeValues(badges : Int) {
        
        var badgeValuesbject = NSUserDefaults.standardUserDefaults().valueForKey("badges") as! Int
        
        if badgeValuesbject > 0 {
            
            badgeValuesbject = badgeValuesbject - badges
            
            NSUserDefaults.standardUserDefaults().setObject(badgeValuesbject, forKey: "badges")
            
            NSUserDefaults.standardUserDefaults().synchronize()
        } 
       
    }


}
