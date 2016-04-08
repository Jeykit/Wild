//
//  MUMeOrderDetailTableViewCell.swift
//  Wild
//
//  Created by Adaman on 3/21/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUMeOrderDetailTableViewCell: UITableViewCell {

    var modal:MUMeOrderedGoodsModal?
    
    private let viewContraint:UIView = UIView()
    
    // private let goodsViewContaint:UIView? = UIView()
    
    private let goodsViewContaintTotal:UIView = UIView()
    
    private let priceViewContaint:UIView? = UIView()
    
    private let numberViewContaint:UIView? = UIView()
    
    private let subTotalViewContaint:UIView? = UIView()
    
    private let buttonViewContaint:UIView? = UIView()
    
    private let headerViewContaint:UIView  = UIView()
    
    private let button:UIButton = UIButton()
    
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
    
    private var commentView:UIView?
    
    private var textField:MUCustomTextField?
    
    private var score:Int = 0
    
    var preScore:Int = 0
    
    
    var commenText:String?
    
    private var commentViewsArray:NSMutableArray = NSMutableArray()
    
    
    var delegate:MUCommentDelegate?
    
    
    var indexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    //var delegate:MUShoppingCarViewCellDelegate?
    
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
        
        
        self.viewContraint.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.viewContraint)
        
        self.goodsViewContaintTotal.translatesAutoresizingMaskIntoConstraints = false
        
        self.goodsViewContaintTotal.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.goodsViewContaintTotal)
        
        
        self.priceViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.priceViewContaint!)
        
        
        self.numberViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.numberViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.numberViewContaint!)
        
        
        self.subTotalViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.subTotalViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.subTotalViewContaint!)
        
        
        self.buttonViewContaint?.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonViewContaint?.backgroundColor = UIColor.customGrayColor()
        
        self.viewContraint.addSubview(self.buttonViewContaint!)
        
        
        self.imageView?.userInteractionEnabled = false
        
        self.headerViewContaint.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerViewContaint.backgroundColor = UIColor.customGrayColor()
        
        self.addSubview(self.headerViewContaint)
        
        //self.layoutSubviews()
        
        self.commentView = UIView()
        
        self.commentView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.commentView!)
        
        self.commentView?.backgroundColor = UIColor.customGrayColor()
        
        self.commentViewSubViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        
       // print("=============\(modal?.commentStatus)")
        
        self.colorText = (modal?.size)! + "(\((modal?.color)!))"
        
        self.subWidth = 128.0
        
        self.lastWidth = CGFloat(Int(128.0*0.62))
        
        self.width = self.frame.width - self.subWidth * 3 - self.lastWidth!
        
        
        if indexPath.row == 0 && indexPath.section == 0 {
            
            
            let hMixContraintVFL = "H:|-0-[headerViewContaint]-0-|"
            
            let hMixConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hMixContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["headerViewContaint" : headerViewContaint])
            
            self.addConstraints(hMixConstraint)
            
            let vMixConstraintVFL = "V:|-0-[headerViewContaint(==44)]-0-[viewContraint]-0-[commentView(==92)]-0-|"
            
            let vMixConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vMixConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["headerViewContaint" : headerViewContaint,"viewContraint" : viewContraint,"commentView" : self.commentView!])
            
            self.addConstraints(vMixConstraint)
            
            let hCommentViewVFL = "H:|-0-[commentView]-0-|"
            
            let hCommentViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hCommentViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["commentView" : commentView!])
            
            self.addConstraints(hCommentViewConstraint)
            
            self.viewContaintSubView()
            
            self.headerViewContaintSubView()
            
            if modal?.commentStatus != 0 {
                
                textField?.placeholder = self.commenText
                
                textField?.userInteractionEnabled  = false
                
                if self.preScore > 0 {
                    
                    self.commentOfPreImage(self.commentView!, num: 0)
                }
            }

            
        }else {
            
            let hViewContraintVFL = "H:|-0-[viewContraint]-0-|"
            
            let hViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hViewContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["viewContraint" : viewContraint])
            
            self.addConstraints(hViewConstraint)
            
            let hCommentViewVFL = "H:|-0-[commentView]-0-|"
            
            let hCommentViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hCommentViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["commentView" : commentView!])
            
            self.addConstraints(hCommentViewConstraint)
            
            let vViewContraintVFL = "V:|-(-12.0)-[viewContraint]-0-[commentView(==92)]-0-|"
            
            let vViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vViewContraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["viewContraint" : viewContraint,"commentView" : self.commentView!])
            
            self.addConstraints(vViewConstraint)
            
            self.viewContaintSubView()
            
            //self.commentViewSubViews()
            
        }
        
        
    }
    
    private func commentViewSubViews(){
        
        if self.commentView?.subviews.count > 0 {
            
            for element in (self.commentView?.subviews)! {
                
                if element.isMemberOfClass(UIView) && element.isKindOfClass(UIView) && element.isKindOfClass(UIButton) {
                    
                    element.removeFromSuperview()
                }
            }
        }
        let scoreabel = UILabel()
        
        scoreabel.text = "Score:"
        
        scoreabel.font = UIFont.systemFontOfSize(16.0)
        
        scoreabel.textAlignment = NSTextAlignment.Left
        
        scoreabel.contentMode = UIViewContentMode.Center
        
        //scoreabel.aduj
        
        scoreabel.textColor = UIColor.customColor()
        
        scoreabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.commentView?.addSubview(scoreabel)
        
        let commentSubViews = UIView()
        
        commentSubViews.translatesAutoresizingMaskIntoConstraints = false
        
        commentSubViews.contentMode = UIViewContentMode.Center
        
        commentSubViews.userInteractionEnabled = true
        
        commentSubViews.multipleTouchEnabled = true
        
        commentSubViews.exclusiveTouch = true
        
        self.commentView?.addSubview(commentSubViews)
        
        textField = MUCustomTextField()
        
        textField!.translatesAutoresizingMaskIntoConstraints = false
        
        textField!.placeholder = "Enter your feelings"
        
        //reviews has been
        
       
        textField!.backgroundColor = UIColor.whiteColor()
        
        //texfield.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        //texfield.layer.borderWidth = 2.0
        
        self.commentView?.addSubview(textField!)
        
        self.commentOfImage(commentSubViews, num: 5)
        
        
        
        let submitButton = MUButton()
        
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        
        submitButton.setTitleColor(UIColor.customWhite(), forState: UIControlState.Normal)
        
        submitButton.setImage(UIImage(named: "comment_button"), forState: UIControlState.Normal)
        
        submitButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        submitButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.addTarget(self, action: #selector(MUMeOrderDetailTableViewCell.submitButtonByClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.commentView?.addSubview(submitButton)
        
        
        
        let hLabelConstrainVFL = "H:|-12-[scoreabel(==60)]-12-[commentSubViews]"
        
        let hLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hLabelConstrainVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["scoreabel" : scoreabel,"commentSubViews" : commentSubViews])
        
        self.commentView?.addConstraints(hLabelConstraint)
        
//        let vCommentImages = NSLayoutConstraint(item: commentSubViews, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.textField, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
//        
//        self.commentView?.addConstraint(vCommentImages)
        
        
        let vLabelConstraintVFL = "V:|-(-12)-[scoreabel(==46)]-0-[texfield(==44)]-12-|"
        
        let vLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["scoreabel" : scoreabel,"texfield" : textField!])
        self.commentView?.addConstraints(vLabelConstraint)
        
        let hTexfiledConstraintVFL = "H:|-12-[texfield]-12-[submitButton]-12-|"
        
        let hTextFiledConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTexfiledConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["texfield" : textField!,"submitButton" : submitButton])
        
        self.commentView?.addConstraints(hTextFiledConstraint)
        
        
        
    }
    
    func submitButtonByClick(button : UIButton) {
        
        let textString = (self.textField?.text)! as NSString
        
        let tempArray = NSMutableArray()
        
        //eamil,username,hImage,commentText,score,date
        
        //let commentModal = MUCommentModal()
        
        if (textString.length != 0) {
            
            //add email
            
            let object = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
            
           // commentModal.email = object
            tempArray.addObject(object)
            
            //add userName
            var userName = "Adaman"
            
            if (NSUserDefaults.standardUserDefaults().objectForKey("username") != nil) {
                
                let userNameObject = NSUserDefaults.standardUserDefaults().objectForKey("username") as! String
                
                userName = userNameObject
                
            }
            
            //commentModal.username = userName
            tempArray.addObject(userName)
            
            //add hImage
            
            let image = UIImage(named: "Me_userImage_defalut_78")
            
            var imageData:NSData = UIImagePNGRepresentation(image!)!
            
            if (NSUserDefaults.standardUserDefaults().objectForKey("headerImage") != nil) {
                
                imageData = NSUserDefaults.standardUserDefaults().valueForKey("headerImage") as! NSData
            }
            
            tempArray.addObject(imageData)
            
            //commentModal.hImage = hImage
            
            //add commentText
            
            //commentModal.commentText = self.textField?.text
            tempArray.addObject((self.textField?.text)!)
            
            //add score
            //commentModal.score = self.score
            tempArray.addObject(self.score)
            
              //add date
            let date = NSDate()
            
            let format = NSDateFormatter()
            
            format.dateFormat = "yyyy-MM-dd HH-mm-ss"
            
            let formatDate = format.stringFromDate(date)
            
            //commentModal.date = formatDate
            
            tempArray.addObject(formatDate)
            
            MUSQLiteCommentTool.createDataBase((modal?.saleCode)!)
            
            MUSQLiteCommentTool.writeCommentDataToDatabase((modal?.saleCode)!, commentrArray: tempArray)
            
            let commentStatus:Int = 1
            
            MUSQLiteDataMeViewControllerTool.updateDataToDatabase("commentStatus", upDateDataWithEmail: [commentStatus,(modal?.email)!])
            
            self.textField?.placeholder = textString as String
            
            self.textField?.userInteractionEnabled = false
            
            self.textField?.textColor = UIColor.grayColor()
            
            delegate?.submitButtonByclickError("Comments success!",flag: true,indexPath: indexPath)
            
            
        }else{
            
            delegate?.submitButtonByclickError("Sorry,Text can not be empty!",flag: false,indexPath: indexPath)
            
        }
        
        
    }
    
    private  func commentOfPreImage(sView : UIView,num : Int)  {
        
        for element in 0...self.preScore {
            
            let tempButton = self.commentViewsArray[element] as! UIImageView
            
            tempButton.image = UIImage(named:"comment-icon_new")
            
            tempButton.userInteractionEnabled = false
            
        }
        
        if self.preScore <= 3 {
            
            let tempFlag = self.preScore + 1
            
            for element in tempFlag...4 {
                
                
                let tempButton = self.commentViewsArray[element] as! UIImageView
                
                tempButton.userInteractionEnabled = false
            }
        }

    }


    private  func commentOfImage(sView : UIView,num : Int)  {
        
        if sView.subviews.count > 0 {
            
            for element in sView.subviews {
                
                if element.isKindOfClass(UIButton) {
                    
                    element.removeFromSuperview()
                }
            }
        }
        
        
        for index in 0..<5 {
            
            let imgX = CGFloat(2*(22*index + 44))
            
            let imageView = UIImageView()
            
            imageView.tag = 1000 + index
            
            imageView.image = UIImage(named: "comment-icon-none_new")
            
            imageView.frame = CGRectMake(imgX, 0, 22.0, 22.0)
            
            imageView.userInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(MUMeOrderDetailTableViewCell.commentImageViewByTap(_:)))
            
            tap.delegate = self
            
            tap.numberOfTapsRequired = 1
            
            tap.numberOfTouchesRequired = 1
            
            imageView.addGestureRecognizer(tap)
            
            //imageView.addTarget(self, action: #selector(MUMeOrderDetailTableViewCell.commentImageViewByTap(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.commentView!.addSubview(imageView)
            
            self.commentViewsArray.addObject(imageView)
        }
    }
    
    func commentImageViewByTap(tap : UITapGestureRecognizer) {
    
        let imageView = tap.view as! UIImageView
        
        self.score = imageView.tag % 1000
        
        //print("===============\(button.tag)")
        
        for element in 0...self.score {
            
            let tempButton = self.commentViewsArray[element] as! UIImageView
            
            tempButton.image = UIImage(named:"comment-icon_new")
            
        }
        
        if self.score <= 3 {
            
            let tempFlag = self.score + 1
            
            for element in tempFlag...4 {
                
                
                let tempButton = self.commentViewsArray[element] as! UIImageView
                
                tempButton.image = UIImage(named:"comment-icon-none_new")
            }
        }
        
    }
    private func viewContaintSubView() {
        
        //add constraint to goodsViewContaint
        let vGoodsViewContaintVFL = "V:|-0-[goodsViewContaintTotal]-0-|"
        
        let vGoodsViewContainConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vGoodsViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["goodsViewContaintTotal" :goodsViewContaintTotal])
        
        self.viewContraint.addConstraints(vGoodsViewContainConstraint)
        
        // self.goodsViewContaintTotal.backgroundColor = UIColor.redColor()
        
        self.addGoodsViewContaint(self.goodsViewContaintTotal, total: 1, modal: [])
        
        //add constraint to priceViewContaint
        
        
        let hPriceViewContaintVFL = "H:|-0-[goodsViewContaintTotal(==width)]-0-[priceViewContaint(==subWidth)]-0-[numberViewContaint(==subWidth)]-0-[subTotalViewContaint(==subWidth)]-0-[buttonViewContaint(==lastWidth)]-0-|"
        
        let hPriceViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(hPriceViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["width" : self.width!,"subWidth" : self.subWidth,"lastWidth" : self.lastWidth!], views: ["goodsViewContaintTotal" : goodsViewContaintTotal,"priceViewContaint" :priceViewContaint!,"numberViewContaint" : numberViewContaint!,"subTotalViewContaint":subTotalViewContaint!,"buttonViewContaint" : buttonViewContaint!])
        
        self.viewContraint.addConstraints(hPriceViewContaintContraint)
        
        let vPriceViewContaintVFL = "V:|-0-[priceViewContaint]-0-|"
        
        let vPriceViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(vPriceViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["priceViewContaint" :priceViewContaint!])
        
        self.viewContraint.addConstraints(vPriceViewContaintContraint)
        
        
        self.priceViewContaintSubView()
        
        //self.priceViewContaint?.backgroundColor = UIColor.redColor()
        
        //add constraint to numberViewContaint
        
        let vNmberViewContaint = "V:|-0-[numberViewContaint]-0-|"
        
        let vNmberViewContaintContraint = NSLayoutConstraint.constraintsWithVisualFormat(vNmberViewContaint, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["numberViewContaint" :numberViewContaint!])
        
        self.viewContraint.addConstraints(vNmberViewContaintContraint)
        
        self.numberViewContaintSubView()
        
        //self.numberViewContaint?.backgroundColor = UIColor.brownColor()
        
        //add constraint to subTotalViewContaint
        let vSubTotalViewContaint = "V:|-0-[subTotalViewContaint]-0-|"
        
        let vSubTotalViewContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubTotalViewContaint, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["subTotalViewContaint" :subTotalViewContaint!])
        
        self.viewContraint.addConstraints(vSubTotalViewContaintConstraint)
        
        self.subTotalViewContaintSubView()
        
        
        let vButtonViewContaintVFL = "V:|-0-[buttonViewContaint]-0-|"
        
        let vButtonViewContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonViewContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["buttonViewContaint" :buttonViewContaint!])
        
        self.viewContraint.addConstraints(vButtonViewContaintConstraint)
        
        self.buttonViewContaintSubView()
        
        
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
        
        self.addSubViewToHearderViewContraintGoodsContraint(goodsContaint, text: "    Goods")
        
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
        
        let hLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
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
        
        button.setTitle("Remove", forState: UIControlState.Normal)

        button.userInteractionEnabled                    = false

        button.titleLabel?.font                          = UIFont.systemFontOfSize(12.0)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

        button.addTarget(self, action: #selector(MUMeOrderDetailTableViewCell.removeButtonByClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        self.buttonViewContaint?.addSubview(button)

        //add constraint to button
        let hConstraint                                  = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)

        self.buttonViewContaint?.addConstraint(hConstraint)

        let vConstraint                                  = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)

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
        
        subTotalLabel.textColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
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

        
        numberLabel.text = "\((modal?.numberOfBuy)!)"
        
        numberLabel.textAlignment = NSTextAlignment.Center
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.numberViewContaint?.addSubview(numberLabel)
        
        //add constraint
        
        let vConstraint = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.numberViewContaint, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        self.numberViewContaint?.addConstraint(vConstraint)
        
        let vConstraintX = NSLayoutConstraint(item: numberLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.numberViewContaint, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.numberViewContaint?.addConstraint(vConstraintX)
        
        
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
    
    private func goodsViewContaintSubView(sView : UIView,modal:MUMeOrderedGoodsModal){
        
        let goodsImageView = UIImageView()
        
       // sView.backgroundColor = UIColor.redColor()
        
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
        
        //delegate?.removeCellForIndexPath!(indexPath,imageName: (modal?.imageName)!,flag: self.tag % 100)
    }
    

}
