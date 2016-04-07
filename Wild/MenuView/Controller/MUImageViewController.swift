//
//  MUImageViewController.swift
//  Wild
//
//  Created by Adaman on 3/18/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUImageViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    
    var imageArray:NSMutableArray?
    
    private var scrollView:UIScrollView?
    
    private var scrollViewWidth:CGFloat?
    
    private var scrollViewHeight:CGFloat?
    
    private var smallImageViewWidth:CGFloat?
    
    private var smallImageViewHeight:CGFloat?
    
    private var edgeSpace:CGFloat?
    
    private var tempImageView:UIImageView?
    
    private var subImageView:UIView?
    
    private var isClicked:Bool = false
    
    private var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.scrollViewWidth = self.view.frame.width
        
        self.scrollViewHeight = self.view.frame.height
        
        self.smallImageViewWidth = CGFloat(Int(self.view.frame.width / 5.0))
        
        self.smallImageViewHeight = self.smallImageViewWidth! * 4 / 3
        
        self.edgeSpace = (self.view.frame.width - 3 * self.smallImageViewWidth! - 12 * 2)/2
        
        self.customSubViews()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   private func customSubViews() {
        
        self.scrollView = UIScrollView(frame: self.view.frame)
        
        self.scrollView?.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        
        self.scrollView?.directionalLockEnabled = true
        
        self.scrollView?.pagingEnabled = true
        
        self.scrollView?.showsHorizontalScrollIndicator = false
        
        self.scrollView?.showsVerticalScrollIndicator = false
    
        self.scrollView?.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        self.scrollView?.delegate = self
    
        //self.scrollView?.bounces = false
        
        self.view.addSubview(self.scrollView!)
    
        self.customImageViews(self.scrollView!)
    
        self.addCustomButton(self.view!)
    
        self.subImageView = UIView()
    
        self.subImageView?.translatesAutoresizingMaskIntoConstraints = false
    
        //self.subImageView?.userInteractionEnabled = true
    
        self.view.addSubview(self.subImageView!)
    
        //self.view.bringSubviewToFront(self.subImageView!)
    
        //self.addCustomSubImageViews(self.view!)
    
        let hImageViewConstraintVFL = "H:|-0-[subImageView]-0-|"
    
        let hImageViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hImageViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["subImageView":subImageView!])
    
        self.view.addConstraints(hImageViewConstraint)
    
    
    
        let vImageViewConstraint = NSLayoutConstraint(item: self.subImageView!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -self.edgeSpace!/2.0)
    
        self.view.addConstraint(vImageViewConstraint)
    
        let heightImageViewConstraint = NSLayoutConstraint(item: self.subImageView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier:0, constant: self.smallImageViewHeight!)
    
        self.view.addConstraint(heightImageViewConstraint)
    
        self.addCustomSubImageViews(self.subImageView!)
    

    
        self.addCustomSubImageViews(self.subImageView!)
    
    
        

    
    }
    
    private func customImageViews(scrollView : UIScrollView) {
        
        for index in 0..<3 {
            
            let imageView = UIImageView(frame: CGRectMake(CGFloat(index) * self.scrollViewWidth!, 0, self.scrollViewWidth!, self.scrollViewHeight!))
            
            imageView.image = UIImage.getImageFromStr(self.imageArray![index] as! String)
            
            imageView.userInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(MUImageViewController.addAninationToImageViewByTap(_:)))
            
            tap.delegate = self
            
            tap.numberOfTapsRequired = 1
            
            tap.numberOfTouchesRequired = 1
            
            imageView.addGestureRecognizer(tap)
            
            scrollView.addSubview(imageView)
        }
        
        
    }
    
    func addCustomButton(sView : UIView) {
        
        button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(named: "arrow"), forState: UIControlState.Normal)
        
        button.addTarget(self, action: #selector(MUImageViewController.deleteButtonByClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        sView.addSubview(button)
        
        let hButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -self.edgeSpace! / 4)
        
        sView.addConstraint(hButtonConstraint)
        
        let vButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: self.edgeSpace! / 4)
        
        sView.addConstraint(vButtonConstraint)
        
        sView.bringSubviewToFront(button)
    }

   func deleteButtonByClicked(button : UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func addCustomSubImageViews(sView : UIView) {
        
        let imageView_00 = UIImageView()
        
        //imageView_00.layer.borderColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0).CGColor
        
        imageView_00.layer.borderWidth = 2.0
        
        self.tempImageView = imageView_00
        
        imageView_00.tag = 10
        
        self.customSubViews(imageView_00, flag: 0)
        
        sView.bringSubviewToFront(imageView_00)
        
        sView.addSubview(imageView_00)
        
        let imageView_01 = UIImageView()
        
        imageView_01.tag = 11
        
        self.customSubViews(imageView_01, flag: 1)
        
        sView.bringSubviewToFront(imageView_01)
        
        sView.addSubview(imageView_01)
        
        let imageView_02 = UIImageView()
        
        imageView_02.tag = 12
        
        self.customSubViews(imageView_02, flag: 2)
        
        sView.bringSubviewToFront(imageView_02)
        
        sView.addSubview(imageView_02)
        
        let hSubImageViewsVFL = "H:|-edgeSpace-[imageView_00(==smallImageViewWidth)]-12-[imageView_01(==smallImageViewWidth)]-12-[imageView_02(==smallImageViewWidth)]-edgeSpace-|"
        
        let hSubImageViewsConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSubImageViewsVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["edgeSpace" : self.edgeSpace!,"smallImageViewWidth" : self.smallImageViewWidth!], views: ["imageView_00" : imageView_00,"imageView_01" : imageView_01,"imageView_02" : imageView_02])
        
        sView.addConstraints(hSubImageViewsConstraint)
        
        
        let vSubImageViewsVFL = "V:|-0-[imageView_00(==smallImageViewHeight)]-0-|"
        
        let vSubImageViewsConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubImageViewsVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: ["edgeSpace" : self.edgeSpace! / 2,"smallImageViewHeight" : self.smallImageViewHeight!], views: ["imageView_00" : imageView_00])
        
        sView.addConstraints(vSubImageViewsConstraint)

    }
    
    private func customSubViews(imageV : UIImageView, flag : Int){
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        
        imageV.layer.borderColor = UIColor.customColor().CGColor
        
        imageV.userInteractionEnabled = true
        
        imageV.frame.size = CGSizeMake(self.smallImageViewWidth!, self.smallImageViewHeight!)
        
        imageV.image = UIImage.getImageFromStr(self.imageArray![flag] as! String)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUImageViewController.subImageViewByTap(_:)))
        
        tap.delegate = self
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        imageV.addGestureRecognizer(tap)

    }
    
    
   func subImageViewByTap(tap : UITapGestureRecognizer) {
        
        if tap.numberOfTouches() == 1 {
            
            let imageView = tap.view as! UIImageView
            
            if imageView != self.tempImageView {
                
                imageView.layer.borderWidth = 2.0
                
                self.tempImageView?.layer.borderWidth = 0
                
                self.tempImageView = imageView
                
                self.scrollView?.setContentOffset(CGPoint(x: CGFloat(imageView.tag % 10) * self.scrollViewWidth!,y: 0), animated: false)
            }

        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pageIndex = Int((scrollView.contentOffset.x / self.scrollViewWidth!) + 0.5)
        
        if (self.tempImageView?.tag)! % 10 != pageIndex {
            
            for element in self.subImageView!.subviews {
                
                if element.isKindOfClass(UIImageView) {
                    
                    let imageV = element as! UIImageView
                    
                    let index = imageV.tag % 10
                    
                    if index == pageIndex{
                        
                        imageV.layer.borderWidth = 2.0
                        
                        self.tempImageView?.layer.borderWidth = 0
                        
                        self.tempImageView = imageV
                        
                        //self.scrollView?.setContentOffset(CGPoint(x: CGFloat(index) * self.scrollViewWidth!,y: 0), animated: false)
                        
                    }
                }
            }

        }
        
    }
    
    
    
    func addAninationToImageViewByTap(tap:UITapGestureRecognizer) {
        
        if tap.numberOfTouches() == 1 {
            
            if !self.isClicked {
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                    
                    self.button.frame.origin.y = -60
                    
                    self.subImageView?.frame.origin.y = UIScreen.mainScreen().bounds.height + 30
                    
                    }, completion: { (flag) in
                        
                        self.isClicked = true
                })
            }else{
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    
                    self.button.frame.origin.y = self.edgeSpace! / 4
                    
                    self.subImageView?.frame.origin.y = UIScreen.mainScreen().bounds.height - self.edgeSpace!/2.0 - self.smallImageViewHeight!
                    
                    }, completion: { (flag) in
                        
                        self.isClicked = false
                })
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
