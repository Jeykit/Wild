//
//  MUViewController.swift
//  Wild
//
//  Created by Adaman on 1/25/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUViewController: UIViewController,MUDelegate,UIGestureRecognizerDelegate{

    private var navigationViewController:MUNavigationController?
    // = MUNavigationController(rootViewController:MUContentViewController())
    
    private var imageOfCut:UIImageView?

    private var menuWidth:CGFloat?
    
    private var blurView:UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.menuWidth = CGFloat(Int(self.view.frame.width * 0.38))

      self.addNavigationController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    func addNavigationController(){
        
        self.navigationViewController =  MUNavigationController(rootViewController:MUContentViewController())
        
        let root = self.navigationViewController!.childViewControllers[0] as! MUContentViewController
        root.delegate = self
        self.view.addSubview(navigationViewController!.view)
        
        self.addChildViewController(navigationViewController!)
        
        navigationViewController!.didMoveToParentViewController(self)
        

    }
    
    func getImage(img: UIImage) {
        
        navigationViewController = MUNavigationController(rootViewController: MUMenuViewController())
        
        navigationViewController?.view.frame = CGRectMake(0, 0, self.menuWidth!, self.view.frame.height)
        
        self.view.addSubview(navigationViewController!.view)
        
        self.addChildViewController(navigationViewController!)
        
        //print("===============\(self.menuWidth)")
        
        let menuViewController = self.navigationViewController?.childViewControllers[0] as! MUMenuViewController
        
        menuViewController.delegate = self
        
        menuViewController.view.frame.origin.x = -self.menuWidth!
    
        imageOfCut = UIImageView(frame: CGRectMake(self.menuWidth!, 0, self.view.frame.width, self.view.frame.height))
        
        self.imageOfCut!.frame.origin.x = 0
        
        //menuViewController.imageView = imageOfCut
        
        imageOfCut!.contentMode = UIViewContentMode.Top
        
        //imageOfCut.alpha = 0.625
        
        imageOfCut!.image = img
        
        imageOfCut!.userInteractionEnabled = true
        
        imageOfCut!.multipleTouchEnabled = true
        
        imageOfCut!.exclusiveTouch = true
        
        //imageOfCut.translatesAutoresizingMaskIntoConstraints = false
       // con = NSLayoutConstraint(item: imgV, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
       // let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        
        //let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
       // vibrancyEffectView.contentView.addSubview(imageOfCut)
        
        blurView = UIVisualEffectView(effect: blurEffect)
        
        //blurView?.contentView.addSubview(vibrancyEffectView)
        
        blurView!.frame = self.view.frame
        
        //blurView!.alpha = 0.625
        
        imageOfCut!.addSubview(blurView!)
        
        
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(MUViewController.leftState(_:)))
        
        swip.delegate = self
        
        swip.numberOfTouchesRequired = 1
        
        //if no this line code,event will not be triggered
        swip.direction = UISwipeGestureRecognizerDirection.Left
        
        imageOfCut!.addGestureRecognizer(swip)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUViewController.buttonByTap(_:)))
        
        tap.delegate = self
        
        self.imageOfCut!.addGestureRecognizer(tap)
        
        tap.numberOfTapsRequired = 1
        
       // swip.requireGestureRecognizerToFail(tap)
        
        self.view.addSubview(imageOfCut!)
  
        self.view.bringSubviewToFront((self.navigationViewController?.view)!)
        
        //self.view.addConstraint(con)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.navigationViewController?.view.frame.origin.x = 0
            
            self.imageOfCut!.frame.origin.x = self.menuWidth!
            
            //self.blurView?.frame.origin.x = self.menuWidth!
            
           // self.view.bringSubviewToFront(self.imgV)
        
            }, completion: {(flag) -> Void in
                
                //self.imageOfCut.frame = CGRectMake(self.menuWidth!, 0, self.view.frame.width, self.view.frame.height)
                
        })
      
    }
    
    func leftState(swip:UISwipeGestureRecognizer){
        
       // print("okay")
        if swip.direction == UISwipeGestureRecognizerDirection.Left{
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                self.blurView?.removeFromSuperview()
                
                self.navigationViewController?.view.frame.origin.x = -self.menuWidth!
                
                self.imageOfCut!.frame.origin.x = 0
                
                
                }, completion: { (flag) -> Void in
                    
                    self.imageOfCut!.removeFromSuperview()
                    self.imageOfCut!.image = nil
                    
                    self.blurView = nil
                    //self.view.removeConstraint(self.con)
                    
                    self.addNavigationController()
            })
            
            
        }
    }
    
    func buttonByTap(tap:UITapGestureRecognizer){
        
        if tap.numberOfTouches() == 1{
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                self.blurView?.removeFromSuperview()
                
                self.navigationViewController?.view.frame.origin.x = -self.menuWidth!
                
                self.imageOfCut!.frame.origin.x = 0
                
                }, completion: { (flag) -> Void in
                    
                    self.imageOfCut!.removeFromSuperview()
                    self.imageOfCut!.image = nil
                    
                    self.blurView = nil
                    //self.view.removeConstraint(self.con)
                    
                    self.addNavigationController()
            })
            
        }
    }
    
    func handlerLoginButton(is_login: Bool) {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.blurView?.removeFromSuperview()
            
            self.navigationViewController?.view.frame.origin.x = -self.menuWidth!
            self.imageOfCut!.frame.origin.x = 0
            
            }, completion: { (flag) -> Void in
                
                self.imageOfCut!.removeFromSuperview()
                self.imageOfCut!.image = nil
                
                self.blurView = nil
                //self.view.removeConstraint(self.con)
                
                self.addNavigationController()
        })
            
        }
       
  }

extension UIImage {
    
   class func getImageFromStr(str : String) -> UIImage{
        
        let imagePath = NSBundle.mainBundle().pathForResource(str, ofType: "jpg")
        
        let image = UIImage(contentsOfFile: imagePath!)
    
        let data = UIImageJPEGRepresentation(image!, 0.20)
    
        let newImage = UIImage(data: data!)
        
        return newImage!
    }
    
    class func resizeImage(image image:UIImage,size : CGSize) -> UIImage{
        
        UIGraphicsBeginImageContext(size)
        
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    
    }
}

extension UIColor {
    
  class func customWhite() -> UIColor {
        
        return UIColor(hue: 343.0, saturation: 0.0, brightness: 94.0, alpha: 1.0)
    }
    
  class func customBlack() -> UIColor {
        
        return UIColor(hue: 343.0, saturation: 94.0, brightness: 0.0, alpha: 1.0)
    }
    
  class func customColor() -> UIColor {
        
        return UIColor(hue: 343.0, saturation: 94.0, brightness: 94.0, alpha: 1.0)
    }
    
  class func customGrayColor() -> UIColor {
        
        return UIColor(white: 0.929, alpha: 1.0)
    }
    
 class func customBlueColor() -> UIColor {
        
        return UIColor(hue: 232.0, saturation: 94.0, brightness: 94.0, alpha: 1.0)
    }
}
