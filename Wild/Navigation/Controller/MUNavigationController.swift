//
//  MUNavigationController.swift
//  Wild
//
//  Created by Adaman on 1/22/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

import ReplayKit

class MUNavigationController: UINavigationController,RPPreviewViewControllerDelegate,UIGestureRecognizerDelegate {

    private var isRecord:Bool = false
    
    private var window:UIWindow?
    
    private var recordButton:UIButton?
    
    private var isShow:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdge.None
        
        if !self.isSystemVersionOk() {
            
            self.alertView("The current version does not support screen recording.")
        }

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MUNavigationController.handlerLongPress(_:)))
        
        longPress.minimumPressDuration = 1.0
        
       // longPress.numberOfTapsRequired = 1
        
       // longPress.numberOfTouchesRequired = 1
        
        longPress.delegate = self
        
        self.view.addGestureRecognizer(longPress)
        
        self.view.userInteractionEnabled = true
        //if not this line code,it will not work/show
        self.performSelector(#selector(MUNavigationController.createButton), withObject: nil, afterDelay: 1.0)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlerLongPress(tap:UILongPressGestureRecognizer) {
        
        if tap.state == UIGestureRecognizerState.Began {
            
            if self.isShow {
                
                //customWindow.shareInstance.resignKeyWindow()
                
                //print("==========================")
                customWindow.shareInstance.hidden = true
                
                self.isShow = false
            }else{
                
                //self.performSelector(#selector(MUNavigationController.createButton), withObject: nil, afterDelay: 1.0)
                customWindow.shareInstance.hidden = false
                
                self.isShow = true
                //self.createButton()
            }
 
        }
        
    }
    
    func  createButton() {
        
        customWindow.shareInstance.frame = CGRectMake(20,self.view.frame.height - 80,60,60)
 
        customWindow.shareInstance.windowLevel = UIWindowLevelAlert + 1
        
        customWindow.shareInstance.layer.cornerRadius = 30.0
        
        customWindow.shareInstance.layer.masksToBounds = true
        
//        let window1 = UIWindow(frame:CGRectMake(20,self.view.frame.height - 80,60,60))
//        
//        self.window = window1
//        
//        self.window?.windowLevel = UIWindowLevelAlert + 1
//        
//        self.window?.layer.masksToBounds = true
//        
//        self.window?.layer.cornerRadius = 30.0
//        
//        self.window?.backgroundColor = UIColor.customColor()
        
        
        
        self.recordButton = UIButton(frame: CGRectMake(0,0,60,60))
        
        recordButton!.setTitle("start", forState: UIControlState.Normal)
        
        recordButton!.setTitleColor(UIColor.customWhite(), forState: UIControlState.Normal)
        
        recordButton?.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        
        recordButton!.backgroundColor = UIColor.customColor()
        
        recordButton!.addTarget(self, action: #selector(MUNavigationController.handlerRecordButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        customWindow.shareInstance.addSubview(recordButton!)
        
        customWindow.shareInstance.makeKeyAndVisible()
        
        //customWindow.shareInstance
        
        //self.window?.addSubview(recordButton!)
        
        customWindow.shareInstance.hidden = true
        
    }
    func handlerRecordButton(button : UIButton) {
        
        if !self.isRecord {
            
            self.startRecord()
            
            button.setTitle("Stop", forState: UIControlState.Normal)
            
            self.isRecord = true
            
        }else{
            
            button.setTitle("start", forState: UIControlState.Normal)
            
            self.isRecord = false
            
            self.stopRecord()
        }

        
    }
    
    private func startRecord() {
        
        if RPScreenRecorder.sharedRecorder().available {
            
            RPScreenRecorder.sharedRecorder().startRecordingWithMicrophoneEnabled(true, handler: { (error) in
                
                if (error != nil) {
                    
                    print("==============\(error)")
                    
                }else{
                    
                    self.showTips("start record")
                    
                    let date = NSDate()
                    
                    let format = NSDateFormatter()
                    
                    format.dateFormat = "HH:mm:ss"
                    
                    let formatDate = format.stringFromDate(date)
                    
                    self.title = formatDate
                    
                }
                
            })
        }
    }
    
    private func stopRecord() {
        
        RPScreenRecorder.sharedRecorder().stopRecordingWithHandler { (previewController, error) in
            
            if (error != nil) {
                
                print("==============\(error)")
                
            }else{
                
                self.showTips("recording is completed.")
                
                previewController?.previewControllerDelegate = self
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    previewController?.view.frame = UIScreen.mainScreen().bounds
                    
                    self.showPreViewController(previewController!)
                })
                
                //self.pushViewController(previewController!, animated: true)
                //self.showPreViewController(previewController!)
                //self.presentViewController(previewController!, animated: true, completion: nil)
            }
        }
    }

    private func showTips(text:String){
        
        
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        hub.mode = MBProgressHUDMode.Text
        
        // hub.frame = CGRectMake(tipsX, tipsY, 200, 200)
        
        hub.label.text = text
        
        hub.label.font = UIFont.systemFontOfSize(12.0)
        
        hub.label.numberOfLines = 0
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            
            sleep(1)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                hub.hideAnimated(true)
                
                self.navigationController?.navigationBarHidden = false
                
            })
        })
        
    }

    //This is a class method,it will be used only once when the controller was init.
    override class func initialize(){
    
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigation-background"), forBarMetrics: UIBarMetrics.Default)
       // self.addChildViewController(UINavigationController(rootViewController: ViewController()) as! MUNavigationController)
         //let Controller = ViewController()
        //MUNavigationController(rootViewController: Controller)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
       return UIStatusBarStyle.LightContent
    }
    
    
    
    private func isSystemVersionOk() -> Bool{
        
        let systemVersion = UIDevice.currentDevice().systemVersion as NSString
        
        if systemVersion.floatValue >= 9.0 {
            
            return true
        }else{
            
            return false
        }
    }
    
    private func alertView(text:String) {
        
        let alertViewController = UIAlertController(title: "Tips", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let tureAction = UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
            
            //self.navigationController?.popViewControllerAnimated(true)
        }
        
        alertViewController.addAction(tureAction)
        
        let dismissAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Destructive) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertViewController.addAction(dismissAction)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }


    //#MARK Recording completion callback
    func previewControllerDidFinish(previewController: RPPreviewViewController) {
        
        //previewController.dismissViewControllerAnimated(true, completion: nil)
        
        //if you are not using GCD,it will give you some warning.
        //#warning Refresh UI, it must be placed in the main thread execution
        dispatch_async(dispatch_get_main_queue()) { 
            
             self.hidePreViewController(previewController)
            
        }
       
        //self.popViewControllerAnimated(true)
    }
    
    //Click the Share button
    
    func previewController(previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        
        
        if activityTypes.contains("com.apple.UIKit.activity.SaveToCameraRoll") {
            
            self.alertView("Successfully saved to the photo album.")
            
        }else if activityTypes.contains("com.apple.UIKit.activity.CopyToPasteboard"){
            
            self.alertView("It has been copied to the clipboard.")
        }
    }

    func hidePreViewController(preViewController : RPPreviewViewController)  {
        
        preViewController.view.removeFromSuperview()
        
        preViewController.removeFromParentViewController()
        
        self.navigationController?.navigationBarHidden = false
    }
    
    func showPreViewController(preViewController : RPPreviewViewController) {
        
        preViewController.view.frame = UIScreen.mainScreen().bounds
        
        self.view.addSubview(preViewController.view)
        
        self.addChildViewController(preViewController)
        
        self.navigationController?.navigationBarHidden = true
        
    }
}
