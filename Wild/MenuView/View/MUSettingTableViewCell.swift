//
//  MUSettingTableViewCell.swift
//  Wild
//
//  Created by Adaman on 4/2/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSettingTableViewCell: UITableViewCell {

    private var versionLabel:UILabel?
    
    var isLast:Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.customGrayColor()
    
        self.customBackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customBackView() {
        
        let imgView = UIImageView()
        
        let image = UIImage(named: "Me_back")
        
        imgView.image = image
        
        let hx = UIScreen.mainScreen().bounds.width - 12.0 - (image?.size.width)!
        
        imgView.frame = CGRectMake(hx, 11, 14, 22)
        
        self.addSubview(imgView)
        
        self.versionLabel = UILabel()
        
        self.versionLabel?.text = "1.0"
        
        self.versionLabel?.font = UIFont.systemFontOfSize(12.0)
        
        self.versionLabel?.textAlignment = NSTextAlignment.Center
        
        self.versionLabel?.frame = CGRectMake(hx - 40, 11, 40, 22)
        
        self.versionLabel?.hidden = true
        
        self.addSubview(self.versionLabel!)
    }
    
    override func layoutSubviews() {
        
        self.imageView?.frame = CGRectMake(12.0, 6, 30, 30)
        
        self.textLabel?.frame = CGRectMake(54.0, 6,120, 30)
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if self.isLast {
            
            self.versionLabel?.hidden = false
        }
    }

}
