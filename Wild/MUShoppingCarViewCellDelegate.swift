//
//  MUShoppingCarViewCellDelegate.swift
//  Wild
//
//  Created by Adaman on 3/10/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

@objc protocol MUShoppingCarViewCellDelegate: NSObjectProtocol {
    
   optional func removeCellForIndexPath(indexPath : NSIndexPath,imageName : String,flag : Int)
    
   optional func updatePayForViewData(imageName : String,number : Int ,price : Float)
    
   optional func moreButtonByClicked(modalArray : NSMutableArray)

}
