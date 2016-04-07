//
//  MUPageControl.swift
//  Wild
//
//  Created by Adaman on 2/13/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUPageControl: UIPageControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame : CGRect){
        
        super.init(frame: frame)
        
       //self.bounds.size = CGSizeMake(46.0, 12.0)
        
        
        //self.setValue((frame as! AnyObject) , forKey: "frame")
        
        //self.setValue((frame as! AnyObject), forKeyPath: "self.frame")
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        
        for (index,sub) in self.subviews.enumerate() {
            
            if sub.isKindOfClass(UIView) && index<3{
                
                sub.frame.size = CGSizeMake(12.0, 12.0)
                
                var f = sub.frame
                
                f.origin.y = CGRectGetMidY(self.bounds) - CGRectGetHeight(f)/2
                
                f.origin.x = 0 + CGFloat(index * 22)
                
                sub.frame = f
                
                sub.layer.cornerRadius = CGRectGetWidth(f)/2
                
                
            }else{
                
                sub.removeFromSuperview()
            }
        }
        
        self.layoutMarginsDidChange()
    }
    
}
