//
//  MUImageViewDelegate.swift
//  Wild
//
//  Created by Adaman on 3/8/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

@objc protocol MUImageViewDelegate: NSObjectProtocol {
    
    func imageViewByTap(flag : Int)
    
    func buttonByClicked()
}
