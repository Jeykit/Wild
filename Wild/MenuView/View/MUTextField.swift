//
//  MUTextField.swift
//  Wild
//
//  Created by Adaman on 3/23/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

import QuartzCore

class MUTextField: UITextField {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        
        var iconRect = super.leftViewRectForBounds(bounds)
        
        iconRect.origin.x = iconRect.origin.x + 1
        
        return iconRect
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        
        var textRect = super.textRectForBounds(bounds)
        
        textRect.origin.x = textRect.origin.x + 12.0
        
        return textRect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        
        var textRect = super.editingRectForBounds(bounds)
        
        textRect.origin.x = textRect.origin.x + 12.0
        
        return textRect
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineCap(context, CGLineCap.Square)
        
        CGContextSetLineWidth(context, 2.0)
        
        CGContextSetRGBFillColor(context, 240.0/255.0, 14.0/255.0, 78.0/255.0, 1.0)
        
        CGContextBeginPath(context)
        
        let xPoint = CGRectGetMinX(self.leftView!.frame)
        
        let yPoint = CGRectGetMaxY(self.leftView!.frame)
        
        CGContextMoveToPoint(context, xPoint, yPoint + 12.0)
        
        let pointX = CGRectGetMaxX(self.frame)
        
        let pointY = CGRectGetMaxY(self.leftView!.frame)
        
        CGContextAddLineToPoint(context, pointX, pointY + 12.0)
        
        CGContextSetRGBStrokeColor(context, 240.0/255.0, 14.0/255.0, 78.0/255.0, 1.0)
        
        CGContextStrokePath(context)
   
        
    }
    

}
