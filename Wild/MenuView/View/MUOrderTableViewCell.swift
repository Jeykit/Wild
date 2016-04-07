//
//  MUOrderTableViewCell.swift
//  Wild
//
//  Created by Adaman on 2/19/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUOrderTableViewCell: UITableViewCell {

    var modal = MUMeOrderModal()
    
    private let priceLabel = UILabel()
    
    private let dateLabel = UILabel()
    
    private let dividerImageView = UIImageView()
    
    private let goodsImage = UIImageView()
    
    private let OrderNumberLabel = UILabel()
    
    private let OrderAmoutLabel = UILabel()
    
    private let OrderStatusLabel = UILabel()
    
    private let dotDividerImageView = UIImageView()
    
    private let logisticsButton = MUButton()
   
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
        
        //self.backgroundColor = UIColor.brownColor()
        
        self.priceLabel.text = modal.textOfPrice
        
        self.priceLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.priceLabel)
        
//        let date = NSDate()
//        
//        let format = NSDateFormatter()
//        
//        format.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        
//        let formatDate = format.stringFromDate(date)
//        
//        let str = "Order date:\(formatDate)"
        
        self.dateLabel.text = modal.textOfData
        
        self.dateLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.dateLabel)
        
        self.dividerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.dividerImageView.image = modal.solidImage
        
        self.contentView.addSubview(self.dividerImageView)
        
        self.goodsImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.goodsImage.image = modal.imageOfGoods
        
        self.contentView.addSubview(self.goodsImage)
        
        self.OrderNumberLabel.text = modal.textOfNumber
        
        self.OrderNumberLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.OrderNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.OrderNumberLabel)
        
        self.OrderAmoutLabel.text = modal.textOfAmout
        
        self.OrderAmoutLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.OrderAmoutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.OrderAmoutLabel)
        
        self.OrderStatusLabel.text = "Order Status     " + modal.textOfStatus!
        
        self.OrderStatusLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.OrderStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.OrderStatusLabel)
        
        self.dotDividerImageView.image = modal.dotImage
        
        self.dotDividerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.dotDividerImageView)
        
        self.logisticsButton.setTitle("Logistics", forState: UIControlState.Normal)
        
        self.logisticsButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        self.logisticsButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        self.logisticsButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.logisticsButton.setImage(modal.imageOfButton, forState: UIControlState.Normal)
        
        self.contentView.addSubview(self.logisticsButton)
        
//        self.separatorView.backgroundColor = UIColor.blackColor()
//        
//        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.contentView.addSubview(self.separatorView)
        
        self.layoutSubviews()
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        //add constraint to priceLabel
        let hPriceLabelConstraint = NSLayoutConstraint(item: self.priceLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hPriceLabelConstraint)
        
        let vPriceLabelConstraint = NSLayoutConstraint(item: self.priceLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vPriceLabelConstraint)
        
        //add constraint to dateLabel
        
        let hDateLabelConstraint = NSLayoutConstraint(item: self.dateLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.addConstraint(hDateLabelConstraint)
        
        let vDateLabelConstraint = NSLayoutConstraint(item: self.dateLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vDateLabelConstraint)
        
        //add constraint to dividerImageView
        let hDividerImageViewConstraintLeft = NSLayoutConstraint(item: self.dividerImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hDividerImageViewConstraintLeft)
        
        let hDividerImageViewConstraintRight = NSLayoutConstraint(item: self.dividerImageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.01, constant: -12)
        
        self.addConstraint(hDividerImageViewConstraintRight)
        
        let vDividerImageViewConstraint = NSLayoutConstraint(item: self.dividerImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.priceLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vDividerImageViewConstraint)
        
        //add constraint to goodsImage
        let hGoodsImageConstraint = NSLayoutConstraint(item: self.goodsImage, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hGoodsImageConstraint)
        
        let vGoodsImageConstraint = NSLayoutConstraint(item: self.goodsImage, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.dividerImageView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vGoodsImageConstraint)
        
        //add constraint to orderNumberLabel
        
        let hOrderNumberLabel = NSLayoutConstraint(item: self.OrderNumberLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.goodsImage, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hOrderNumberLabel)
        
        let vOrderNumberLabel = NSLayoutConstraint(item: self.OrderNumberLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.dividerImageView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vOrderNumberLabel)
        
        //add constraint to OrderAmoutLabel
        
        let hOrderAmoutLabel = NSLayoutConstraint(item: self.OrderAmoutLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.goodsImage, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hOrderAmoutLabel)
        
        let vOrderAmoutLabelVFL = "V:[OrderNumberLabel]-12-[OrderAmoutLabel]-12-[OrderStatusLabel]"
        
        let vOrderAmoutLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vOrderAmoutLabelVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["OrderNumberLabel" : OrderNumberLabel,"OrderAmoutLabel" : OrderAmoutLabel,"OrderStatusLabel" : OrderStatusLabel])
        
        self.addConstraints(vOrderAmoutLabelConstraint)

        //add constraint to OrderStatusLabel
        
        let hOrderStatusLabelConstraint = NSLayoutConstraint(item: self.OrderStatusLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.goodsImage, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hOrderStatusLabelConstraint)
        
        let hOrderStatusLabelConstraints = NSLayoutConstraint(item: self.OrderStatusLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.goodsImage, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        self.addConstraint(hOrderStatusLabelConstraints)
        
        //add constraint to dotDividerImageView
        
        let hDotDividerImageViewLeft = NSLayoutConstraint(item: self.dotDividerImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(hDotDividerImageViewLeft)

        let hDotDividerImageViewRight = NSLayoutConstraint(item: self.dotDividerImageView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.addConstraint(hDotDividerImageViewRight)
        
        let vDotDividerImageViewConstraint = NSLayoutConstraint(item: self.dotDividerImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.OrderStatusLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.addConstraint(vDotDividerImageViewConstraint)

        //add constraint to LogisticsButton
        
        let hLogisticsButtonConstraint = NSLayoutConstraint(item: self.logisticsButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.addConstraint(hLogisticsButtonConstraint)

        let vLogisticsButtonConstraintVFL = "V:[dotDividerImageView]-12-[logisticsButton]-12-|"
        
        let vLogisticsButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLogisticsButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["dotDividerImageView" : dotDividerImageView,"logisticsButton" : logisticsButton])
        
        self.addConstraints(vLogisticsButtonConstraint)
        
        //add constraint to separatorView
        
//        let hSpearatorViewVFL = "H:|-0-[separatorView]-0-|"
//        
//        let hSeparatorViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSpearatorViewVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["separatorView" : separatorView])
//        
//        self.addConstraints(hSeparatorViewConstraint)
        
    }
    
}
