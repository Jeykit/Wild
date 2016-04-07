//
//  MUImageByTapDelegate.swift
//  Wild
//
//  Created by Adaman on 1/30/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

@objc protocol MUImageByTapDelegate: NSObjectProtocol {

    //get information of image what was tap
    func getImageInfoByTap(flag flag:Int)
}
