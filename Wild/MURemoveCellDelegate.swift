//
//  MURemoveCellDelegate.swift
//  Wild
//
//  Created by Adaman on 2/25/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation

import UIKit

@objc protocol MURemoveCellDelegate : NSObjectProtocol {
    
    func removeCell(index:NSIndexPath)
}