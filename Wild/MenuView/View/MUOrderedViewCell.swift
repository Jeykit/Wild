//
//  MUOrderedViewCell.swift
//  Wild
//
//  Created by Adaman on 3/11/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUOrderedViewCell: UITableViewCell {

    var modal:MUMeOrderedModal?
    
    private let viewContraint:UIView           = UIView()

    // private let goodsViewContaint:UIView? = UIView()

    private let goodsViewContaintTotal:UIView  = UIView()

    private let totalPriceViewContaint:UIView? = UIView()

    private let statusViewContaint:UIView?     = UIView()

    private let commentViewContaint:UIView?    = UIView()

    private let buttonViewContaint:UIView?     = UIView()

    private let headerViewContaint:UIView      = UIView()

    private let button:UIButton                = UIButton()

    private var width:CGFloat?                 = 0

    private var subWidth:CGFloat               = 0

    private var lastWidth:CGFloat?             = 0

    private var number                         = 1

    private var numberLabel:UILabel            = UILabel()

    private var leftButton:UIButton?

    private var subTotalLabel:UILabel          = UILabel()

    private var priceText                      = ""
    
    var indexPath:NSIndexPath?
    
    var delegate:MUShoppingCarViewCellDelegate?
    
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
        
        self.viewContraint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubview(self.viewContraint)
        
        self.goodsViewContaintTotal.translatesAutoresizingMaskIntoConstraints = false
        
        self.goodsViewContaintTotal.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.goodsViewContaintTotal)
        
        
        self.totalPriceViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.totalPriceViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.totalPriceViewContaint!)
        
        self.statusViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.statusViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.statusViewContaint!)
        
        self.commentViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.commentViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.commentViewContaint!)
        
        self.buttonViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonViewContaint!.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.buttonViewContaint!)
        
        
        
        
        self.headerViewContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubview(self.headerViewContaint)
        
       // self.priceText = (modal?.priceText)!
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        
        self.subWidth = 128.0
        
        self.lastWidth = CGFloat(Int(128.0*0.62))
        
        self.width = self.frame.width - self.subWidth * 3 - self.lastWidth!
        
        
        if indexPath?.section == 0 && indexPath?.row == 0 {
            
            
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
        
        //add goods Info
        var totalCount = self.modal?.orderedGoodsModals!.count
    
   // print("=========\(totalCount)=======\(self.modal?.orderedGoodsModals?.count)")
        
        if totalCount > 2 {
            
            totalCount = 2
        }
        self.addGoodsViewContaint(self.goodsViewContaintTotal, total: totalCount!, modalArray: (modal?.orderedGoodsModals)!)
        
        self.goodsViewContaintTotal.backgroundColor = UIColor.customGrayColor()
        
        // self.goodsViewContaintSubView()
        
        //add constraint to priceViewContaint
        
        
        let hPriceViewContaintVFL = "H:|-0-[goodsViewContaintTotal(==width)]-0-[priceViewContaint(==subWidth)]-0-[numberViewContaint(==subWidth)]-0-[subTotalViewContaint(==subWidth)]-0-[buttonViewContaint(==lastWidth)]-0-|"
        
        let hPriceViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(hPriceViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["width" : self.width!,"subWidth" : self.subWidth,"lastWidth" : self.lastWidth!], views: ["goodsViewContaintTotal" : goodsViewContaintTotal,"priceViewContaint" :totalPriceViewContaint!,"numberViewContaint" : statusViewContaint!,"subTotalViewContaint":commentViewContaint!,"buttonViewContaint" : buttonViewContaint!])
        
        self.viewContraint.addConstraints(hPriceViewContaintContraint)
        
        let vPriceViewContaintVFL = "V:|-0-[priceViewContaint]-0-|"
        
        let vPriceViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(vPriceViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["priceViewContaint" :totalPriceViewContaint!])
        
        self.viewContraint.addConstraints(vPriceViewContaintContraint)
        
        
        self.totalPriceViewContaintSubView(self.totalPriceViewContaint!)
        
        //self.priceViewContaint?.backgroundColor = UIColor.redColor()
        
        //add constraint to numberViewContaint
        
        let vNmberViewContaint = "V:|-0-[numberViewContaint]-0-|"
        
        let vNmberViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(vNmberViewContaint, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["numberViewContaint" :statusViewContaint!])
        
        self.viewContraint.addConstraints(vNmberViewContaintContraint)
        
        self.statusViewContaintSubView()
        
        //self.numberViewContaint?.backgroundColor = UIColor.brownColor()
        
        //add constraint to subTotalViewContaint
        let vSubTotalViewContaint = "V:|-0-[subTotalViewContaint]-0-|"
        
        let vSubTotalViewContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubTotalViewContaint, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["subTotalViewContaint" :commentViewContaint!])
        
        self.viewContraint.addConstraints(vSubTotalViewContaintConstraint)
        
        self.commentViewContaintSubView()
        
        
        let vButtonViewContaintVFL = "V:|-0-[buttonViewContaint]-0-|"
        
        let vButtonViewContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["buttonViewContaint" :buttonViewContaint!])
        
        self.viewContraint.addConstraints(vButtonViewContaintConstraint)
        
        self.buttonViewContaintSubView()
        
        
    }
    
   private func addGoodsViewContaint(sView : UIView,total : Int, modalArray:NSMutableArray){
        
        
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
                self.goodsViewContaintSubView(modal.valueView!,modal: modalArray[index] as! MUMeOrderedGoodsModal,spaceX: 12.0)
                
            }else{
                
                vGoodsViewTotaConstraintlVFL = vGoodsViewTotaConstraintlVFL + "[\(modal.keyName)]-0-"
                
                 self.goodsViewContaintSubView(modal.valueView!,modal: modalArray[index] as! MUMeOrderedGoodsModal,spaceX: 12.0)
                //self.goodsViewContaintSub(modal.valueView!)
         
            }
        }
        
        let vGoodsViewTotalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsViewTotaConstraintlVFL, options: NSLayoutFormatOptions.AlignAllLeft.union(NSLayoutFormatOptions.AlignAllRight), metrics: nil, views:vGoodsValueDict as NSDictionary as! [String : AnyObject])
        
        sView.addConstraints(vGoodsViewTotalConstraint)
        
        
        
    }
    
    //MARK headerViewContaintSubView
   private func headerViewContaintSubView() {
        
        let goodsContaint = UIView()
        
        goodsContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(goodsContaint)
        
        goodsContaint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubViewToHearderViewContraintGoodsContraint(goodsContaint, text: "Goods")
        
        //self.addSubViewToHearderViewContraint(goodsContaint, text: "Goods")
        
        
        
        let priceContraint = UIView()
        
        priceContraint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(priceContraint)
        
        priceContraint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubViewToHearderViewContraint(priceContraint, text: "Total")
        
        
        
        let numberContaint = UIView()
        
        numberContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(numberContaint)
        
        numberContaint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubViewToHearderViewContraint(numberContaint, text: "Status")
        
        
        
        let subTotalContaint = UIView()
        
        subTotalContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(subTotalContaint)
        
        subTotalContaint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubViewToHearderViewContraint(subTotalContaint, text: "Date")
        
        
        
        
        let oprationContaint = UIView()
        
        oprationContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.addSubview(oprationContaint)
        
        self.addSubViewToHearderViewContraint(oprationContaint, text: "Operation")
        
        oprationContaint.backgroundColor = UIColor.customGrayColor()
        
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
        
        button.setTitle("More", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
       // button.userInteractionEnabled = true
        
        button.setTitleColor(UIColor.customBlueColor(), forState: UIControlState.Normal)
    
        button.addTarget(self, action: #selector(MUOrderedViewCell.MoreButtonByClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.buttonViewContaint?.addSubview(button)
        
        //add constraint to button
        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.buttonViewContaint?.addConstraint(hConstraint)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.buttonViewContaint?.addConstraint(vConstraint)
    }
    
   private func commentViewContaintSubView(){
        
        //let label = UILabel()
        //label = UILabel()
        
        subTotalLabel.text = modal?.orderDate
        
        subTotalLabel.font = UIFont.systemFontOfSize(12.0)
        
        subTotalLabel.textColor = UIColor.customBlack()
        
        subTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //self.subTotalLabel = subTotalLabel
        
        
        self.commentViewContaint?.addSubview(subTotalLabel)
        
        //add constraint to label
        
        let hLabelConstraint = NSLayoutConstraint(item: subTotalLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.commentViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.commentViewContaint?.addConstraint(hLabelConstraint)
        
        let vLabelConstraint = NSLayoutConstraint(item: subTotalLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.commentViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.commentViewContaint?.addConstraint(vLabelConstraint)
    }
    
   private func statusViewContaintSubView() {
        
        
        numberLabel.text = "Completed"
        
        numberLabel.textAlignment = NSTextAlignment.Center
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.textColor = UIColor.customBlack()
        
        numberLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.statusViewContaint?.addSubview(numberLabel)
        
        let label = UILabel()
        
        label.text = "Order details"
        
        label.font = UIFont.systemFontOfSize(12.0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.statusViewContaint?.addSubview(label)
        
        //add constraint
        
        let vConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.statusViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.statusViewContaint?.addConstraint(vConstraint)
        
        let vConstraintX = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.statusViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.statusViewContaint?.addConstraint(vConstraintX)
        
        //add constraint to label
        
        let vConstraintVFL = "V:[numberLabel]-12-[label]"
        
        let vConstraintV = NSLayoutConstraint.constraintsWithVisualFormat(vConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["numberLabel" : numberLabel,"label" : label])
        
        self.statusViewContaint?.addConstraints(vConstraintV)
        
    }
    
   private func totalPriceViewContaintSubView(sView : UIView){
        
        let priceLabel = UILabel()
        
        priceLabel.text = "$" + (modal?.totalPrice)!
        
        priceLabel.font = UIFont.systemFontOfSize(12.0)
        
        priceLabel.textColor = UIColor.customColor()
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
       sView.addSubview(priceLabel)
        
        let payLabel = UILabel()
        
        payLabel.text = "(Shippment:Free)"
        
        payLabel.font = UIFont.systemFontOfSize(12.0)
        
        payLabel.translatesAutoresizingMaskIntoConstraints = false
        
       sView.addSubview(payLabel)
        
        let onlineLabel = UILabel()
        
        onlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        onlineLabel.text = "Online"
        
        onlineLabel.font = UIFont.systemFontOfSize(12.0)
        
       sView.addSubview(onlineLabel)
        //add constraint to payLabel
        let hPayLabelConstraint = NSLayoutConstraint(item: payLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem:sView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        sView.addConstraint(hPayLabelConstraint)
        
        let vPayLabelConstraint = NSLayoutConstraint(item: payLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: sView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        
       sView.addConstraint(vPayLabelConstraint)

//      sView.addConstraint(vOnlinePayLabelConstraint)
        
        let vLabelContrsintVFL = "V:[priceLabel]-12-[payLabel]-12-[onlineLabel]"
        
        let vLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLabelContrsintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["priceLabel" : priceLabel,"payLabel" : payLabel,"onlineLabel" : onlineLabel])
        
        sView.addConstraints(vLabelConstraint)


    }
    
      
   private func goodsViewContaintSubView(sView : UIView,modal:MUMeOrderedGoodsModal,spaceX:CGFloat){
        
        let goodsImageView = UIImageView()
        
        let image = UIImage.getImageFromStr(modal.imageName!)
        
        goodsImageView.image = UIImage.resizeImage(image: image, size: CGSizeMake(60, 80))
        
        goodsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        sView.addSubview(goodsImageView)
        
        let titleLabel = UILabel()
        
        titleLabel.text = modal.title
        
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        
        sView.addSubview(titleLabel)
        
        let sizeLabel = UILabel()
        
        let nstr = "(" + modal.size!  + "("
        
        sizeLabel.text = "Size:" + nstr + modal.color! + ")" + ")"
        
        sizeLabel.font = UIFont.systemFontOfSize(12.0)
        
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        sView.addSubview(sizeLabel)
    
        let priceLabel = UILabel()
    
        priceLabel.text = "Price:$" + modal.price!
    
        priceLabel.textColor = UIColor.lightGrayColor()
    
        priceLabel.font = UIFont.systemFontOfSize(12.0)
    
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    
        sView.addSubview(priceLabel)

    
        //add constraint to goodsImageView
        
        let hGoodsImageViewConstraint = NSLayoutConstraint(item: goodsImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        sView.addConstraint(hGoodsImageViewConstraint)
        
        let vGoodsImageViewVFL = "V:|-0-[goodsImageView]-spaceX-|"
        
        let vGoodsImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsImageViewVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["spaceX" : spaceX], views: ["goodsImageView" :goodsImageView])
        
        sView.addConstraints(vGoodsImageViewConstraint)
        
        //add constraint to titleLabel
        let hTitleLabelVFL = "H:|-12-[goodsImageView]-12-[titleLabel]"
        
        let hTitleLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTitleLabelVFL, options: .AlignAllTop, metrics: nil, views: ["goodsImageView" : goodsImageView,"titleLabel" : titleLabel])
        
        sView.addConstraints(hTitleLabelConstraint)
        
        
        
        //add constraint to sizeLabel
        let vSizeLabelVFL = "V:[titleLabel]-12-[sizeLabel]-12-[priceLabel]"
        
    let vSizeLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSizeLabelVFL, options: .AlignAllLeft, metrics: nil, views: ["titleLabel" : titleLabel,"sizeLabel" : sizeLabel,"priceLabel" : priceLabel])
    
        sView.addConstraints(vSizeLabelConstraint)
        
    }
    
    func MoreButtonByClick(button : UIButton){
        
        
        //let num = (self.modal?.orderStatus)!
     
        //if num == 1 && self.modal?.orderedGoodsModals!.count > 2 {
            
             delegate?.moreButtonByClicked!((self.modal?.orderedGoodsModals)!)
        //}

       
    }
    
    func buttonByClicked(button:UIButton) {
        
        //self.subTotalLabel!.text = ""
        
        if !Bool(button.tag % 1000) {
            
            if Bool(self.number) {
                
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
        }
        
        //dispatch_async(dispatch_get_main_queue()) { () -> Void in
        
        //self.subTotalLabel.text = ""
        
       // let strToNum = ((self.priceText) as NSString).floatValue
        
        // self.subTotalLabel.text = "$" + "\(Float(self.number) * strToNum)"
        
        //self.modal?.priceText = "\(Float(self.number) * strToNum)"
        
        //self.subTotalViewContaintSubView()
        
        // }
        
        
        //print("========================================\(self.subTotalLabel.text)")
        
    }

}
