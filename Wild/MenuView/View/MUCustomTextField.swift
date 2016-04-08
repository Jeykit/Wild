//
//  MUCustomTextField.swift
//  Wild
//
//  Created by Adaman on 4/8/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUCustomTextField: UITextField {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        
        var textRect = super.textRectForBounds(bounds)
        
        textRect = CGRectMake(textRect.origin.x + 12.0, textRect.origin.y, textRect.width - 12.0, textRect.height)
        
        return textRect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        
        var textRect = super.editingRectForBounds(bounds)
        
        textRect = CGRectMake(textRect.origin.x + 12.0, textRect.origin.y, textRect.width - 12.0, textRect.height)
        
        return textRect
        
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        
        var textRect = super.placeholderRectForBounds(bounds)
        
        textRect.origin.x = textRect.origin.x
        
        textRect = CGRectMake(textRect.origin.x, textRect.origin.y, textRect.width, 44.0)
        
        return textRect
    }
}
