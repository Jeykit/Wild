//
//  MUAddressDelegate.swift
//  Wild
//
//  Created by Adaman on 4/3/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

@objc protocol MUAddressDelegate: NSObjectProtocol {

    optional func editButtonByClicked(modal:MUAddressModal,indexPath:NSIndexPath)
    
    optional func checkedImageViewByTap(indexPath : NSIndexPath)
    
    optional func emptyEmail()
    
    optional func addNewDataToDatabase()
   
}
