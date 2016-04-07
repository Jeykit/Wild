//
//  MUAddAddressInfoView.swift
//  Wild
//
//  Created by Adaman on 4/3/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUAddAddressInfoView: UIView {

    
    private let userName = UITextField()
    
    private let zipTextFiled = UITextField()
    
    private let phoneTextFiled = UITextField()
    
    private let addressTextFiled = UITextField()
    
    private  var headerLabel = UILabel()
    
    private var isUpdate:Bool = false
    
    private var tempDate:String?
    
    var delegate:MUAddressDelegate?
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.customView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customView() {
        
        let headerView = UIView()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = UIColor.customWhite()
        
        self.addSubview(headerView)
        
        
        let contenView = UIView()
        
        contenView.translatesAutoresizingMaskIntoConstraints = false
        
        contenView.backgroundColor = UIColor.customGrayColor()
        
        self.addSubview(contenView)
        
        //self.customFootView()
        let footerView = UIView(frame : CGRectMake(0,343,self.frame.width,68.0))
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.backgroundColor = UIColor.customWhite()
        
        self.addSubview(footerView)
        
        
        let hHeaderViewConstraintVFL = "H:|-0-[headerView]-0-|"
        
        let hHeaderViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hHeaderViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["headerView" : headerView])
        
        self.addConstraints(hHeaderViewConstraint)
        
        let vHeaderViewConstraintVFL = "V:|-0-[headerView(==44.0)]-0-[contenView(==280.0)]-0-[footerView(==68)]-0-|"
        
        let vHeaderViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vHeaderViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft.union(NSLayoutFormatOptions.AlignAllRight), metrics: nil, views: ["headerView" : headerView,"contenView" : contenView,"footerView" : footerView])
        
        self.addConstraints(vHeaderViewConstraint)
        
        
        self.customSubHeaderView(headerView)
        
        self.customSubContenView(contenView)
        
        self.customFootView(footerView)
    }

    private func customSubHeaderView(sView : UIView) {
        
       
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.text = "Add delivery address"
        
        headerLabel.textColor = UIColor.customBlack()
        
        headerLabel.textAlignment = NSTextAlignment.Left
        
        headerLabel.font = UIFont.systemFontOfSize(16.0)
        
        headerLabel.contentMode = UIViewContentMode.Center
        
        sView.addSubview(headerLabel)
        
        let leftConstraint = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        sView.addConstraint(leftConstraint)
        
        let vConstraintVFL = "V:|-0-[headerLabel]-0-|"
        
        let vConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["headerLabel" : headerLabel])
        
        sView.addConstraints(vConstraint)

    }
    
    private func customSubContenView(sView : UIView) {
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        userName.placeholder = "name"
        
        userName.placeholderRectForBounds(CGRectMake(12.0,0,userName.frame.width,userName.frame.height))
        
        userName.backgroundColor = UIColor.customWhite()
        
        userName.layer.borderColor = UIColor.customBlack().CGColor
        
        userName.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        userName.layer.borderWidth = 1.0
        
        userName.textRectForBounds(CGRectMake(0, 12.0, userName.frame.width - 12, userName.frame.height))
        
        sView.addSubview(userName)
        
    
        
        zipTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        zipTextFiled.placeholder = "zip code"
        
        zipTextFiled.backgroundColor = UIColor.customWhite()
        
        zipTextFiled.layer.borderColor = UIColor.customBlack().CGColor
        
        zipTextFiled.layer.borderWidth = 1.0
        
        zipTextFiled.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        zipTextFiled.textRectForBounds(CGRectMake(0, 12.0, zipTextFiled.frame.width - 12, zipTextFiled.frame.height))
        
        sView.addSubview(zipTextFiled)
        
    
        
        phoneTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        phoneTextFiled.placeholder = "number"
        
        phoneTextFiled.backgroundColor = UIColor.customWhite()
        
        phoneTextFiled.layer.borderColor = UIColor.customBlack().CGColor
        
        phoneTextFiled.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        phoneTextFiled.layer.borderWidth = 1.0
        
        phoneTextFiled.textRectForBounds(CGRectMake(0, 12.0, phoneTextFiled.frame.width - 12, phoneTextFiled.frame.height))
        
        sView.addSubview(phoneTextFiled)
        
        
        
        addressTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        addressTextFiled.placeholder = "address"
        
        addressTextFiled.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        addressTextFiled.backgroundColor = UIColor.customWhite()
        
        addressTextFiled.layer.borderColor = UIColor.customBlack().CGColor
        
        addressTextFiled.contentMode = UIViewContentMode.Top
        
        addressTextFiled.layer.borderWidth = 1.0
        
        addressTextFiled.textRectForBounds(CGRectMake(0, 12.0, addressTextFiled.frame.width - 12, addressTextFiled.frame.height))
        
        sView.addSubview(addressTextFiled)
        
        let vConstraintVFL = "V:|-12-[userName(==30)]-12-[zipTextFiled(==30)]-12-[phoneTextFiled(==30)]-12-[addressTextFiled(==128)]"
        
        let vConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft.union(NSLayoutFormatOptions.AlignAllRight), metrics: nil, views: ["userName" : userName,"zipTextFiled" : zipTextFiled,"phoneTextFiled" : phoneTextFiled,"addressTextFiled" : addressTextFiled])
        
        sView.addConstraints(vConstraint)
        
       

        let userNameLabel = UILabel()
        
        userNameLabel.text = "* Receiver:"
        
        self.settingLabel(userNameLabel)
        
        sView.addSubview(userNameLabel)
        
        
        let windth = self.frame.width * 0.38
        
        let userNameLabelConstraintVFL = "H:|-12-[userNameLabel]-12-[userName(==windth)]"
        
        let userNameLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(userNameLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["windth" : windth], views: ["userNameLabel" : userNameLabel,"userName" : userName])
        
        sView.addConstraints(userNameLabelConstraint)
        
        
        let zipLabel = UILabel()
        
        zipLabel.text = "* Zip Code:"
        
        self.settingLabel(zipLabel)
        
        sView.addSubview(zipLabel)
        
        
        let zipLabelConstraintVFL = "H:|-12-[zipLabel]-12-[zipTextFiled]"
        
        let zipLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(zipLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["zipLabel" : zipLabel,"zipTextFiled" : zipTextFiled])
        
        sView.addConstraints(zipLabelConstraint)
        
        
        let phoneLabel = UILabel()
        
        phoneLabel.text = "* Phone:"
        
        self.settingLabel(phoneLabel)
        
        sView.addSubview(phoneLabel)
        
        
        let phoneLabelConstraintVFL = "H:|-12-[phoneLabel]-12-[phoneTextFiled]"
        
        let phoneLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(phoneLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["phoneLabel" : phoneLabel,"phoneTextFiled" : phoneTextFiled])
        
        sView.addConstraints(phoneLabelConstraint)
        
        
        let addressLabel = UILabel()
        
        addressLabel.text = "* Address:"
        
        self.settingLabel(addressLabel)
        
        sView.addSubview(addressLabel)
        
        
        let addressLabelConstraintVFL = "H:|-12-[addressLabel]-12-[addressTextFiled]"
        
        let addressLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(addressLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["addressLabel" : addressLabel,"addressTextFiled" : addressTextFiled])
        
        sView.addConstraints(addressLabelConstraint)

//        let widthConstraint = NSLayoutConstraint(item: zipTextFiled, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Width, multiplier: 0.19, constant: 0)
//        
//        sView.addConstraint(widthConstraint)
//        
        
//        
//        let divierImageView = UIImageView()
//        
//        divierImageView.image = UIImage(named: "divider-address")
//        
//        divierImageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        sView.addSubview(divierImageView)
//        
//        let dividerImageViewConstraintVFL = "H:|-12-[divierImageView]-0-|"
//        
//        let dividerImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(dividerImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["divierImageView" : divierImageView])
//        
//        sView.addConstraints(dividerImageViewConstraint)
//        
//        let vdividerImageViewConstraint = NSLayoutConstraint(item: divierImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: addressTextFiled, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
//        
//        sView.addConstraint(vdividerImageViewConstraint)

        
    }
    
    private func customFootView(sView : UIView) {
        
        let button = MUButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Submit", forState: UIControlState.Normal)
        
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        
        button.setTitleColor(UIColor.customWhite(), forState: UIControlState.Normal)
        
        button.setImage(UIImage(named: "submit-address"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: #selector(MUAddAddressInfoView.handlerSubmitButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        sView.addSubview(button)
        
        let vButtonConstraintVFL = "V:|-12-[button]-12-|"
        
        let vButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["button" : button])
        
        sView.addConstraints(vButtonConstraint)
        
        let rightButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        sView.addConstraint(rightButtonConstraint)
    }
    
    func handlerSubmitButton(button : UIButton) {
        
        if self.validUserName() {
            
            self.userName.layer.borderColor = UIColor.customGrayColor().CGColor
            
            if self.validZipCode() {
                
                self.zipTextFiled.layer.borderColor = UIColor.customGrayColor().CGColor
                
                if self.validPhoneNumber() {
                    
                    self.phoneTextFiled.layer.borderColor = UIColor.customGrayColor().CGColor
                    
                    if self.validAddress() {
                        
                        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
                            
                            if self.isUpdate {
                                
                                let tempArray = self.updateDataToDatabase()
                                
                                MUSQLiteAddressTool.updateDataToDatabase(tempArray)

                            }else{
                                
                                //add data to database
                                
                                MUSQLiteAddressTool.createDataBase()
                                
                                let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
                                
                                let tempModal = MUSQLiteAddressTool.querryDefalutAddressInDatabase(email)
                                
                                if (tempModal.date != nil) {
                                    
                                    MUSQLiteAddressTool.updateDefalutAddressToDatabase(0, date: tempModal.date!, email: tempModal.email!)
                                    
                                }
                                
                                let tempArray = self.addDatatoDatabase()
                                
                                MUSQLiteAddressTool.writeCommentDataToDatabase(tempArray)
                                
                                delegate?.addNewDataToDatabase!()
                            }
                            
                            self.clearTextField()
                            
                        }else{
                            
                            delegate?.emptyEmail!()
                        }
                        
                        
                    }else{
                        
                        self.addressTextFiled.layer.borderColor = UIColor.customColor().CGColor
                    }
                    
                }else{
                    
                    self.phoneTextFiled.layer.borderColor = UIColor.customColor().CGColor
                }
                
            }else{
                
                self.zipTextFiled.layer.borderColor = UIColor.customColor().CGColor
            }
            
        }else{
            
            self.userName.layer.borderColor = UIColor.customColor().CGColor
            
        }
        
    }
    
    private func updateDataToDatabase() -> NSMutableArray{
        
        let tempArray = NSMutableArray()
        
        //email,receiver,zipCode,phoneNumber, address,date,defalut
        tempArray.addObject(self.userName.text!)
        
        tempArray.addObject(self.zipTextFiled.text!)
        
        tempArray.addObject(self.phoneTextFiled.text!)
        
        tempArray.addObject(self.addressTextFiled.text!)
        
        tempArray.addObject(self.tempDate!)
        
        return tempArray
        
    }
    
    private func addDatatoDatabase()->NSMutableArray {
        
        //email,receiver,zipCode,phoneNumber, address,date,defalut
        let tempArray = NSMutableArray()
        
        let email =  NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
        
        tempArray.addObject(email)
        
        let receiver = self.userName.text
        
        tempArray.addObject(receiver!)
        
        
        let zipCode = self.zipTextFiled.text
        
        tempArray.addObject(zipCode!)
        
        
        let phoneNumber = self.phoneTextFiled.text
        
        tempArray.addObject(phoneNumber!)
        
        
        let address = self.addressTextFiled.text
        
        tempArray.addObject(address!)
        
        
        
        let date = NSDate()
        
        let format = NSDateFormatter()

        format.dateFormat = "yyyy/MM/dd HH/mm/ss"
        
        let formatDate    = format.stringFromDate(date)
        
        tempArray.addObject(formatDate)
        
        
        let defalut:Int = 1
        
        tempArray.addObject(defalut)
        
        
        return tempArray
        
    }
    
    private func validUserName() -> Bool{
        
        let userNameRegex = "^[A-Za-z0-9]{6,20}+$"
        
        let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
       
        return userNamePredicate.evaluateWithObject(self.userName.text)
       
    }
    
    private func validPhoneNumber() -> Bool{
        
        let phoneNumberRegex = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
        
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        return phoneNumberPredicate.evaluateWithObject(self.phoneTextFiled.text)
        
    }
    
    private func validZipCode() -> Bool{
        
        let zipCodeRegex = "^[1-9]\\d{5}$"
        
        let zipCodePredicate = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        
        return zipCodePredicate.evaluateWithObject(self.zipTextFiled.text)
        
    }
    
    private func validAddress() -> Bool{
        
        var flag = false
        
        let textString = self.addressTextFiled.text! as NSString
        
        if textString.length > 0 {
            
            flag = true
        }
        
       return flag
        
    }
    
    private func settingLabel(label : UILabel) {
        
        label.font = UIFont.systemFontOfSize(12.0)
        
        label.textColor = UIColor.customBlack()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let textString = label.text! as NSString
        
        let range = textString.rangeOfString("*")
        
        let attributeString = NSMutableAttributedString(string: label.text!)
        
        attributeString.addAttributes([NSForegroundColorAttributeName : UIColor.customColor()], range: range)
        
        label.attributedText = attributeString

    }
    
  
    func updateInfo(modal:MUAddressModal,flag:Bool) {
        
        if !flag {
            
            self.headerLabel.text = "Add delivery address"
            
            self.clearTextField()
            
            self.isUpdate = flag
        }else{
            
            self.headerLabel.text = "Edit address"
            
            self.userName.text = modal.receiver
            
            self.addressTextFiled.text = modal.address
            
            self.zipTextFiled.text = modal.zipCode
            
            self.phoneTextFiled.text = modal.phoneNumber
            
            self.isUpdate = flag
            
            self.tempDate = modal.date
        }
    }
    
    
    private func clearTextField() {
        
        self.userName.text = ""
        
        self.addressTextFiled.text = ""
        
        self.zipTextFiled.text = ""
        
        self.phoneTextFiled.text = ""
    }
    
    
}
