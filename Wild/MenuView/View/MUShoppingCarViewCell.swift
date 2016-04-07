//
//  MUShoppingCarViewCell.swift
//  Wild
//
//  Created by Adaman on 3/10/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUShoppingCarViewCell: UITableViewCell {

    var modal:MUShoppingCarModal?
    
    private let viewContraint:UIView = UIView()
    
   // private let goodsViewContaint:UIView? = UIView()
    
    private let goodsViewContaintTotal:UIView = UIView()
    
    private let priceViewContaint:UIView? = UIView()
    
    private let numberViewContaint:UIView? = UIView()
    
    private let subTotalViewContaint:UIView? = UIView()
    
    private let buttonViewContaint:UIView? = UIView()
    
    private let headerViewContaint:UIView  = UIView()
    
    private let button:MUButton = MUButton()
    
    private let rightButton = UIButton()
    
    private let priceLabel = UILabel()
    
    private var width:CGFloat? = 0
    
    private var subWidth:CGFloat = 0
    
    private var lastWidth:CGFloat? = 0
    
    private var number = 1
    
    private var numberLabel:UILabel = UILabel()
    
    private var leftButton:UIButton?
    
    private var subTotalLabel:UILabel = UILabel()
    
    private var priceText:String?
    
    private var isButtonClicked:Bool = false
    
    var indexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    var delegate:MUShoppingCarViewCellDelegate?
    
    var colorText:String?
    
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
        
        self.contentView.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.viewContraint)
        
        self.goodsViewContaintTotal.translatesAutoresizingMaskIntoConstraints = false
        
        self.goodsViewContaintTotal.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.goodsViewContaintTotal)
        
        
        self.priceViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.priceViewContaint!)
        
        
        self.numberViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.numberViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.numberViewContaint!)
        
        
        self.subTotalViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.subTotalViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.subTotalViewContaint!)
        
        
        self.buttonViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.buttonViewContaint!)
        
        
        
        
        self.headerViewContaint.translatesAutoresizingMaskIntoConstraints = false
        
        //self.headerViewContaint.backgroundColor = UIColor.lightGrayColor()
        
        self.addSubview(self.headerViewContaint)
        
        //self.layoutSubviews()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
       
        self.colorText = (modal?.color)! + "(\((modal?.size)!))"
        
        self.subWidth = 128.0
        
        self.lastWidth = CGFloat(Int(128.0*0.62))
        
        self.width = self.frame.width - self.subWidth * 3 - self.lastWidth!
        
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            
            let hMixContraintVFL = "H:|-0-[headerViewContaint]-0-|"
            
            let hMixConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hMixContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["headerViewContaint" : headerViewContaint])
            
            self.addConstraints(hMixConstraint)
            
            let vMixConstraintVFL = "V:|-0-[headerViewContaint(==44)]-0-[viewContraint]-0-|"
            
            let vMixConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vMixConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["headerViewContaint" : headerViewContaint,"viewContraint" : viewContraint])
            
            self.addConstraints(vMixConstraint)
            
            self.viewContaintSubView()
            
            self.headerViewContaintSubView()
            
        }else {
            
            let hViewContraintVFL = "H:|-0-[viewContraint]-0-|"
            
            let hViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hViewContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["viewContraint" : viewContraint])
            
            self.addConstraints(hViewConstraint)
            
            let vViewContraintVFL = "V:|-0-[viewContraint]-0-|"
            
            let vViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vViewContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["viewContraint" : viewContraint])
            
            self.addConstraints(vViewConstraint)
            
            self.viewContaintSubView()
            
        }


    }
    
   private func viewContaintSubView() {
        
        //add constraint to goodsViewContaint
        let vGoodsViewContaintVFL = "V:|-0-[goodsViewContaintTotal]-0-|"
        
        let vGoodsViewContainConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["goodsViewContaintTotal" :goodsViewContaintTotal])
        
        self.viewContraint.addConstraints(vGoodsViewContainConstraint)
        
        self.goodsViewContaintTotal.backgroundColor = UIColor.customGrayColor()
        
        self.addGoodsViewContaint(self.goodsViewContaintTotal, total: 1, modal: [])
        
        //add constraint to priceViewContaint
        
        
        let hPriceViewContaintVFL = "H:|-0-[goodsViewContaintTotal(==width)]-0-[priceViewContaint(==subWidth)]-0-[numberViewContaint(==subWidth)]-0-[subTotalViewContaint(==subWidth)]-0-[buttonViewContaint(==lastWidth)]-0-|"
        
        let hPriceViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(hPriceViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["width" : self.width!,"subWidth" : self.subWidth,"lastWidth" : self.lastWidth!], views: ["goodsViewContaintTotal" : goodsViewContaintTotal,"priceViewContaint" :priceViewContaint!,"numberViewContaint" : numberViewContaint!,"subTotalViewContaint":subTotalViewContaint!,"buttonViewContaint" : buttonViewContaint!])
        
        self.viewContraint.addConstraints(hPriceViewContaintContraint)
        
        let vPriceViewContaintVFL = "V:|-0-[priceViewContaint]-0-|"
        
        let vPriceViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(vPriceViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["priceViewContaint" :priceViewContaint!])
        
        self.viewContraint.addConstraints(vPriceViewContaintContraint)
        
        
        self.priceViewContaintSubView()
        
        self.priceViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        //add constraint to numberViewContaint
        
        let vNmberViewContaint = "V:|-0-[numberViewContaint]-0-|"
        
        let vNmberViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(vNmberViewContaint, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["numberViewContaint" :numberViewContaint!])
        
        self.viewContraint.addConstraints(vNmberViewContaintContraint)
        
        self.numberViewContaintSubView()
        
        self.numberViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        //add constraint to subTotalViewContaint
        let vSubTotalViewContaint = "V:|-0-[subTotalViewContaint]-0-|"
        
        let vSubTotalViewContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubTotalViewContaint, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["subTotalViewContaint" :subTotalViewContaint!])
        
        self.viewContraint.addConstraints(vSubTotalViewContaintConstraint)
        
        self.subTotalViewContaintSubView()
        
        
        let vButtonViewContaintVFL = "V:|-0-[buttonViewContaint]-0-|"
        
        let vButtonViewContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["buttonViewContaint" :buttonViewContaint!])
        
        self.viewContraint.addConstraints(vButtonViewContaintConstraint)
        
        self.buttonViewContaintSubView()
    
        self.buttonViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        
    }
    
   private func addGoodsViewContaint(sView : UIView,total : Int, modal:NSMutableArray){
        
        if sView.subviews.count > 0 {
            
            for element in sView.subviews {
                
                if element.isKindOfClass(UIView){
                    
                    element.removeFromSuperview()
                }
            }
        }
        
        let subGoodsViewName:NSMutableArray = NSMutableArray()
        
         let vGoodsValueDict = NSMutableDictionary()
        
        //let viewsDictionary:NSMutableArray = NSMutableArray()
        
        var vGoodsViewTotaConstraintlVFL:String = "V:|-0-"
    
        if total == 1 {
        
           vGoodsViewTotaConstraintlVFL = "V:|-12-"
         }
    
        for num in 0..<total {

            let goodsView = UIView()
            
            let goodsName = "goodsName" + "0\(num)"
           
            goodsView.translatesAutoresizingMaskIntoConstraints = false
            
            sView.addSubview(goodsView)
            
            vGoodsValueDict.setValue(goodsView, forKey: goodsName)
            
            let modal = MUGoodsImageModal()
            
            modal.keyName = goodsName
            
            modal.valueView = goodsView
            
            subGoodsViewName.addObject(modal)
            
            
        }
        
        let modal = subGoodsViewName[0] as! MUGoodsImageModal
        
        let hGoodsViewTotaConstraintlVFL = "H:|-0-[goodsViewTotal]-0-|"
        
        let hGoodsViewTotalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hGoodsViewTotaConstraintlVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["goodsViewTotal" : modal.valueView!])
        
        sView.addConstraints(hGoodsViewTotalConstraint)
        
       
      for (index,element) in subGoodsViewName.enumerate() {
                
        let modal = element as! MUGoodsImageModal
                
        if index == subGoodsViewName.count - 1{
                    
        vGoodsViewTotaConstraintlVFL = vGoodsViewTotaConstraintlVFL + "[\(modal.keyName)]-0-|"
                    
       // self.goodsViewContaintSubView(modal.valueView!,modal: self.modal!)
        self.goodsViewContaintSubView(modal.valueView!,modal: self.modal!)
            
        }else{
                    
        vGoodsViewTotaConstraintlVFL = vGoodsViewTotaConstraintlVFL + "[\(modal.keyName)]-0-"
                    
                    
       self.goodsViewContaintSubView(modal.valueView!,modal: self.modal!)
            

        }
      }
        
        let vGoodsViewTotalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsViewTotaConstraintlVFL, options: NSLayoutFormatOptions.AlignAllLeft.union(NSLayoutFormatOptions.AlignAllRight), metrics: nil, views:vGoodsValueDict as NSDictionary as! [String : AnyObject])
        
       sView.addConstraints(vGoodsViewTotalConstraint)
        
  
        
    }
   private func headerViewContaintSubView() {
        
        if self.headerViewContaint.subviews.count > 0 {
            
            for element in self.headerViewContaint.subviews {
                
                if element.isKindOfClass(UIView) {
                    
                    element.removeFromSuperview()
                }
            }
        }
        
        let goodsContaint = UIView()
        
        goodsContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(goodsContaint)
        
       // goodsContaint.backgroundColor = UIColor.redColor()
        
        self.addSubViewToHearderViewContraintGoodsContraint(goodsContaint, text: "Goods")
        
        //self.addSubViewToHearderViewContraint(goodsContaint, text: "Goods")
        
        
        
        let priceContraint = UIView()
        
        priceContraint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(priceContraint)
        
       // priceContraint.backgroundColor = UIColor.yellowColor()
        
        self.addSubViewToHearderViewContraint(priceContraint, text: "Price")
        
        
        
        let numberContaint = UIView()
        
        numberContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(numberContaint)
        
        //numberContaint.backgroundColor = UIColor.orangeColor()
        
         self.addSubViewToHearderViewContraint(numberContaint, text: "Number")
        
        
        
        let subTotalContaint = UIView()
        
        subTotalContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(subTotalContaint)
        
        //subTotalContaint.backgroundColor = UIColor.blueColor()
        
        self.addSubViewToHearderViewContraint(subTotalContaint, text: "Subtotal")
        
        
        
        
        let oprationContaint = UIView()
        
        oprationContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(oprationContaint)
        
        self.addSubViewToHearderViewContraint(oprationContaint, text: "Operation")
        
         //oprationContaint.backgroundColor = UIColor.purpleColor()
        
        let vContraintVFL = "V:|-0-[goodsContaint]-0-|"
        
        let vConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["goodsContaint" : goodsContaint])
        
        self.headerViewContaint.addConstraints(vConstraint)
        
        let hContraintVFL = "H:|-0-[goodsContaint(==width)]-0-[priceContraint(==subWidth)]-0-[numberContaint(==subWidth)]-0-[subTotalContaint(==subWidth)]-0-[oprationContaint(==lastWidth)]-0-|"
        
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hContraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["width" : self.width!,"subWidth": self.subWidth,"lastWidth" : self.lastWidth!], views: ["goodsContaint" : goodsContaint,"priceContraint" : priceContraint,"numberContaint" : numberContaint,"subTotalContaint" : subTotalContaint,"oprationContaint" : oprationContaint])
        
        self.headerViewContaint.addConstraints(hConstraint)
    }
    
   private func addSubViewToHearderViewContraintGoodsContraint(sView : UIView,text : String){
        
        
        if sView.subviews.count > 0 {
            
            for label in sView.subviews {
                
                if label.isKindOfClass(UILabel) {
                    
                    (label as! UILabel).removeFromSuperview()
                }
            }
        }

        let label = UILabel()
        
        label.text = text
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFontOfSize(12.0)
        
        sView.addSubview(label)
        
        let hLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        sView.addConstraint(hLabelConstraint)
        
        let vLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: sView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
        sView.addConstraint(vLabelConstraint)
    }
    
   private func addSubViewToHearderViewContraint(sView : UIView,text : String) {
        
        
        if sView.subviews.count > 0 {
            
            for label in sView.subviews {
                
                if label.isKindOfClass(UILabel) {
                    
                    (label as! UILabel).removeFromSuperview()
                }
            }
        }
        let label = UILabel()
        
        label.text = text
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFontOfSize(12.0)
        
        sView.addSubview(label)
        
        let hLabelConstraint = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        sView.addConstraint(hLabelConstraint)
        
        let vLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: sView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
        sView.addConstraint(vLabelConstraint)
        
    }
    
   private func buttonViewContaintSubView() {
        
        //let button = UIButton()
        
        //button.setTitle("Remove", forState: UIControlState.Normal)
        
       // button.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    
        self.button.setImage(UIImage(named: "remove")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        button.addTarget(self, action: #selector(MUShoppingCarViewCell.removeButtonByClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.buttonViewContaint?.addSubview(button)
        
        //add constraint to button
        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.buttonViewContaint?.addConstraint(hConstraint)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.buttonViewContaint?.addConstraint(vConstraint)
    }
    
   private func subTotalViewContaintSubView(){
        
       //let label = UILabel()
        //label = UILabel()
        
         subTotalLabel.text = "$" + (modal?.price)!
        
        if isButtonClicked{
            
             subTotalLabel.text = "$" + self.priceText!
        }
        subTotalLabel.font = UIFont.systemFontOfSize(12.0)
        
        subTotalLabel.textColor = UIColor.customColor()
        
        subTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //self.subTotalLabel = subTotalLabel
        
        
        self.subTotalViewContaint?.addSubview(subTotalLabel)
        
        //add constraint to label
        
        let hLabelConstraint = NSLayoutConstraint(item: subTotalLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.subTotalViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.subTotalViewContaint?.addConstraint(hLabelConstraint)
        
        let vLabelConstraint = NSLayoutConstraint(item: subTotalLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.subTotalViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.subTotalViewContaint?.addConstraint(vLabelConstraint)
    }
   private func numberViewContaintSubView() {
        
        
        self.leftButton = UIButton()
        
        leftButton!.layer.borderColor = UIColor.grayColor().CGColor
        
        leftButton!.layer.borderWidth = 2.0
        
        leftButton!.tag = 1000
        
        
        leftButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        leftButton!.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton!.setTitle("-", forState: UIControlState.Normal)
        
        leftButton!.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        leftButton!.addTarget(self, action: #selector(MUShoppingCarViewCell.buttonByClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.numberViewContaint?.addSubview(leftButton!)
        
        
        
        rightButton.tag = 1001
        
        rightButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        rightButton.layer.borderColor = UIColor.grayColor().CGColor
        
        rightButton.layer.borderWidth = 2.0
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightButton.setTitle("+", forState: UIControlState.Normal)
        
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        rightButton.addTarget(self, action: #selector(MUShoppingCarViewCell.buttonByClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.numberViewContaint?.addSubview(rightButton)
        
        
        numberLabel.text = "\(self.number)"
        
        numberLabel.layer.borderColor = UIColor.grayColor().CGColor
        
        numberLabel.layer.borderWidth = 2.0
        
        //self.numberLabel = label
        
        numberLabel.textAlignment = NSTextAlignment.Center
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.numberViewContaint?.addSubview(numberLabel)
        
        //add constraint
        
        let vConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.numberViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.numberViewContaint?.addConstraint(vConstraint)
        
        let vConstraintX = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.numberViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.numberViewContaint?.addConstraint(vConstraintX)
        
        
        
        
        let hConstraintVFL = "H:|-(>=12)-[leftButton(==22)]-(-2)-[label(==30)]-(-2)-[rightButton(==22)]-(>=12)-|"
        
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: nil, views: ["leftButton" : leftButton!,"label" : numberLabel,"rightButton" : rightButton])
        
        self.numberViewContaint?.addConstraints(hConstraint)
        
        let vConstraintH = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 22.0)
        
        self.numberViewContaint?.addConstraint(vConstraintH)


    }
    
   private func priceViewContaintSubView(){
        
        //let label = UILabel()
        
        priceLabel.text = "$" + (modal?.price)!
        
        priceLabel.font = UIFont.systemFontOfSize(12.0)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceViewContaint?.addSubview(priceLabel)
        
        //add constraint to label
        
        let hLabelConstraint = NSLayoutConstraint(item: priceLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem: self.priceViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        self.priceViewContaint?.addConstraint(hLabelConstraint)
        
        let vLabelConstraint = NSLayoutConstraint(item: priceLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: self.priceViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        self.priceViewContaint?.addConstraint(vLabelConstraint)
    }
    
   private func goodsViewContaintSub(sView : UIView) {
        
        
        if sView.subviews.count > 0 {
            
            for element in sView.subviews {
                
                if element.isKindOfClass(UIImageView) || element.isKindOfClass(UILabel) {
                    
                    element.removeFromSuperview()
                }
            }
        }

        let goodsImageView = UIImageView()
        
        //goodsImageView.image = modal?.imageGoods
        
        goodsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        sView.addSubview(goodsImageView)
        
        let titleLabel = UILabel()
        
        titleLabel.text = modal?.title
        
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        
        sView.addSubview(titleLabel)
        
        let sizeLabel = UILabel()
        
        //let nstr = "(\(modal?.color))"
        
        sizeLabel.text = "Size:"  + "(\(self.colorText!))"
        
        sizeLabel.font = UIFont.systemFontOfSize(12.0)
        
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        sView.addSubview(sizeLabel)
        
        //add constraint to goodsImageView
        
        let hGoodsImageViewConstraint = NSLayoutConstraint(item: goodsImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        
        sView.addConstraint(hGoodsImageViewConstraint)
        
        let vGoodsImageViewVFL = "V:|-12-[goodsImageView]-0-|"
        
        let vGoodsImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsImageViewVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["goodsImageView" :goodsImageView])
        
        sView.addConstraints(vGoodsImageViewConstraint)
        
        //add constraint to titleLabel
        let hTitleLabelVFL = "H:|-12-[goodsImageView]-12-[titleLabel]"
        
        let hTitleLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTitleLabelVFL, options: .AlignAllTop, metrics: nil, views: ["goodsImageView" : goodsImageView,"titleLabel" : titleLabel])
        
        sView.addConstraints(hTitleLabelConstraint)
        
        //add constraint to sizeLabel
        let vSizeLabelVFL = "V:[titleLabel]-12-[sizeLabel]"
        
        let vSizeLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSizeLabelVFL, options: .AlignAllLeft, metrics: nil, views: ["titleLabel" : titleLabel,"sizeLabel" : sizeLabel])
        
        sView.addConstraints(vSizeLabelConstraint)

    }
    
   private func goodsViewContaintSubView(sView : UIView,modal:MUShoppingCarModal){
        
        let goodsImageView = UIImageView()
        
        let image = UIImage.getImageFromStr(modal.imageName!)
        
        goodsImageView.image = UIImage.resizeImage(image: image, size: CGSizeMake(60.0, 80.0))
        
        goodsImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        goodsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        sView.addSubview(goodsImageView)
        
        let titleLabel = UILabel()
        
        titleLabel.text = modal.title
        
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        
       sView.addSubview(titleLabel)
        
        let sizeLabel = UILabel()
        
        //let nstr = "(\(modal.color))"
        
        sizeLabel.text = "Size:" + "(\(self.colorText!))"
        
        sizeLabel.font = UIFont.systemFontOfSize(12.0)
        
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
       sView.addSubview(sizeLabel)
        
        //add constraint to goodsImageView
        
        let hGoodsImageViewConstraint = NSLayoutConstraint(item: goodsImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        sView.addConstraint(hGoodsImageViewConstraint)
        
        let vGoodsImageViewVFL = "V:|-0-[goodsImageView]-12-|"
        
        let vGoodsImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsImageViewVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["goodsImageView" :goodsImageView])
        
       sView.addConstraints(vGoodsImageViewConstraint)
        
        //add constraint to titleLabel
        let hTitleLabelVFL = "H:|-12-[goodsImageView]-12-[titleLabel]"
        
        let hTitleLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTitleLabelVFL, options: .AlignAllTop, metrics: nil, views: ["goodsImageView" : goodsImageView,"titleLabel" : titleLabel])
        
       sView.addConstraints(hTitleLabelConstraint)
        
        
        
        //add constraint to sizeLabel
        let vSizeLabelVFL = "V:[titleLabel]-12-[sizeLabel]"
        
        let vSizeLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSizeLabelVFL, options: .AlignAllLeft, metrics: nil, views: ["titleLabel" : titleLabel,"sizeLabel" : sizeLabel])
        
        sView.addConstraints(vSizeLabelConstraint)
        
    }
    
    func removeButtonByClick(button : UIButton){
        
        delegate?.removeCellForIndexPath!(indexPath,imageName: (modal?.imageName)!,flag: self.tag % 100)
    }
    
    func buttonByClicked(button:UIButton) {
        
        //self.subTotalLabel!.text = ""
        
        self.isButtonClicked = true
        
        if !Bool(button.tag % 1000) {
            
            if Bool(self.number - 1) {
                
                self.number = self.number - 1
            }
            
             self.numberLabel.text = ""
            
            self.numberLabel.text = "\(self.number)"
            
            button.userInteractionEnabled = false
            
        }else{
            
            self.number = self.number + 1
            
            self.numberLabel.text = ""
            
            self.numberLabel.text = "\(self.number)"
            
            if Bool(self.number){
                
                self.leftButton!.userInteractionEnabled = true
            }
            
            //delegate?.updatePayForViewData(self.number, price: ((modal?.price)! as NSString).floatValue)
        }
        delegate?.updatePayForViewData!((modal?.imageName)!, number: self.number, price: ((modal?.price)! as NSString).floatValue)
        //dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
             //self.subTotalLabel.text = ""
            
            let strToNum = ((modal?.price)! as NSString).floatValue
        
            self.priceText = "\(Float(self.number) * strToNum)"
        
            //self.subTotalViewContaintSubView()
            
       // }
       
        
        //print("========================================\(self.subTotalLabel.text)")
        
    }

}
