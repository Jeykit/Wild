//
//  MUDetailHeaderFooterView.swift
//  Wild
//
//  Created by Adaman on 4/1/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUDetailHeaderFooterView: UITableViewHeaderFooterView {

    var title:String?
    
    var iconImage:UIImage?
    
    var section:Int?
    
    private var titleLabel = UILabel()
    
    private var imageView = UIImageView()
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        //imageView.image = self.iconImage
        
        imageView.frame = CGRectMake(12.0, 4, 22.0, 22.0)
        
        self.addSubview(imageView)
        
        self.titleLabel.font = UIFont.systemFontOfSize(16.0)
        
        titleLabel.textColor = UIColor.customBlack()
        
        titleLabel.frame = CGRectMake(46.0, 4, 120.0, 22.0)
        
        self.addSubview(titleLabel)
        
         self.contentView.backgroundColor = UIColor.customGrayColor()

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.imageView.image = self.iconImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        self.titleLabel.text = self.title
        
        imageView.frame = CGRectMake(12.0, 4, self.iconImage!.size.width, self.iconImage!.size.height)
        
        if section == 2 {
            
             imageView.frame = CGRectMake(12.0, 8, self.iconImage!.size.width, 14)
        }
    }
    
    override func prepareForReuse() {
       
        imageView.frame = CGRectMake(12.0, 4, 22.0, 22.0)
        
    }

}
