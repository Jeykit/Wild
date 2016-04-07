//
//  MUShoppingCarTableViewCell.swift
//  Wild
//
//  Created by Adaman on 2/23/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUShoppingCarTableViewCell: UITableViewCell {

    var modal:MUShoppingCarModal? = MUShoppingCarModal()
    
    var delegate:MURemoveCellDelegate?
    
    var index:NSIndexPath?
    
    private let imageGoods = UIImageView()
    
    private let nameLable  = UILabel()
    
    private let sizeLabel  = UILabel()
    
    private let subLabel   = UILabel()
    
    private let priceLabel = UILabel()
    
    private let colorView  = UIView()
    
    private let colorLabel = UILabel()
    
    private let buttonContaint = UIView()
    
    private let button     = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layer.borderColor = UIColor.grayColor().CGColor
        
        self.layer.borderWidth = 2.0
        
        self.imageGoods.translatesAutoresizingMaskIntoConstraints = false
        
       // self.imageGoods.image = modal!.imageGoods
        
        self.addSubview(self.imageGoods)
        
        //self.nameLable.text = modal!.name
        
        self.nameLable.font = UIFont.systemFontOfSize(16.0)
        
        self.nameLable.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.nameLable)
        
        self.sizeLabel.text = "(Size " + modal!.size! + ")"
        
        self.sizeLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.sizeLabel)
        
        //self.subLabel.text = modal!.subText
        
        self.subLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.subLabel)
        
        //self.priceLabel.text = modal!.priceText
        
        self.priceLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.priceLabel)
        
        self.colorView.layer.cornerRadius = 6.0
        
        self.colorView.backgroundColor = UIColor.redColor()
        
        self.colorView.frame.size = CGSizeMake(12.0, 12.0)
        
        self.colorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.colorView)
        
        self.bringSubviewToFront(self.colorView)
        
        //self.colorLabel.text = modal!.colorText
        
        self.colorLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.colorLabel)
        
        self.buttonContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.buttonContaint)
        
        //self.buttonContaint.backgroundColor = UIColor.redColor()
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.layer.borderColor = UIColor.grayColor().CGColor
        
        self.button.layer.borderWidth = 2.0
        
        button.setImage(UIImage(named: "ShoppingCar_mulitplication_defalut_24"), forState: UIControlState.Normal)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.addTarget(self, action: #selector(MUShoppingCarTableViewCell.removeCell), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(self.button)
        
        self.customButtonContaint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        //add constraint to imageGoods
//        let hImageGoodsConstraint = NSLayoutConstraint(item: self.imageGoods, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
//        
//        self.addConstraint(hImageGoodsConstraint)
        
        let vImageGoodsConstraint = NSLayoutConstraint(item: self.imageGoods, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vImageGoodsConstraint)
        
        //add constraint to nameLabel
        let hNameLabelConstraintVFL = "H:|-12-[imageGoods]-12-[nameLable]-(>=42)-|"
        
        let hNameLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hNameLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["imageGoods" : imageGoods,"nameLable" : nameLable])
        
        self.addConstraints(hNameLabelConstraint)
        
        //add constraint to sizeLabel
        let hSizeLabelConstraint = NSLayoutConstraint(item: self.sizeLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hSizeLabelConstraint)
        
        let vSizeLabelConstraintVFL = "V:[nameLable]-4-[sizeLabel]-4-[subLabel]-4-[priceLabel]"
        
        let vSizeLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSizeLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["nameLable" : nameLable,"sizeLabel" : sizeLabel,"subLabel" : subLabel,"priceLabel" : priceLabel])
        
        self.addConstraints(vSizeLabelConstraint)
        
        //add constraint to subLabel
//        let hSubLabelConstraint = NSLayoutConstraint(item: self.subLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12.0)
//        
//        self.addConstraint(hSubLabelConstraint)
        
        //add constraint to colorView
        let hColorViewConstraintVFL = "H:[priceLabel]-12-[colorView(==12)]-12-[colorLabel]"
        
        let hColorViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hColorViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["priceLabel" : priceLabel,"colorView" : colorView,"colorLabel" : colorLabel])
        
        self.addConstraints(hColorViewConstraint)
        
        let vColorViewConstraintVFL = "V:[subLabel]-12-[colorView(==12)]"
        
        let vColorViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vColorViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["subLabel" : subLabel,"colorView" : colorView])
        
        self.addConstraints(vColorViewConstraint)
        
        //add constraint to colorLabel
        
        //add constraint to buttonConstraint
        let hButtonContaint = NSLayoutConstraint(item: self.buttonContaint, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hButtonContaint)
        
        let vButtonContaintVFL = "V:|-12-[imageGoods]-12-[buttonContaint]-12-|"
        
        let vButtonContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonContaintVFL, options: NSLayoutFormatOptions.AlignAllLeft.union(NSLayoutFormatOptions.AlignAllRight), metrics: nil, views: ["imageGoods" : imageGoods,"buttonContaint" : buttonContaint])
        
        self.addConstraints(vButtonContaintConstraint)
        
        //add constraint to button
        let hButtonConstraintVFL = "H:[button(==30)]-12-|"
        
        let hButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["button" : button])
        
        self.addConstraints(hButtonConstraint)
        
        let vButtonConstraintVFL = "V:|-[button(==30)]-12-|"
        
        let vButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["button" : button])
        self.addConstraints(vButtonConstraint)
        
    }

    func customButtonContaint(){
        
        let button_00 = UIButton()
        
        button_00.setImage(UIImage(named: "ShoppingCar_subtraction_defalut_24-copy"), forState: UIControlState.Normal)
        
        button_00.layer.borderColor = UIColor.grayColor().CGColor
        
        button_00.layer.borderWidth = 2.0
        
        button_00.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonContaint.addSubview(button_00)
        
        let button_01 = UILabel()
        
        button_01.text = "1"
        
        button_01.font = UIFont.systemFontOfSize(12.0)
        
        button_01.textAlignment = NSTextAlignment.Center
        
        button_01.layer.borderColor = UIColor.grayColor().CGColor
        
        button_01.layer.borderWidth = 2.0
        
        button_01.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonContaint.addSubview(button_01)
        
        let button_02 = UIButton()
        
        button_02.setImage(UIImage(named: "ShoppingCar_add_defalut_24"), forState: UIControlState.Normal)
        
        button_02.layer.borderColor = UIColor.grayColor().CGColor
        
        button_02.layer.borderWidth = 2.0
        
        button_02.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonContaint.addSubview(button_02)
        
        let vButtonConstrainVFL = "V:|-0-[button_00]-0-|"
        
        let vButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonConstrainVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["button_00" : button_00])
        
        self.buttonContaint.addConstraints(vButtonConstraint)
        
        let hButtonConstraintVFL = "H:|-0-[button_00(==20)]-(-2)-[button_01(==button_00)]-(-2)-[button_02(==button_00)]-0-|"
        
        let hButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: nil, views: ["button_00" : button_00,"button_01" : button_01,"button_02" : button_02])
        
        self.buttonContaint.addConstraints(hButtonConstraint)


    }
    
    func removeCell() {
        
        delegate?.removeCell(index!)
    }

}
