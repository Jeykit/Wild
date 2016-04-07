//
//  MURectFromCellDelegate.swift
//  Wild
//
//  Created by Adaman on 2/23/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation

import UIKit

@objc protocol MURectFromCellDelegate:NSObjectProtocol {
    
    func getRectFromCell( rect:CGRect)
}