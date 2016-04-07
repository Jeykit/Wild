//
//  MUCollectionViewCellModal.swift
//  Wild
//
//  Created by Adaman on 1/30/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation
import UIKit

class MUCollectionViewCellModal: NSObject {
        
    var imageOfGoods:UIImage?
    
    var imageName:String?
    
    var code:String?
    
    var flag:Int? = 0
    
    var imageOfButtonNormol:UIImage?
    
    var imageOfButtonHightlight:UIImage?
    
    var titleOfButton:String?
    
    var fontSizeOfButton:CGFloat                  = 12.0
    
    var textOfPrice:String?
    
    var fontSizeOfPriceLabel:CGFloat              = 18.0
    
    var textOfDetaile:String?
    
    var fontSizeOfDetaileLabel : CGFloat          = 12.0
    
    var numberOfCommentimage:Float                      = 1
    
    var imageOfComment:UIImage?
    

    override init() {
        
        super.init()
        if UIDevice.currentDevice().model == "iPhone"{
            
            self.imageOfGoods            = UIImage(named: "items_00_image_iPhone_defaule_170")
            self.imageOfButtonNormol     = UIImage(named: "Button_of_buy")
            self.fontSizeOfButton        = 12.0
            
        }else if UIDevice.currentDevice().model == "iPad"{
            
            self.imageOfGoods            = UIImage(named: "items_01_detail_iPhone_image_defalut_302")
            self.imageOfButtonNormol     = UIImage(named: "button-background-normal")
            self.fontSizeOfButton        = 18.0
        }
        
        self.titleOfButton           = "Buy for it"
        self.textOfPrice             = "$22.9"
        self.textOfDetaile           = "Chanel fashion bag."
        self.imageOfComment          = UIImage(named: "comment-icon-none")
        self.numberOfCommentimage    = 5
        self.imageOfButtonHightlight = UIImage(named: "button-background-highlight")
        
        
       // let number = randomFloat()
        
        //print("================\(number)")

    }
    
  }