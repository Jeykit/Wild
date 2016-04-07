//
//  MUButton.swift
//  Wild
//
//  Created by Adaman on 1/28/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        
        //self.titleLabel?.center.x = self.center.x
        //return (self.imageView?.frame)!
        let rect = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height)
        return rect
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let rect = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height)
        return rect

    }

//    override func layoutSubviews() {
//        
////        self.label.frame = (self.imageView?.frame)!
////        let Hstr = "|-0-[imgV]-0-|"
////        let Hcons = NSLayoutConstraint.constraintsWithVisualFormat(Hstr, options: .AlignAllLeft, metrics: nil, views: ["imgV" : self.imgeV])
////        self.addConstraints(Hcons)
//        
//        self.bringSubviewToFront(self.titleLabel!)
//        //self.titleRectForContentRect(self.frame)
//    }
}
