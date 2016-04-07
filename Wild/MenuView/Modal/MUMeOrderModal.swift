//
//  MUMeOrderModal.swift
//  Wild
//
//  Created by Adaman on 2/21/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation

import UIKit

class MUMeOrderModal {
    
    var rowHeight:CGFloat = 0
    
    var fontWithPrice:CGFloat = 12.0
    
    var textOfPrice:String?
    
    var textOfData:String?
    
    var solidImage:UIImage?
    
    var imageOfGoods:UIImage?
    
    var textOfNumber:String?
    
    var textOfAmout:String?
    
    var textOfStatus:String?
    
    var dotImage:UIImage?
    
    var imageOfButton:UIImage?
    init() {
        
        self.textOfPrice = "Total:$556"
        
        let date = NSDate()
        
        let format = NSDateFormatter()
        
        format.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let formatDate = format.stringFromDate(date)
        
        let str = "Order date:\(formatDate)"
        
        self.textOfData = str
        
        self.solidImage = UIImage(named: "Me_divider_solid_defalut_2")
        
        self.imageOfGoods = UIImage(named: "Me_goodsImage_defalut_84")
        
        self.textOfNumber = "Order number    2015120836781"
        
        self.textOfAmout = "Order amout      $556"
        
        self.textOfStatus = "shipped"
        
        self.dotImage = UIImage(named: "Me_divider_dotted_defalut_2")
        
        self.imageOfButton = UIImage(named: "Me_Button_logistics_defalut_30")
        
        self.rowHeight = textOfHeight() + (self.dotImage?.size.height)! + (self.imageOfButton?.size.height)! + 9*12
    }
    
   private func sizeWithFont(str:String)->CGSize{
        
        let cStr = str as NSString
        
        return cStr.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(fontWithPrice)])
    }
    
    private func textOfHeight() ->CGFloat{
        
        return sizeWithFont(self.textOfPrice!).height + sizeWithFont(self.textOfNumber!).height + sizeWithFont(self.textOfAmout!).height + sizeWithFont(self.textOfStatus!).height
    }
}
