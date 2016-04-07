//
//  MULabelTextByClickDelegate.swift
//  Wild
//
//  Created by Adaman on 3/4/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation

import UIKit


@objc protocol MULabelTextByClickDelegate : NSObjectProtocol {
    
    func labelTextByClick(rowHeight : CGFloat, indexPath : NSIndexPath)
}