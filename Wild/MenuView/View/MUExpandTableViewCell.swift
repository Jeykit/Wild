//
//  MUExpandTableViewCell.swift
//  Wild
//
//  Created by Adaman on 3/4/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit


class MUExpandTableViewCell: UITableViewCell,TTTAttributedLabelDelegate{

    
    //var labelView:TTTAttributedLabel?
    
    var delegate:MULabelTextByClickDelegate?
    
    var indexPath:NSIndexPath?
    
    private var label:TTTAttributedLabel?
    
    private var imgView: UIImageView?
    
    private var labelView:UILabel?
    
    //private var label:UILabel?
    
    //var tLable:UILabel?
    
    private var boldRange:NSRange?
    
    private var emailLabel:UILabel?
    
    private var userNameLabel:UILabel?
    
    private var dateLabel:UILabel?
    
    private var commentOfImage:UIImageView?
    
    private var commentLabel:UILabel?
    
    var modal:MUExpandCellModal?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       // self.translatesAutoresizingMaskIntoConstraints = false
        
        self.customSubView()
        
       // self.customLabelView()
        
    }
    
   private func customLabelView() {
    
    self.labelView = UILabel(frame: self.frame)
    
    self.labelView?.numberOfLines = 1
    
    self.labelView?.lineBreakMode = NSLineBreakMode.ByWordWrapping

    
   }

   private  func customSubView(){
    
        
        //self.label = UILabel(frame: self.frame)
    
        self.label = TTTAttributedLabel(frame: (self.frame))
        
        self.label!.delegate = self
    
        for cellElement in self.contentView.subviews{
            
            
            if cellElement.isMemberOfClass(TTTAttributedLabel){
                
                
                cellElement.removeFromSuperview()
                
            }
            
        }
    
        // self.label = TTTAttributedLabel(frame: self.frame)
        
        label!.translatesAutoresizingMaskIntoConstraints = false
        
        label!.lineBreakMode = NSLineBreakMode.ByCharWrapping
    
        // self.label?.sizeThatFits(CGSizeMake(self.frame.width,CGFloat(MAXFLOAT)))
        
        label!.textAlignment = NSTextAlignment.Left
        
        label!.font = UIFont.systemFontOfSize(12.0)
        
        self.contentView.addSubview(label!)
        // self.labelView?.addSubview(label!)
        
        self.bringSubviewToFront(self.label!)
        
        self.contentView.userInteractionEnabled = true
        
        label!.numberOfLines = 0
        
        label!.userInteractionEnabled = true
        
        //self.label?.extendsLinkTouchArea = false
        
        label!.font = UIFont.systemFontOfSize(12.0)

         self.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   override func layoutSubviews() {
    
       self.addTextStyle()

       self.addlink()
    
    
    }
    
   private func computeLength(nStr : NSString) -> NSString{
        
        //The number of bytes for each row 1bytes = 6~8point?
        let bytes = Int(self.frame.width / 8)
        
        let lengthBytes = nStr.length
        
        var newString:NSString? = nStr
        
        let reSize = nStr.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12.0)])
        
        //compute row numbr
        let rowNumber = Int(self.frame.height / reSize.height)
        
        let totalBytes = rowNumber * Int(bytes)
        
        if totalBytes > lengthBytes {
            
        }else{
            
            //let subNum = (lengthBytes - totalBytes)+10
            
            newString = nStr.substringToIndex(totalBytes - 10)        
           
    }
        
        return newString!
    }
    
   private func addTextStyle(){
        
        let linkString = "More"
        
        let text = self.computeLength(modal!.subDecription!) as String + "... " + linkString
     
         //text = self.modal!.subDecription! + " ... " + linkString
    
    
        self.label?.setText(text, afterInheritingLabelAttributesAndConfiguringWithBlock: { (mutableAttributedString) -> NSMutableAttributedString in
            
            //设置可点击文字的范围
            let nstext = mutableAttributedString.string as NSString
            
            self.boldRange = nstext.rangeOfString(linkString, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            //设定可点击文字的的大小
            
            let boldSystemFont = UIFont.systemFontOfSize(12.0)
            
            let font = CTFontCreateWithName(boldSystemFont.fontName, boldSystemFont.pointSize, nil)
            
            mutableAttributedString.addAttribute(kCTFontAttributeName as String, value: font as AnyObject, range: self.boldRange!)
            
            mutableAttributedString.addAttribute(kCTForegroundColorAttributeName as String, value: UIColor.blackColor(), range: self.boldRange!)
            
//            let paragraphStyle = NSMutableParagraphStyle()
//            
//            paragraphStyle.firstLineHeadIndent = 12.0
//            
//            mutableAttributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, Int        ((text as NSString).length)))
            
            return mutableAttributedString
            
        })
    
        self.label!.preferredMaxLayoutWidth = self.frame.width
        //Implment adaptive layout
        label?.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)

    }
   private func addlink(){
        
        
        // 没有点击时候的样式
        self.label?.linkAttributes = [kCTForegroundColorAttributeName : UIColor.blueColor().CGColor,kCTUnderlineStyleAttributeName : NSNumber(int: CTUnderlineStyle.None.rawValue)]
        
        // 点击时候的样式
        //let activeStyle = CTUnderlineStyle.None as! AnyObject
        
        self.label?.activeLinkAttributes = [kCTForegroundColorAttributeName : UIColor.redColor().CGColor,kCTUnderlineStyleAttributeName : NSNumber(int: CTUnderlineStyle.None.rawValue)]
        
        self.label?.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        
        self.label?.addLinkToURL(NSURL(string: "More"), withRange: boldRange!)
        
        //self.addConstraintToLabel()

    }
 
   private func boundingRectWithSize() -> CGFloat{
        
    
        let rstr:NSString = self.modal!.detailDecription! as NSString
        
        self.label?.text = rstr as String
        
        //let reSize = rstr.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12.0)])
        
        let labelHeight = self.label?.sizeThatFits(CGSizeMake(self.frame.width, CGFloat(MAXFLOAT))).height
        
    return labelHeight!
        
    }
    
   @objc internal func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        
        var rowHeight = self.boundingRectWithSize()
        
        if indexPath?.section == 1 {
            
            if indexPath?.row == 0 {
                
                if ((modal?.modal?.email) != nil) {
                    
                    rowHeight = rowHeight + 100.0
                }else{
                    
                    return
                }
                
            }else{
                
                rowHeight = 100.0
            }
            
        }else if indexPath?.section == 2{
            rowHeight = rowHeight + self.getImageSize().height
        }
       
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            
            self.addTextLable(self.indexPath!)
            
        }
        
        
        delegate?.labelTextByClick(rowHeight, indexPath: indexPath!)
        
        
    }
    
 /* private  func addConstraintToLabel(){
        
        let hLableConstraintVFL = "|-0-[label]-0-|"
        
         self.hLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hLableConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label" : self.textLabel!])
        
        self.addConstraints(self.hLabelConstraint)
        
        let vLabelConstraintVFL = "|-0-[label]-0-|"
        
        self.vLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label" : self.textLabel!])
        self.addConstraints(vLabelConstraint)
        
        //self.updateConstraints()

    }
    
  func removeConstraintFromLabel(){
        
        self.removeConstraints((self.hLabelConstraint))
        
        self.removeConstraints((self.vLabelConstraint))
    }*/
    
  override func prepareForReuse() {
        
        super.prepareForReuse()
    
       // self.removeCustomSubview()
    
        self.removeTextLabel()
    
        self.label?.hidden = false
    
        
    }

   private func setLabelOptional(){
        
        
         self.textLabel!.preferredMaxLayoutWidth = self.frame.width
        
         self.textLabel!.translatesAutoresizingMaskIntoConstraints = false
        
         self.textLabel!.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        
         self.textLabel!.textAlignment = NSTextAlignment.Left
        
         self.textLabel!.font = UIFont.systemFontOfSize(12.0)
    
        self.contentView.userInteractionEnabled = true
        
         self.textLabel!.numberOfLines = 0
        
         self.textLabel!.userInteractionEnabled = true
        
        //self.label?.extendsLinkTouchArea = false
        
         self.textLabel!.font = UIFont.systemFontOfSize(12.0)
    
         self.bringSubviewToFront(self.textLabel!)
    
         self.textLabel?.hidden = false
        
       // self.addConstraintToLabel()
    }
    
    func removeTextLabel(){
        
        //self.removeConstraintFromLabel()
        
        self.textLabel?.text = nil
        
        //self.textLabel?.removeFromSuperview()
        
        self.textLabel?.hidden = true
        
        self.customSubView()
        
        //self.label?.backgroundColor = UIColor.yellowColor()
        //self.bringSubviewToFront(self.label!)
        
        self.setNeedsLayout()
        
        self.setNeedsUpdateConstraints()
        //self
        
        self.insertSubview(self.textLabel!, belowSubview: self.label!)
        
        self.imageView?.image = nil
        
        self.insertSubview(self.imageView!, belowSubview: self.label!)
        
        self.removeCustomSubview()
        
//        self.emailLabel?.removeFromSuperview()
//        
//        self.userNameLabel?.removeFromSuperview()
//        
//        self.dateLabel?.removeFromSuperview()
//        
//        self.commentLabel?.removeFromSuperview()
//        
//        self.commentOfImage?.removeFromSuperview()
//        
//        self.commentLabel?.removeFromSuperview()

    }
    
    func addTextLable(indexPath : NSIndexPath) {
        
        self.setLabelOptional()
        
        //self.addSubview(self.textLabel!)
        
        self.textLabel?.text = self.modal?.detailDecription
        
        self.label?.hidden = true
        
        self.textLabel?.hidden = false
        
       // if ((modal?.modal?.email) != nil) {
            
            
            if indexPath.section == 0{
                
                self.removeCustomSubview()
                
            }else if indexPath.section == 1{
                
                if indexPath.row == 0 {
                    
                    let labelX = CGRectGetMinX((self.textLabel?.frame)!)
                    
                    let labelY = self.boundingRectWithSize()+12.0
                    
                    self.setCustomSubview(labelX,labelY: labelY)  
                    
                }else{
                    
                    self.textLabel?.text = nil
                    
                    self.textLabel?.hidden = true
                    
                    let labelX:CGFloat = 0
                    
                    let labelY:CGFloat = 0
                    
                    self.setCustomSubview(labelX,labelY: labelY)
                    
                    
                }
                
            }else {
                
                self.removeCustomSubview()
                
                let labelX = CGRectGetMinX((self.textLabel?.frame)!)
                
                let labelY = self.boundingRectWithSize()
                
                let imagePath = NSBundle.mainBundle().pathForResource("snipping", ofType: "png")
                
                let image = UIImage(contentsOfFile: imagePath!)
                
                self.imageView?.image = image
                
               // print("================\(image?.size.width)")
                
                self.imageView?.frame = CGRectMake(labelX, labelY, self.frame.width,(image?.size.height)!)
                
                self.bringSubviewToFront(self.imageView!)
                
            }

            
       // }
        
        
        //self.textLabel?.backgroundColor = UIColor.redColor()
        
        
        
        self.setNeedsLayout()
        
        self.setNeedsUpdateConstraints()
        
    }
    
    private func setCustomSubview(labelX : CGFloat,labelY : CGFloat) {
        
       // let path = NSBundle.mainBundle().pathForResource("snipping", ofType: "png")
        
        //let image = UIImage(contentsOfFile: path!)
        let imageData = modal?.modal?.hImage
        
        self.imageView?.image = UIImage(data: imageData!)
        
        self.imageView?.frame = CGRectMake(labelX, labelY, 30.0, 40.0)
        
        self.emailLabel = UILabel()
        
        let emailText = (modal?.modal?.email)! as NSString
        
        let subHeaderText = emailText.substringToIndex(4)
        
        let range = emailText.rangeOfString("@")
        
        let centerText = emailText.substringWithRange(NSMakeRange(range.location - 2, 2))
        
        let subTailText = emailText.substringWithRange(NSMakeRange(range.location, emailText.length - range.location))

        emailLabel!.text = (subHeaderText as String) + "***" + centerText + subTailText
        
        emailLabel?.font = UIFont.systemFontOfSize(12.0)
        
        emailLabel!.sizeToFit()
        
        let imageX = CGRectGetMaxX((self.imageView?.frame)!) + 12.0
        
        emailLabel!.frame = CGRectMake(imageX, labelY, 120, 12.0)
        
        self.addSubview(emailLabel!)
        
        //add userName label
        
        self.userNameLabel = UILabel()
        
        userNameLabel!.text = modal?.modal?.username
        
        userNameLabel?.font = UIFont.systemFontOfSize(12.0)
        
        userNameLabel!.sizeToFit()
        
        let emailY = CGRectGetMaxY((self.emailLabel!.frame)) + 12.0
        
        userNameLabel!.frame = CGRectMake(imageX, emailY, 108, 12.0)
        
        self.addSubview(userNameLabel!)
        
        //add date label
        self.dateLabel = UILabel()
        
        self.dateLabel?.text = modal?.modal?.date
        
        self.dateLabel?.sizeToFit()
        
        dateLabel?.font = UIFont.systemFontOfSize(12.0)
        
        let dateLabelX = self.frame.width - 108
        
        self.dateLabel?.frame = CGRectMake(dateLabelX, labelY, 108, 12.0)
        
        self.addSubview(dateLabel!)
        
        //add comment of image
        self.commentOfImage = UIImageView()
        
        let commentX = self.frame.width - 108
        
        self.commentOfImage?.frame = CGRectMake(commentX, emailY, 108, 12.0)
        
        self.addSubview(self.commentOfImage!)
        
        self.customImageViewOfComment(self.commentOfImage!)
        //self.commentOfImage(self.commentOfImage!, num: 0)
        //self.addCommentOfImage(self.commentOfImage)
        
        //add comment label
        self.commentLabel = UILabel()
        
        self.commentLabel?.text = modal!.modal?.commentText
        
        commentLabel?.font = UIFont.systemFontOfSize(12.0)
        
        commentLabel?.textColor = UIColor.grayColor()
        
        self.commentLabel?.sizeToFit()
        
        let cLabelY = CGRectGetMaxY((self.imageView?.frame)!) + 12
        
        self.commentLabel?.frame = CGRectMake(labelX, cLabelY, self.frame.width, 24.0)
        
        self.addSubview(self.commentLabel!)
        
        
    }
    
  private  func removeCustomSubview() {
    
        self.emailLabel?.removeFromSuperview()
    
        self.userNameLabel?.removeFromSuperview()
    
        self.dateLabel?.removeFromSuperview()
    
        self.commentLabel?.removeFromSuperview()
    
        self.commentOfImage?.removeFromSuperview()
    
        self.commentLabel?.removeFromSuperview()

    
    }
    
    func customImageViewOfComment(sView : UIImageView)  {
        
        let commentNumber = modal?.modal?.score
        
        var flag = 0
        
        while(flag <= commentNumber) {
            
            let imgX = CGFloat(2*(12*flag))
            
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: "Comments_dehalut_24")
            
            imageView.frame = CGRectMake(imgX, 0, 12.0, 12.0)
            
            sView.addSubview(imageView)
            
            flag = flag + 1
            
        }
        
        if commentNumber < 4 {
            
            while(flag <= 4) {
                
                let imgX = CGFloat(2*(12*flag))
                
                let imageView = UIImageView()
                
                imageView.image = UIImage(named: "comment-icon-none")
                
                imageView.frame = CGRectMake(imgX, 0, 12.0, 12.0)
                
                sView.addSubview(imageView)
                
                flag = flag + 1
                
            }

            
        }
        
    }
    
  /*private  func commentOfImage(sView : UIImageView,num : Int)  {
    
    
        let commentNumber = modal?.modal?.score
    
        for index in 0...commentNumber {
            
            let imgX = CGFloat(2*(12*index))
            
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: "Comments_dehalut_24")
            
            imageView.frame = CGRectMake(imgX, 0, 12.0, 12.0)
            
            sView.addSubview(imageView)
            
            
            }
    
         if commentNumber < 4 {
        
         let tempFlag = commentNumber + 1
        
         for element in tempFlag...4 {
            
            let imgX = CGFloat(2*(12*index))
            
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: "comment-icon-none")
            
            imageView.frame = CGRectMake(imgX, 0, 12.0, 12.0)
            
            sView.addSubview(imageView)
        }
        
       }

    }*/
    
    
   private func getImageSize() -> CGSize {
    
        let path = NSBundle.mainBundle().pathForResource("snipping", ofType: "png")
        
        let image = UIImage(contentsOfFile: path!)
        
        return (image?.size)!
        
    }
    
}
