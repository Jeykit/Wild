//
//  MUSynthesisViewController.swift
//  Wild
//
//  Created by Adaman on 3/30/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSynthesisViewController: UIViewController,IFlySpeechSynthesizerDelegate,UITextViewDelegate {

    private var textView:UITextView?
    
    private var synthesis : IFlySpeechSynthesizer?
    
    private var path:String?
    
    private var navigationView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.customBarButtonItem()
        
        self.customBackItem()
        
        self.title = "Synthesis"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(18.0),NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.textView = UITextView()
        
        self.textView?.becomeFirstResponder()
        
        self.textView?.frame = self.view.frame
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 30.0
        
        paragraphStyle.maximumLineHeight = 60.0
        
        paragraphStyle.firstLineHeadIndent = 12.0
        
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        let attribute = [NSFontAttributeName : UIFont.systemFontOfSize(12.0),NSParagraphStyleAttributeName : paragraphStyle]
        
        self.textView?.attributedText = NSMutableAttributedString(string: self.textView!.text, attributes: attribute)

        //UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UINavigationItem])
        
        self.view.addSubview(self.textView!)
        
        self.synthesis = IFlySpeechSynthesizer.sharedInstance() as? IFlySpeechSynthesizer
        
        self.synthesis!.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationView?.removeFromSuperview()
    }
    
    private func customBarButtonItem() {
        
        let rButton:MUButton = MUButton(frame: CGRectMake(0,0,45,30))
        
        rButton.setTitle("Voice", forState: UIControlState.Normal)
        
        rButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        rButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        rButton.addTarget(self, action: #selector(MUSynthesisViewController.handlerRightButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //rButton.setBackgroundImage(UIImage(named: "navigation_menu"), forState: UIControlState.Normal)
        
        let rightButton = UIBarButtonItem(customView: rButton)
        
        self.navigationItem.rightBarButtonItem = rightButton

    }
    
    private func customBackItem() {
        
        self.navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        let lButton:UIButton = UIButton()
        
        lButton.addTarget(self, action: #selector(MUSynthesisViewController.handlerBackItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        rButton.setTitle("Voice", forState: UIControlState.Normal)
        
        rButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        rButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        rButton.translatesAutoresizingMaskIntoConstraints = false
        
        rButton.addTarget(self, action: #selector(MUSynthesisViewController.handlerRightButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //rButton.setBackgroundImage(UIImage(named: "navigation_menu"), forState: UIControlState.Normal)
        
        self.navigationView?.addSubview(rButton)
        
        let rightButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: rButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Right, multiplier:1.0, constant: -12)
        
        let rightButtonConstraint_center = NSLayoutConstraint(item: rButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hRightButtonConstraint_center = NSLayoutConstraint(item: rButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 45.0)
        
        
        navigationView!.addConstraints([rightButtonConstraint_spaceOfLeft,rightButtonConstraint_center,hRightButtonConstraint_center])

        
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
    }
    
    func handlerBackItem(button : UIButton) {
        
        self.navigationView?.removeFromSuperview()
        
        self.navigationController?.popViewControllerAnimated(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlerRightButton(button :UIButton) {
        
        let voiceText = (self.textView?.text)! as NSString
        
        if voiceText.length > 0  {
            
            self.startSynthesies()
        }else{
            
            let alertText = "Sorry,The text can not be empty!"
            
            self.alertView(alertText)
        }
    }
    
    func startSynthesies() {
        
        //setting speed 1-100
        self.synthesis?.setParameter("50", forKey: IFlySpeechConstant.SPEED())
        
        //setting volume 1-100
        self.synthesis?.setParameter("50", forKey: IFlySpeechConstant.VOLUME())
        
        //setting pitch1-100
        self.synthesis?.setParameter("50", forKey:IFlySpeechConstant.PITCH())
        
        //setting sample_rate
        self.synthesis?.setParameter("16000", forKey: IFlySpeechConstant.SAMPLE_RATE())
        
        //setting voice_name
        self.synthesis?.setParameter("Catherine", forKey: IFlySpeechConstant.VOICE_NAME())
        
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        //let prePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        self.path = filePath.stringByAppendingPathComponent("tts.pcm")
        
        self.synthesis?.setParameter("tts.pcm", forKey: self.path)
        
        self.synthesis?.startSpeaking(self.textView?.text)
        
        
    }
    
    func onSpeakBegin() {
        
        //print("=========================good!")
    }
    
    func onBufferProgress(progress: Int32, message msg: String!) {
        
        //print("=========================\(progress)=====\(msg)")
    }
    
    func onSpeakProgress(progress: Int32) {
        
        //print("=========================\(progress)=====")
    }
    
    func onCompleted(error: IFlySpeechError!) {
        
        do{
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
        }catch let error as NSError {
            
            print("===================\(error)")
        }
        
        let audioPlayer = PcmPlayer(filePath: self.path, sampleRate: 16000)
        
        audioPlayer.play()
        
        
    }

    private func alertView(text:String) {
        
        let alertViewController = UIAlertController(title: "Tips", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let tureAction = UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertViewController.addAction(tureAction)
        
        let dismissAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Destructive) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertViewController.addAction(dismissAction)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }

    //#MARK UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        
           }

}
