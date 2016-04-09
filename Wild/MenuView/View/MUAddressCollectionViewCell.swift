//
//  MUAddressCollectionViewCell.swift
//  Wild
//
//  Created by Adaman on 4/3/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUAddressCollectionViewCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    
    //you can not separate compoents in a view, which will cause unable interaction
    var addressView:MUAddressView?
    
    var modal:MUAddressModal?
    
    var indexPath:NSIndexPath?
    
    
    private var userLabel = UILabel()
    
    private var markerLabel = UILabel()
    
    private var phoneLabel = UILabel()
    
    private var checkImageView = UIImageView()
    
    var delegate:MUAddressDelegate?
    
    
    
    private var isCheckMacker:Bool = false
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.customGrayColor()
        
        self.customSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customSubviews() {
        
        let userImageView = UIImageView()
        
        userImageView.image = UIImage(named: "User-address-gray")
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(userImageView)
        
        
        let markerImageView = UIImageView()
        
        markerImageView.image = UIImage(named: "Marker-address")
        
        markerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(markerImageView)
        
        
        let phoneImageView = UIImageView()
        
        phoneImageView.image = UIImage(named: "iPhone-4-gray")
        
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(phoneImageView)
        
        
        userLabel.text = modal?.receiver
        
        userLabel.textAlignment = NSTextAlignment.Left
        
        userLabel.font = UIFont.systemFontOfSize(12.0)
        
        userLabel.textColor = UIColor.customBlack()
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(userLabel)
        
        
        
        markerLabel.text = modal?.address
        
        markerLabel.textAlignment = NSTextAlignment.Left
        
        markerLabel.font = UIFont.systemFontOfSize(12.0)
        
        markerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        markerLabel.textColor = UIColor.customBlack()
        
        markerLabel.frame.size = CGSizeMake(self.frame.width - 46,34.0)
        
        markerLabel.numberOfLines = 0
        
        markerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(markerLabel)
        
        var textHeight = self.boundingRectWithSize(markerLabel) - 12.0
        
        if textHeight <= 18.0 {
            
            textHeight = 12.0
        }
        
        //self.textHeight = textHeight
        
        
        
        phoneLabel.text = "fdd"
        
        phoneLabel.textAlignment = NSTextAlignment.Left
        
        phoneLabel.font = UIFont.systemFontOfSize(12.0)
        
        phoneLabel.textColor = UIColor.customBlack()
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(phoneLabel)
        
        
        
        //add constraint to userImageView
        let hUserImageViewConstraintVFL = "H:|-12-[userImageView]-12-[userLabel]"
        
        let hUserImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hUserImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["userImageView" : userImageView,"userLabel" : userLabel])
        
        self.addConstraints(hUserImageViewConstraint)
        
        
        
        let vUserImageViewConstraintVFL = "V:|-12-[userImageView]-12-[markerImageView]-textHeight-[phoneImageView]"
        
        let vUserImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vUserImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["textHeight" : textHeight], views: ["userImageView" : userImageView,"markerImageView" : markerImageView,"phoneImageView" : phoneImageView])
        
        self.addConstraints(vUserImageViewConstraint)
        
        //add constraint to markerLabel
        let hmarkerLabelConstraintVFL = "H:|-(>=12)-[markerImageView]-(>=12)-[markerLabel]-(>=12)-|"
        
        let hmarkerLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hmarkerLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["markerImageView" : markerImageView,"markerLabel" : markerLabel])
        
        self.addConstraints(hmarkerLabelConstraint)
        
        let leftAlign = NSLayoutConstraint(item: markerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: userLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        self.addConstraint(leftAlign)
        //
        //        let HtAlign = NSLayoutConstraint(item: markerLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 28.0)
        //
        //        self.addConstraint(HtAlign)
        
        //add constraint to phoneLabel
        let hphoneLabelConstraintVFL = "H:|-(>=12)-[phoneImageView]-(>=12)-[phoneLabel]-(>=12)-|"
        
        let hphoneLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hphoneLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["phoneImageView" : phoneImageView,"phoneLabel" : phoneLabel])
        
        self.addConstraints(hphoneLabelConstraint)
        
        
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        checkImageView.userInteractionEnabled = true
        
        checkImageView.contentMode = UIViewContentMode.Center
        
        checkImageView.layer.borderWidth = 2.0
        
        checkImageView.layer.cornerRadius = 11.0
        
        checkImageView.layer.masksToBounds = true
        
        checkImageView.layer.borderColor = UIColor.customColor().CGColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUAddressCollectionViewCell.hadlerCheckImageViewByTap(_:)))
        
        tap.delegate = self
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        checkImageView.addGestureRecognizer(tap)
        
        self.addSubview(checkImageView)
        
        let hCheckImageViewConstraintVFL = "H:[checkImageView(==22)]-12-|"
        
        let hCheckImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hCheckImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["checkImageView" : checkImageView])
        
        self.addConstraints(hCheckImageViewConstraint)
        
        let vCheckImageViewConstraintVFL = "V:|-12-[checkImageView(==22)]"
        
        let vCheckImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vCheckImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["checkImageView" : checkImageView])
        
        self.addConstraints(vCheckImageViewConstraint)
        
        let editButton = UIButton()
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.setTitle("Edit", forState: UIControlState.Normal)
        
        editButton.setTitleColor(UIColor.customBlack(), forState: UIControlState.Normal)
        
        editButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        editButton.layer.borderColor = UIColor.customBlack().CGColor
        
        editButton.layer.borderWidth = 1.0
        
        editButton.backgroundColor = UIColor.clearColor()
        
        editButton.addTarget(self, action: #selector(MUAddressView.hadlerEditByClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(editButton)
        
        let hEditButtonConstraintVFL = "H:[phoneImageView]-(>=44)-[editButton(==30)]-12-|"
        
        let hEditButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hEditButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["phoneImageView" : phoneImageView,"editButton" : editButton])
        
        self.addConstraints(hEditButtonConstraint)
        
        
    }
    
    private func boundingRectWithSize(label : UILabel) -> CGFloat{
        
        
        //let reSize = rstr.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12.0)])
        
        let labelHeight = label.sizeThatFits(CGSizeMake(self.frame.width - 46.0, CGFloat(MAXFLOAT))).height
        
        return labelHeight
        
    }
    
    override func layoutSubviews() {
        
        self.userLabel.text = modal?.receiver
        
        self.markerLabel.text = modal?.address
        
        let textString = (modal?.phoneNumber)! as NSString
        
        let headString = textString.substringToIndex(4)
        
        let footerString = textString.substringWithRange(NSMakeRange(textString.length - 3, 3))
        
        phoneLabel.text = headString + "****" + footerString
        
        if modal?.defalut == 1 {
            
            self.checkImageView.image = UIImage(named: "checkmark")
            
            self.isCheckMacker = true
            
        }
        
    }
    
    func hadlerCheckImageViewByTap(tap : UITapGestureRecognizer) {
        
        if tap.numberOfTouches() == 1 {
            
            let imageView = tap.view as! UIImageView
            
            if !self.isCheckMacker {
                
                imageView.image = UIImage(named: "checkmark")
                
                self.isCheckMacker = true
                
                delegate?.checkedImageViewByTap!(self.indexPath!)
            }else{
                
                imageView.image = nil
                
                self.isCheckMacker = false
                
            }
        }
        
    }
    
    func hadlerEditByClicked(button : UIButton) {
        
        delegate?.editButtonByClicked!(self.modal!, indexPath: self.indexPath!)
        
        self.checkImageView.image = UIImage(named: "checkmark")
        
        self.isCheckMacker = true
    }
    
    override func prepareForReuse() {
        
        self.modal = nil
        
        self.checkImageView.image = nil
        
        self.isCheckMacker = false
    }
    
}
    

