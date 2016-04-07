//
//  MUCollectionCellCollectionViewCell.swift
//  Wild
//
//  Created by Adaman on 1/27/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUCollectionCellCollectionViewCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    
    var collectionCellModal:MUCollectionViewCellModal? = MUCollectionViewCellModal()
    
    var delegate:MUImageByTapDelegate?
    
    private let goodsImageView            = UIImageView()
    
    private let buttonOfBuy               = MUButton()
    
    private let priceOfLabel              = UILabel()
    
    private let detatileOfLabel           = UILabel()
    
    private let space                     = 12
    
    private let commentView               = UIView()
    
    private let commentImageView_00       = UIImageView()
    
    private let commentImageView_01       = UIImageView()
    
    private let commentImageView_02       = UIImageView()
    
    private let commentImageView_03       = UIImageView()
    
    private let commentImageView_04       = UIImageView()
    
    private var textOfPriceLabelHeight:CGFloat    = 0.0
    
    private var textOfDeataileHeight:CGFloat      = 0.0
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //self.label.text = "9099"
        //let Hcons = NSLayoutConstraint(item: self.goodsImgV, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.backgroundColor = UIColor.whiteColor()
        
        self.customView()
        
        
        self.layoutSubviews()
       
    }


    override func layoutSubviews() {
        
        //add data to goods image os showing
        self.goodsImageView.image = self.collectionCellModal?.imageOfGoods
        
        self.goodsImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.goodsImageView.tag  = (collectionCellModal?.flag)!
        
        //add data to a button of buy
        self.buttonOfBuy.setImage(self.collectionCellModal?.imageOfButtonNormol, forState: UIControlState.Normal)
        
        self.buttonOfBuy.setImage(self.collectionCellModal?.imageOfButtonHightlight, forState: UIControlState.Selected)
        
        self.buttonOfBuy.setTitle(self.collectionCellModal?.titleOfButton, forState: .Normal)
        
        self.buttonOfBuy.titleLabel?.font = UIFont.systemFontOfSize((self.collectionCellModal?.fontSizeOfButton)!)
        
        
        //add data to priceLabel
        self.priceOfLabel.text = "$" + (self.collectionCellModal?.textOfPrice)!
        
        self.textOfPriceLabelHeight = 14.0
        
        self.priceOfLabel.font = UIFont.systemFontOfSize(self.collectionCellModal!.fontSizeOfPriceLabel)
        
        //add data to detaileLabel
        self.detatileOfLabel.font = UIFont.systemFontOfSize(self.collectionCellModal!.fontSizeOfDetaileLabel)
        
        self.detatileOfLabel.text = self.collectionCellModal!.textOfDetaile
        
        self.textOfDeataileHeight = 20.0
        
        //add data to comment of view
        self.commentImageView_00.image = self.collectionCellModal!.imageOfComment
        
        self.commentImageView_01.image = self.collectionCellModal!.imageOfComment
        
        self.commentImageView_02.image = self.collectionCellModal!.imageOfComment
        
        self.commentImageView_03.image = self.collectionCellModal!.imageOfComment
        
        self.commentImageView_04.image = self.collectionCellModal!.imageOfComment
        
        //add layoutConstraint to custom view
        self.customLayoutWithAutolayout()
        
        //add comment images
        self.addCustomCommentImage()
        
        
    }
    
    private func addCustomCommentImage() {
        
        var commentNumber = Int((self.collectionCellModal?.numberOfCommentimage)!)
        
        if commentNumber >= 5 {
            
            commentNumber = 5
        }
        
        for (index,element) in commentView.subviews.enumerate() {
            
            if index < commentNumber{
                
                if element.isKindOfClass(UIImageView){
                    
                    let imageview = element as! UIImageView
                    
                    imageview.image = UIImage(named: "comment-icon-normal_24px")
                    
                }
                
            }
        }
        
        if commentNumber <= 3 {
            
            let imageView = commentView.subviews[commentNumber] as! UIImageView
            
            if ((self.collectionCellModal?.numberOfCommentimage)! - Float(commentNumber) >= 0.5){
                
                imageView.image = UIImage(named: "comment-icon-half")
                
            }
            
        }
        
        
    }
    func addToCarButtonByClicked(button : MUButton) {
        
        //go to detailViewController
        
        if ((delegate?.respondsToSelector(#selector(MUCollectionCellCollectionViewCell.addToCarButtonByClicked(_:)))) != nil){
            
            self.delegate?.getImageInfoByTap(flag: self.goodsImageView.tag)
        }
        
        //print("======================\(tempShoppingData)")

    }
    func customView(){
        
        
        self.backgroundColor = UIColor.customWhite()
        //Create a goods show view
        //goodsImageView.image = UIImage(named:self.imageName!)
        self.contentView.addSubview(goodsImageView)
        
        goodsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.goodsImageView.userInteractionEnabled               = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MUCollectionCellCollectionViewCell.imageByTap(_:)))
        
        tapGesture.delegate = self
        
        tapGesture.numberOfTapsRequired = 1
        
        tapGesture.numberOfTouchesRequired = 1
        
        self.goodsImageView.addGestureRecognizer(tapGesture)
        
        //Create a button of buy
        self.buttonOfBuy.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonOfBuy.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        self.buttonOfBuy.titleLabel?.textAlignment = NSTextAlignment.Center
        
        self.buttonOfBuy.setTitleColor(UIColor.customWhite(), forState: UIControlState.Normal)
        
        self.buttonOfBuy.setTitleColor(UIColor.customWhite(), forState: UIControlState.Highlighted)
        
        self.buttonOfBuy.addTarget(self, action: #selector(MUCollectionCellCollectionViewCell.addToCarButtonByClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //if no this line code ,it will have a dislocation shadow
        self.contentView.addSubview(self.buttonOfBuy)
        
        //Create a price label to decripties goods
        self.priceOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //self.priceOfLabel.backgroundColor = UIColor.blueColor()
        self.priceOfLabel.sizeToFit()
        
        self.priceOfLabel.preferredMaxLayoutWidth = self.frame.size.width * 0.6
        
        self.priceOfLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.priceOfLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Vertical)
        
        self.priceOfLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Vertical)
        
        self.priceOfLabel.textColor = UIColor.customBlack()
        
       self.priceOfLabel.frame.size.height = self.textOfPriceLabelHeight
        //let str = self.priceOfLabel.text! as NSString
       self.contentView.addSubview(self.priceOfLabel)

        //Create a detaile label to decripties goods
        self.detatileOfLabel.numberOfLines = 2
        
        self.detatileOfLabel.sizeToFit()
        
        self.detatileOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.detatileOfLabel.bounds.size.height = self.textOfDeataileHeight
        
        self.detatileOfLabel.textColor = UIColor.customBlack()
        
        self.contentView.addSubview(self.detatileOfLabel)
        
        //Create a comment of UIView
        commentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(commentView)


        //Create five comment of imageViews
        self.commentImageView_00.translatesAutoresizingMaskIntoConstraints = false
        
        //self.commentImageView_00.hidden = true
        
        self.commentImageView_01.translatesAutoresizingMaskIntoConstraints = false
        
        //self.commentImageView_01.hidden = true
        
        self.commentImageView_02.translatesAutoresizingMaskIntoConstraints = false
        
        //self.commentImageView_02.hidden = true
        
        self.commentImageView_03.translatesAutoresizingMaskIntoConstraints = false
        
        //self.commentImageView_03.hidden = true
        
        self.commentImageView_04.translatesAutoresizingMaskIntoConstraints = false
        
       // self.commentImageView_04.hidden = true
        
        commentView.addSubview(self.commentImageView_00)
        
        commentView.addSubview(self.commentImageView_01)
        
        commentView.addSubview(self.commentImageView_02)
        
        commentView.addSubview(self.commentImageView_03)
        
        commentView.addSubview(self.commentImageView_04)

    }
    
    func customLayoutWithAutolayout(){
        
        //autolayout of button of buy
        let buttonOfSpace:CGFloat = self.frame.size.width*0.4/2
        
        let hButtonOfVFL          = "H:|-buttonOfSpace-[buttonOfBuy]-buttonOfSpace-|"
        
        let hButtonOfConstraint   = NSLayoutConstraint.constraintsWithVisualFormat(hButtonOfVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["buttonOfSpace" : buttonOfSpace], views: ["buttonOfBuy" : buttonOfBuy])
        
        self.contentView.addConstraints(hButtonOfConstraint)
        
        
        //autolayout of imageView of goods
        let hGoodsOfImageViewVFL        = "H:|-0-[goodsOfImage]-0-|"
        
        let hGoodsOfImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hGoodsOfImageViewVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["goodsOfImage" : goodsImageView])
        
         self.contentView.addConstraints(hGoodsOfImageViewConstraint)
        
        
        //autolayout of  button and imageView
        let vButtonAndImageViewVFL        = "V:|-0-[goodsOfImage]-space-[buttonOfBuy]"
        
        let vButtonAndImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonAndImageViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["space" : self.space], views: ["goodsOfImage" : goodsImageView,"buttonOfBuy" : buttonOfBuy])
        
        self.contentView.addConstraints(vButtonAndImageViewConstraint)
        
        
        //autolayout of priceLabel
        let vLabelOfPriceVFL               = "V:[buttonOfBuy]-space-[priceOfLabel]"
        
        let vLabelOfPriceConstraint        = NSLayoutConstraint.constraintsWithVisualFormat(vLabelOfPriceVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["space" : self.space], views: ["buttonOfBuy" : self.buttonOfBuy,"priceOfLabel" : self.priceOfLabel])
        
           self.contentView.addConstraints(vLabelOfPriceConstraint)
        
        
        //autolayout of detaileLavel
        let vLabelOfDetaileVFL            = "V:[priceOfLabel]-space-[detaileLab]"
        let vLabelOfDetaileConstraint     = NSLayoutConstraint.constraintsWithVisualFormat(vLabelOfDetaileVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["space" : self.space], views: ["priceOfLabel" : self.priceOfLabel,"detaileLab" : self.detatileOfLabel])
        
        self.contentView.addConstraints(vLabelOfDetaileConstraint)
        
        
        let hLabelOfDetaileVFL            = "H:|-(>=buttonOfSpace)-[detatileOfLabel]-(>=buttonOfSpace)-|"
        
        let hLabelOfDetaileConstraint     = NSLayoutConstraint.constraintsWithVisualFormat(hLabelOfDetaileVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["buttonOfSpace" : buttonOfSpace], views: ["detatileOfLabel" : self.detatileOfLabel])
        
          self.contentView.addConstraints(hLabelOfDetaileConstraint)
        
        
        //autolayout of comment of view
        let vCommentViewVFL               = "V:[detatileOfLabel]-space-[commentView]"
        
        let vCommentViewConstraint        = NSLayoutConstraint.constraintsWithVisualFormat(vCommentViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["space" : self.space], views: ["detatileOfLabel" : self.detatileOfLabel,"commentView" : commentView])
        
        self.contentView.addConstraints(vCommentViewConstraint)
        

        let hSpace = (self.frame.size.width - 12*9)/2
        
        let hCommentViewVFL               = "H:|-hSpace-[commentView]-hSpace-|"
        
        let hCommentViewConstraint        = NSLayoutConstraint.constraintsWithVisualFormat(hCommentViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["hSpace" : hSpace], views: ["commentView" : commentView])
        
        self.contentView.addConstraints(hCommentViewConstraint)
        
        
        //autolayout of comment of image
        let vCommentOfImageVFL            = "V:|-0-[commentImageView_00]-0-|"
        
        let vCommentOfImageConstraint     = NSLayoutConstraint.constraintsWithVisualFormat(vCommentOfImageVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: nil, views: ["commentImageView_00" : self.commentImageView_00])
        
        commentView.addConstraints(vCommentOfImageConstraint)
        

        let hCommentOfImageVFL = "H:|-0-[commentImageView_00]-space-[commentImageView_01]-space-[commentImageView_02]-space-[commentImageView_03]-space-[commentImageView_04]-0-|"
        
        let hCommentOfImageConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hCommentOfImageVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: ["space" : self.space], views: ["commentImageView_00" : self.commentImageView_00,"commentImageView_01" : self.commentImageView_01,"commentImageView_02" : self.commentImageView_02,"commentImageView_03" : self.commentImageView_03,"commentImageView_04" : self.commentImageView_04])
        
        commentView.addConstraints(hCommentOfImageConstraint)
    
        
    }

    func computingTextSize(text:String)->CGSize{
        
        //Computing text size
        let str         = text as NSString
        
        let size:CGSize = str.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12)])
        
        return size
    }
    
    func textOflineHeight(text:String) ->NSMutableAttributedString{
        
        let length = (text as NSString).length
        //set line space
        let attributedStr = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 16
            attributedStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, length))
                //self.detatile.attributedText = attributedStr

        return attributedStr
    }
    
    func imageByTap(tap:UITapGestureRecognizer){
        
        if tap.numberOfTouches() == 1{
            
            let ima = tap.view as! UIImageView
            
            if ((delegate?.respondsToSelector(#selector(MUCollectionCellCollectionViewCell.imageByTap(_:)))) != nil){
                
                self.delegate?.getImageInfoByTap(flag: ima.tag)
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
