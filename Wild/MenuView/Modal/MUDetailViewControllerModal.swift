//
//  MUDetailViewControllerModal.swift
//  Wild
//
//  Created by Adaman on 2/9/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation
import UIKit

class MUDetailViewControllerModal {
    
    var imageOfGoods:UIImage?
    
    var imageOfDivider:UIImage?
    
    var textOfColorPick:String?
    
    var imageOfGoodsColor_00:UIImage?
    
    var imageOfGoodsColor_01:UIImage?
    
    var imageOfGoodsColor_02:UIImage?
    
    var textOfSize:String?
    
    var textOfSize_00:String?
    
    var textOfSize_01:String?
    
    var textOfSize_02:String?
    
    var textOfSize_03:String?
    
    var fontSizeOfSaleLabel:CGFloat               = 10.0
    
    var textOfPrice:String?
    
    var imageOfRightButton:UIImage?
    
    var fontSizeOfPriceLabel:CGFloat              = 18.0
    
    var titleOfLabel:String?
    
    var fontSizeOfTitleLabel : CGFloat          = 12.0
    
    var imageOfLeftButton:UIImage?
    
    var imageOfSaleButton:UIImage?
    
    var saleOfCode:String = "EXPERT"
    
    var numberOfCommentImages:Float?
    
    
    
    
    init(){
        
        if UIDevice.currentDevice().model == "iPad" {
            
            fontSizeOfTitleLabel = 16.0
            
            fontSizeOfSaleLabel = 12.0
        }
        self.imageOfGoods = UIImage(named: "items_01_detail_iPhone_image_defalut_302")
        
        self.textOfPrice = "24.99"
        
        self.titleOfLabel = "Chanel fashion bag."
        
        self.imageOfSaleButton = UIImage(named: "sale-icon")
        
        self.imageOfDivider = UIImage(named: "divider-solid-length")
        
        self.textOfColorPick = "Color Pick"
        
        self.imageOfGoodsColor_00 = UIImage(named: "items_01_detail_iPhone_image_defalut_302")
        
        self.imageOfGoodsColor_01 = UIImage(named: "items_01_detail_iPhone_image_defalut_302")
        
        self.imageOfGoodsColor_02 = UIImage(named: "items_01_detail_iPhone_image_defalut_302")
        
        self.textOfSize_00 = "165/48A"
        
        self.textOfSize_01 = "175/48A"
        
        self.textOfSize_02 = "165/48A"
        
        self.textOfSize_03 = "175/48A"
        
        self.imageOfRightButton = UIImage(named: "button right")
        
        self.imageOfLeftButton = UIImage(named: "button-left")
        
        self.textOfSize = "Sale"
    }

    
}
