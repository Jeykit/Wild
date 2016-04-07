//
//  MUImageView.swift
//  Wild
//
//  Created by Adaman on 3/8/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUImageView: UIImageView,UIGestureRecognizerDelegate {

    private var imageWindth:CGFloat?
    
    private var imageHeight:CGFloat?
    
    private var spaceX:CGFloat?
    
    private var tempImageView:UIImageView?
    
    private var button:UIButton?
    
    var imageArray:NSMutableArray?
    
    var delegate:MUImageViewDelegate?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.imageWindth = UIScreen.mainScreen().bounds.size.width/5
        
        self.imageHeight = self.imageWindth! * 4 / 3
        
        self.spaceX =  (UIScreen.mainScreen().bounds.size.width - 3 * self.imageWindth! - 12*2)/2
        
        self.userInteractionEnabled = true
        
        self.customView()
    }
        required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        
        
    }
    
    func customView() {
        
        let imageV_00 = UIImageView()
        
        self.tempImageView = imageV_00
        
        imageV_00.tag = 1000
        
        //imageV_00.layer.borderColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0).CGColor
        
        imageV_00.layer.borderWidth = 2.0
        
        self.setImageView(imageV_00, flag: 0)
        
        let imageV_01 = UIImageView()
        
        imageV_01.tag = 1001
        
        self.setImageView(imageV_01, flag: 1)
        
        let imageV_02 = UIImageView()
        
        imageV_02.tag = 1002
        
        self.setImageView(imageV_02, flag: 2)
        
        let hImageConstraint = NSLayoutConstraint(item: imageV_00, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: self.spaceX!)
        
        self.addConstraint(hImageConstraint)
        
        let vImageConstraint = NSLayoutConstraint(item: imageV_00, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -(self.spaceX!)/2)
        
        self.addConstraint(vImageConstraint)
        
        let hImageViewConstraintVFL = "H:[imageV_00]-12-[imageV_01]-12-[imageV_02]-spaceX-|"
        
        let hImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["spaceX" : spaceX!], views: ["imageV_00" : imageV_00,"imageV_01" : imageV_01,"imageV_02" : imageV_02])
        self.addConstraints(hImageViewConstraint)
        
        
        self.button = UIButton()
        
        self.button?.translatesAutoresizingMaskIntoConstraints = false
        
        self.button?.setImage(UIImage(named: "arrow"), forState: UIControlState.Normal)
        
        self.button?.addTarget(self, action: #selector(MUImageView.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(self.button!)
        
        let vButtonConstraint = NSLayoutConstraint(item: self.button!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vButtonConstraint)
        
        let hButtonConstraint = NSLayoutConstraint(item: self.button!, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.addConstraint(hButtonConstraint)
    }

    func setImageView(imageV : UIImageView,flag : Int){
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        
        imageV.layer.borderColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0).CGColor
        
        imageV.userInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUImageView.imageByTap(_:)))
        
        tap.delegate = self
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        imageV.addGestureRecognizer(tap)
        
        self.addSubview(imageV)
        
        print("=============================\(self.imageArray![flag])")
        
        let image = UIImage.getImageFromStr(self.imageArray![flag] as! String)
        
        imageV.image = UIImage.resizeImage(image: image, size: CGSizeMake(self.imageWindth!, self.imageHeight!))
    }
    
    func imageByTap(tap : UITapGestureRecognizer){
        
        let imageV = tap.view as! UIImageView
        
        if tap.numberOfTouches() == 1 {
            
            if imageV != self.tempImageView {
            
               imageV.layer.borderWidth = 2.0
                
                self.tempImageView?.layer.borderWidth = 0
            
               self.tempImageView = imageV
                
            }
        }
        let flag = imageV.tag % 1000
        
        delegate?.imageViewByTap(flag)
    }
    
    func buttonClicked(button : UIButton){
        
       delegate!.buttonByClicked()
    }
}
