//
//  MUReplayViewController.swift
//  Wild
//
//  Created by Adaman on 4/7/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

import ReplayKit

class MUReplayViewController: UIViewController,RPScreenRecorderDelegate,RPPreviewViewControllerDelegate {

    
    private var navigationView:UIView?
    
    private var isRecord:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.customWhite()
        
        if !self.isSystemVersionOk() {
            
            self.alertView("The current version does not support screen recording.")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
        
        self.customBackItem()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationView?.removeFromSuperview()
    }
    private func customBackItem() {
        
        self.navigationView = UIView(frame: CGRectMake(0,0,self.view.frame.width,44.0))
        
        self.navigationView?.backgroundColor = UIColor.customColor()
        
        let lButton:UIButton = UIButton()
        
        lButton.addTarget(self, action: #selector(MUReplayViewController.handlerBackItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView!.addSubview(lButton)
        
        let backButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant: 12)
        
        let backButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hbackButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        
        navigationView!.addConstraints([backButtonConstraint_spaceOfLeft,backButtonConstraint_center,hbackButtonConstraint_center])
        
        
        
        let rButton:UIButton = UIButton()
        
        rButton.setTitle("Start", forState: UIControlState.Normal)
        
        rButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        rButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        rButton.translatesAutoresizingMaskIntoConstraints = false
        
        rButton.addTarget(self, action: #selector(MUReplayViewController.handlerRightButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //rButton.setBackgroundImage(UIImage(named: "navigation_menu"), forState: UIControlState.Normal)
        
        self.navigationView?.addSubview(rButton)
        
        let rightButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: rButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Right, multiplier:1.0, constant: -12)
        
        let rightButtonConstraint_center = NSLayoutConstraint(item: rButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hRightButtonConstraint_center = NSLayoutConstraint(item: rButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 45.0)
        
        
        navigationView!.addConstraints([rightButtonConstraint_spaceOfLeft,rightButtonConstraint_center,hRightButtonConstraint_center])
        
        
        //self.navigationController?.navigationBar.addSubview(navigationView!)
        
        self.view.addSubview(self.navigationView!)
        
    }

    func handlerBackItem(button : UIButton){
        
       // self.navigationController?.popViewControllerAnimated(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func handlerRightButton(button : UIButton) {
        
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
   
                //self.showPreViewController(previewController!)
                //self.presentViewController(previewController!, animated: true, completion: nil)
            }
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
        
        self.hidePreViewController(previewController)
    }
    
    //Click the Share button
    
    func previewController(previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        
        
        if activityTypes.contains("com.apple.UIKit.activity.SaveToCameraRoll") {
            
            self.alertView("Successfully saved to the photo album.")
            
        }else if activityTypes.contains("com.apple.UIKit.activity.CopyToPasteboard"){
        
            self.alertView("It has been copied to the clipboard.")
        }
    }
}
