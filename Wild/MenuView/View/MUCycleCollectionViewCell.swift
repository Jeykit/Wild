//
//  MUCycleCollectionViewCell.swift
//  Wild
//
//  Created by Adaman on 2/12/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUCycleCollectionViewCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    
    var image:UIImage? //= UIImage(named: "items_01_detail_iPhone_image_defalut_302")
    
    private let imageView = UIImageView()
    
    var indexPath:NSIndexPath?
    
    //var delegate:MUCycleImageByClickedDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.customView()
        
        self.layoutSubviews()
        self.backgroundColor = UIColor.blackColor()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customView(){
        
        self.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUCycleCollectionViewCell.imageViewByTaped(_:)))
        
        tap.delegate = self
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //imageView.userInteractionEnabled = true
        
        //image is null
        imageView.image = image
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        imageView.addGestureRecognizer(tap)
    
        //imageView.contentMode = UIViewContentMode.ScaleToFill
    
    }
    
    func imageViewByTaped(tap : UITapGestureRecognizer) {
        
        //delegate?.cycleImageByClicked(indexPath!)
    }
    
    override func layoutSubviews() {
        
        imageView.image = image
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit

        let hImageViewVFL = "H:|-(-2)-[imageView]-(-2)-|"
        
        let hImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hImageViewVFL, options: NSLayoutFormatOptions.AlignAllLeft.union(NSLayoutFormatOptions.AlignAllRight), metrics: nil, views: ["imageView" : self.imageView])
        
        self.addConstraints(hImageViewConstraint)
        
        let vImageViewVFL = "V:|-(-6)-[imageView]-(-6)-|"
        
        let vImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vImageViewVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["imageView" : self.imageView])
        
        self.addConstraints(vImageViewConstraint)
    }
}
