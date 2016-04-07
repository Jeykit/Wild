//
//  MURegisteredViewController.swift
//  Wild
//
//  Created by Adaman on 3/23/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

import QuartzCore

import AVFoundation

import AudioToolbox

import MessageUI

import MapKit

import CoreLocation

class MURegisteredViewController: UIViewController,MFMailComposeViewControllerDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,SKPSMTPMessageDelegate,CLLocationManagerDelegate,MKMapViewDelegate {

    private var titleLabel:UILabel?
    
    private var passwordTextFiled:MUTextField?
    
    private var usernameTextFiled:MUTextField?
    
    private var leftImageView:UIImageView?
    
    private var rightImageView:UIImageView?
    
    private var topView:UIView?
    
    private var tipLabel:UILabel?
    
    private var loginButton:MUButton?
    
    private var height : CGFloat?
    
    private var bottomView:MUButton?
    
    private var SubViewContraint:UIView?
    
    private var path:String?
    
    private var textInput:String?
    
    private var currentCoordinate:CLLocationCoordinate2D?
    
    private var location:String? = ""
    
    private let locationManager = CLLocationManager()
    
    private var is_get_location:Bool = true
    
    private var hud:MBProgressHUD?
    
    private var MapView:MKMapView?
    
    var  userName:String?
    
    var  emailText:String?
    
    var userButton:UIButton?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.customGrayColor()
    
        self.height = self.view.frame.size.height
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
         self.customSubView()
        
        self.locationManager.delegate = self
        // Do any additional setup after loading the view.
        
        self.MapView = MKMapView(frame: self.view.frame)
        
        self.MapView?.mapType = MKMapType.Standard
        
        self.MapView?.userTrackingMode = MKUserTrackingMode.Follow
        
        self.MapView?.showsUserLocation = true
        
        self.MapView?.hidden = true
        
        self.MapView?.delegate = self
        
        self.view.addSubview(self.MapView!)
        
        let currentLocationSapn = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let center = CLLocationCoordinate2D(latitude: 32.029171, longitude: 118.788231)
        
        self.MapView?.setCenterCoordinate(center, animated: true)
        
        let currentRegion = MKCoordinateRegion(center: center, span: currentLocationSapn)
        
        self.MapView?.setRegion(currentRegion, animated: true)
        
       // self.getLocationInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        print("====================\(userLocation.title)")
        
    }
    
  
       
   private func customSubView() {
        
        //self.topView = UIView(frame: CGRectMake(0,0,self.view.frame.width,64.0))
        
        //self.customSubTopView(self.view)
        
        //self.view!.addSubview(self.topView!)
    
    
       //let headerImage = UIImage(named: "title")
    
       self.titleLabel = UILabel()
    
       self.titleLabel?.text = "Wild"
    
       self.titleLabel?.textColor = UIColor.customColor()
    
       self.titleLabel?.textAlignment = NSTextAlignment.Center
    
       self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
    
       self.titleLabel?.font = UIFont.systemFontOfSize(20.0)
    
       let centerX = (self.view.frame.width - 60)/2.0
    
       self.titleLabel?.frame = CGRectMake(centerX, 72.0, 60,40)
    
       self.view.addSubview(self.titleLabel!)
    
    
    let centerXconstraint = NSLayoutConstraint(item: self.titleLabel!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
    
    self.view.addConstraint(centerXconstraint)
    
    let centerYconstraint = NSLayoutConstraint(item: self.titleLabel!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 108.0)
    
    self.view.addConstraint(centerYconstraint)
    
//       let button = UIButton(frame:CGRectMake(0,0,30,30))
//    
//       button.setTitle("button", forState: UIControlState.Normal)
//    
//       button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//    
//       button.titleLabel?.font = UIFont.systemFontOfSize(12.0)
//    
//       button.translatesAutoresizingMaskIntoConstraints = false
//    
//       button.addTarget(self, action: #selector(MURegisteredViewController.handlerBackButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//    
//       self.view.addSubview(button)
    
    
    
         leftImageView = UIImageView(image: UIImage(named: "email"))
    
         leftImageView?.translatesAutoresizingMaskIntoConstraints = false
    
         //self.view.addSubview(self.leftImageView!)
    
         rightImageView = UIImageView(image: UIImage(named: "password-icon"))
    
          rightImageView?.translatesAutoresizingMaskIntoConstraints = false
    
          // self.view.addSubview(self.rightImageView!)
    
    
        self.usernameTextFiled = MUTextField()
        
        self.usernameTextFiled?.placeholder = "Email"
    
        //self.usernameTextFiled!.image =  UIImage(named: "email")
    
        self.usernameTextFiled?.leftViewMode = UITextFieldViewMode.Always
    
        self.usernameTextFiled?.leftView = self.leftImageView
        
        self.usernameTextFiled?.clearsOnBeginEditing = true
        
        self.usernameTextFiled?.clearButtonMode = UITextFieldViewMode.Always
        
        self.usernameTextFiled?.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        self.usernameTextFiled?.textAlignment = NSTextAlignment.Left
        
        self.usernameTextFiled?.becomeFirstResponder()
        
        self.usernameTextFiled!.translatesAutoresizingMaskIntoConstraints = false
        
        self.usernameTextFiled?.font = UIFont.systemFontOfSize(12.0)
        
        //usernameTextFiled!.backgroundColor = UIColor.blueColor()
        
        self.view!.addSubview(usernameTextFiled!)
    
    
        
        self.passwordTextFiled = MUTextField()
        
        self.passwordTextFiled?.placeholder = "Password"
    
        self.passwordTextFiled?.leftViewMode = UITextFieldViewMode.Always
    
        self.passwordTextFiled?.leftView = self.rightImageView
    
        //self.passwordTextFiled?.image = UIImage(named: "password-icon")
    
        self.passwordTextFiled?.clearsOnBeginEditing = true
        
        self.passwordTextFiled?.clearButtonMode = UITextFieldViewMode.Always
        
        self.passwordTextFiled?.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        self.passwordTextFiled?.textAlignment = NSTextAlignment.Left
        
        self.passwordTextFiled?.font = UIFont.systemFontOfSize(12.0)
        
        self.passwordTextFiled?.resignFirstResponder()
        
        self.passwordTextFiled?.translatesAutoresizingMaskIntoConstraints = false
        
        self.passwordTextFiled?.secureTextEntry = true
        
        //self.passwordTextFiled?.backgroundColor = UIColor.cyanColor()
        
        self.view!.addSubview(self.passwordTextFiled!)
        

        
        self.tipLabel = UILabel()
        
        self.tipLabel?.text = "Forgot your password? Find it"
        
        self.tipLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        self.tipLabel?.font = UIFont.systemFontOfSize(12.0)
        
        self.tipLabel?.userInteractionEnabled = true
        
        self.tipLabel?.textColor = UIColor.blackColor()
            
            //UIColor(hue: 343.0, saturation: 87, brightness: 99.0, alpha: 1.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MURegisteredViewController.handlerTipLabelByTap(_:)))
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        tap.delegate = self
        
        self.tipLabel?.addGestureRecognizer(tap)
        
        self.view!.addSubview(self.tipLabel!)
    
        let attributeString = NSMutableAttributedString(string: (self.tipLabel?.text)!)
    
        let range = ((self.tipLabel?.text)! as NSString).rangeOfString("Find it")
    
        attributeString.addAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12.0),NSForegroundColorAttributeName : UIColor.customColor()], range: range)
    
       attributeString.addAttributes([NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue,NSUnderlineColorAttributeName : UIColor.customColor()],range: range)
    
         self.tipLabel?.attributedText = attributeString
        
        self.loginButton = MUButton()
        
        self.loginButton?.translatesAutoresizingMaskIntoConstraints = false
        
        self.loginButton?.setTitle("Sign in/Sign up", forState: UIControlState.Normal)
        
        self.loginButton?.titleLabel?.textAlignment = NSTextAlignment.Center
        
        self.loginButton?.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        self.loginButton?.setImage(UIImage(named: "loggin-button"), forState: UIControlState.Normal)
        
        self.loginButton?.addTarget(self, action: #selector(MURegisteredViewController.handlerLoginButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view!.addSubview(self.loginButton!)
    
        self.customSubViewConstraint()
    }
    
    func handlerTipLabelByTap(tap : UITapGestureRecognizer) {
        
        let pass = "qw654321"
        
         let mContraoller = SKPSMTPMessage()
        
        
        if MFMailComposeViewController.canSendMail() {
            
            if self.detectePassword() {
                
                let modal = MUSQLiteUserListTool.querryDataInDatabase(self.usernameTextFiled!.text!)
                
                let text = "Call and blessing from heaven. you are very surprised...your password is  " + modal.passwordText!

                mContraoller.subject = "Call and blessing from heaven..."
                
                mContraoller.toEmail = self.usernameTextFiled?.text
                
                mContraoller.fromEmail = "fashionwild@163.com"
                
                mContraoller.requiresAuth = true
                
                mContraoller.relayHost = "smtp.163.com"
                
                mContraoller.bccEmail = "jekity@outlook.com"
                
                mContraoller.ccEmail = "jekity@outlook.com"
                
                mContraoller.login = "fashionwild@163.com"
                
                mContraoller.pass  = pass
                
                mContraoller.wantsSecure = true
                
                mContraoller.delegate = self
                
                let message:NSString = text
                
                let cFString:NSString = NSString(CString: message.cStringUsingEncoding(NSUTF8StringEncoding), encoding: NSUTF8StringEncoding)!
                
                let plainMsg = NSDictionary(dictionary: [kSKPSMTPPartContentTypeKey : "text/plain", kSKPSMTPPartMessageKey : cFString,kSKPSMTPPartContentTransferEncodingKey : "8bit"])
                
                //add image attach
                let path = NSBundle.mainBundle().pathForResource("sweaters_white_portrait", ofType: "jpg")
                
                let myData = NSData(contentsOfFile: path!)
                
                let imageMsg = NSDictionary(dictionary: [kSKPSMTPPartContentTypeKey : "image/jpg;\r\n\tx-unix-mode=0644;\r\n\tfilename=\"fashionwild.jpg\"",kSKPSMTPPartContentDispositionKey : "attachment;\r\n\tfilename=\"fashionwild.jpg\"",kSKPSMTPPartMessageKey : (myData?.encodeBase64ForData())! as NSString,kSKPSMTPPartContentTransferEncodingKey : "base64"])
                
                //add video attach
                //            let videoPath = NSBundle.mainBundle().pathForResource("text", ofType: "mov")
                //
                //            let videoData = NSData(contentsOfFile: videoPath!)
                //
                //            let videoMSG = NSDictionary(dictionary: [kSKPSMTPPartContentTypeKey : "video/quicktime;\r\n\tx-unix-mode = 0644;\r\n\tname = 'text.mov'",kSKPSMTPPartContentDispositionKey : "attachment:\r\n\tfilename = 'fashionwild.mov'",kSKPSMTPPartMessageKey : (myData?.encodeBase64ForData())! as NSString,kSKPSMTPPartContentTransferEncodingKey : "base64"])
                
                let temparray = NSMutableArray()
                
                temparray.addObject(plainMsg)
                
                temparray.addObject(imageMsg)
                
                mContraoller.parts = temparray as [AnyObject]
                
                mContraoller.send()
                
//                let alertText = "Please,Check you Email."
//                
//                self.alertView(alertText)
                
            }
        
        }else{
            
            let alertText = "No network."
            
            self.alertView(alertText)
        }
        
        

        
    }
    
    private func detectePassword() ->Bool {
       
        
        var flag:Bool = false
        
        var alertText = ""
        
        if self.usernameTextFiled?.text != nil {
            
            let emailText = (self.usernameTextFiled?.text)! as NSString
            
            if emailText.length >= 8 && emailText.length <= 18 {
                
                if self.validateEmail((self.usernameTextFiled?.text)!) {
                    
                    let modal = MUSQLiteUserListTool.querryDataInDatabase(self.usernameTextFiled!.text!)
                    
                    if modal.emailText != nil {
                        
                       flag = true
                        
                    }else{
                        
                        alertText = "This mailbox is not registered!"
                        
                        self.alertView(alertText)
                    }
                }else{
                    
                    alertText = "Please enter a valid email."
                    
                    self.alertView(alertText)
                    
                }
                
            }else{
                
                alertText = "Please enter a valid email."
                
                self.alertView(alertText)
            }
        }else{
            
            alertText = "Please enter a valid email."
            
            self.alertView(alertText)
        }

    return flag
   }
    
    //MARK SKPSMTPMessageDelegate
    func messageSent(message: SKPSMTPMessage!) {
        
       // print("=======================email is send!")
 
        let alertText = "Please,Check you Email."
        
        self.alertView(alertText)
        
        self.usernameTextFiled?.resignFirstResponder()
        
        self.passwordTextFiled?.resignFirstResponder()
        

    }
    
    func messageFailed(message: SKPSMTPMessage!, error: NSError!) {
        
        print("====================\(error)")
    }
    
   /* func defalutSendEmail()  {
     
         let mailController = MFMailComposeViewController()
     
        mailController.mailComposeDelegate = self
        
        //setting title to mail
        mailController.setSubject("This is come from FashionWild.net which used retrieve your password!")
        
        //setting address
        mailController.setToRecipients(["1332543935@qq.com"])
        
        //setting sender people
        //mailController.setCcRecipients(["392071745@qq.come"])
        
        //setting BccRecipients
        // mailController.setBccRecipients(["392071745@qq.com"])
        
        //attach a piture
        let path = NSBundle.mainBundle().pathForResource("sweaters_white_portrait", ofType: "jpg")
        //UIImage.getImageFromStr(<#T##str: String##String#>)
        let myData = NSData(contentsOfFile: path!)
        
        mailController.addAttachmentData(myData!, mimeType: "image/png", fileName: "me.png")
        
        //setting the message body
        mailController.setMessageBody("Happy to see you !Awesome!!!", isHTML: false)
        
        self.presentViewController(mailController, animated: true, completion: nil)

        
    }
    
    //MARK MailDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultSent.rawValue:
            
            print("==============mail is sended!")
            
        case MFMailComposeResultCancelled.rawValue:
            
             print("==============mail is cancelld!")
            
        case MFMailComposeResultSaved.rawValue:
            
             print("==============mail is saved!")
            
        case MFMailComposeResultFailed.rawValue:
            
             print("==============mail is failed!")
        default:
             print("==============sorry to you.The mailcan no be send!")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }*/
    func customSubViewConstraint() {
        
        let spaceX = self.preferredContentSize.height * 0.38 - 64
        
        let width  = self.preferredContentSize.width * 0.62 - 34.0
        
        let hSpace = (self.preferredContentSize.width - width)/2
        
        //print("==================\(spaceX)")
        
        let hPasswordConstraintVFL = "H:|-hSpace-[passwordTextFiled(==width)]-hSpace-|"
        
        let hPasswordConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hPasswordConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: ["width" : width,"hSpace" : hSpace], views: ["rightImageView" : rightImageView!,"passwordTextFiled" : self.passwordTextFiled!])
        
        self.view!.addConstraints(hPasswordConstraint)
        
        
        let vPasswordConstraintVFL = "V:|-spaceX-[usernameTextFiled(==64)]-12-[passwordTextFiled(==64)]"
        
        let vPasswordConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vPasswordConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["spaceX" : spaceX], views: ["passwordTextFiled" : self.passwordTextFiled!,"usernameTextFiled" : self.usernameTextFiled!])
        
        self.view!.addConstraints(vPasswordConstraint)
        
        
        let hUsernameConstraintVFL = "H:|-hSpace-[usernameTextFiled(==width)]-hSpace-|"
        
        let hUsernamrConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hUsernameConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: ["width" : width,"hSpace" : hSpace], views: ["usernameTextFiled" : self.usernameTextFiled!,"leftImageView" : leftImageView!])
        
        self.view!.addConstraints(hUsernamrConstraint)
        
        let vTipLabelConstraintVFL = "V:[passwordTextFiled]-12-[tipLabel]-18-[loginButton]"
        
        let vTipLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vTipLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["passwordTextFiled" : self.passwordTextFiled!,"tipLabel" : self.tipLabel!,"loginButton" : self.loginButton!])
        
        
        self.view!.addConstraints(vTipLabelConstraint)
        
        
        let hLoginButtonConstraintVFL = "H:|-hSpace-[loginButton(==width)]-hSpace-|"
        
        let hLoginButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hLoginButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["width" : width,"hSpace" : hSpace], views: ["loginButton" : self.loginButton!])
        
        self.view!.addConstraints(hLoginButtonConstraint)
        


        
        
    }

    func customSubTopView(sView : UIView) {
        
        let button = UIButton(frame:CGRectMake(0,0,30,30))
        
        button.setTitle("button", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(MURegisteredViewController.handlerBackButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        sView.addSubview(button)
        
        let hButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        sView.addConstraint(hButtonConstraint)
        
        let vButtonConstraintVFL = "V:|-12-[button]-12-|"
        
        let vButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["button" : button])
        
        sView.addConstraints(vButtonConstraint)
        
        
        
    }
    
    func handlerBackButton(button : UIButton) {
        
        self.usernameTextFiled?.resignFirstResponder()
        
        self.passwordTextFiled?.resignFirstResponder()
        
        //self.maskView?.removeFromSuperview()
        
        self.view.removeFromSuperview()
        
    }
    func handlerVoicePrint(button : MUButton)  {
        
        self.bottomView?.removeFromSuperview()
        
        self.tipLabel?.removeFromSuperview()
        
        self.loginButton?.removeFromSuperview()
        
        self.topView?.removeFromSuperview()
        
        self.usernameTextFiled?.removeFromSuperview()
        
        self.passwordTextFiled?.removeFromSuperview()
       // self.SubViewContraint?.removeFromSuperview()
        
        let alertViewController = UIAlertController(title: "Speech synthesis", message: "Enter your voice!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertViewController.modalInPopover = true
        
        let pop = alertViewController.popoverPresentationController
        
        pop?.sourceView = self.view
        
        pop?.sourceRect = self.view.frame
        
        pop?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        alertViewController.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            
            textField.textAlignment = NSTextAlignment.Center
            
            textField.font = UIFont.systemFontOfSize(12.0)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MURegisteredViewController.handlerTextDidChange(_:)), name: UITextFieldTextDidChangeNotification, object: textField)
            
        }
        
        let actionYes = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (action) in
            
            if self.textInput != nil {
                
                                self.customSubView()
            }
           

        }
        alertViewController.addAction(actionYes)
        
        
        let actionDestructive = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Destructive) { (action) in
            
            self.textInput = ""
    
            alertViewController.dismissViewControllerAnimated(true, completion: { 
                
                  self.customSubView()
            })
        }
        
        alertViewController.addAction(actionDestructive)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
        
    }

    private func getLocationInfo() {
        
       
        
        //locationManager.delegate = self
        
        //setting positioning accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //updating distance
        locationManager.distanceFilter = 100.0
        
        
        //send an authorization request
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            
            if locationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
                
                locationManager.requestWhenInUseAuthorization()
                
                print("start location")
            }
            
            if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 9.0 {
                
                locationManager.allowsBackgroundLocationUpdates = true
            }
            
            locationManager.startUpdatingHeading()

            locationManager.startUpdatingLocation()
            
            //dispatch_async(dispatch_get_main_queue(), {
                
           // self.locationManager.requestLocation()
                
            self.is_get_location = false
            
            //self.locationManager.stopUpdatingLocation()
                
           // })
            
            
            
            

        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
         manager.stopUpdatingLocation()
        
        if !self.is_get_location {
            
            if let currLocation:CLLocation = locations.last {
                
                
                // print("================\(self.location)")
                
                CLGeocoder().reverseGeocodeLocation(currLocation) { (placeMark, error) in
                    
                    //let currentCoordinate:CLLocationCoordinate2D?
                    
                    if let newCurrentCoordinate = placeMark?.last?.location?.coordinate{
                        
                        //print("================\(self.location)")
                        
                        // print("================\(self.location)")
                        //record latiude and longitude
                        self.currentCoordinate = newCurrentCoordinate
                        
                        let place:CLPlacemark = (placeMark?.last)!
                        
                        //get location
                        //let location = place.location
                        
                        //get region
                        //let region = place.region
                        
                        //address information for dictionary
                        //let dict = place.addressDictionary
                        
                        //place name
                        //let name = place.name
                        
                        //self.location = self.location! + name!
                        
                        //stree/throughfare
                        let stree = place.thoroughfare
                        
                        self.location = self.location! + stree! + " "
                        
                        //city
                       
                        if  let city = place.locality {
                            
                            self.location = self.location! + city + " "
                        }
                        
                        
                        //
                        let area = place.administrativeArea
                        self.location = self.location! + area! + " "
                        
                        //county
                        let county = place.country
                        self.location = self.location! + county!
                        
                        
                        
                        NSUserDefaults.standardUserDefaults().setObject(self.location, forKey: "adress")
                        
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        self.alertView(self.location!)
                        //get user address
                        //let modal =  MUSQLiteUserListTool.querryDataInDatabase(self.usernameTextFiled!.text!)
                        
                        //update location
                        
                       // MUSQLiteUserListTool.updateDataToDatabase("adressText", upDataWithEmailAndData: [self.location!,(self.usernameTextFiled?.text)!])
                        
                        
                    }else{
                        
                        print("================\(error)")
                    }
                }

            }
            
            
        }
        
        
    
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("===================\(error)")
    }
    
    func handlerTextDidChange(notification : NSNotification) {
        
       let textfield = notification.object as! UITextField
        
        self.textInput = textfield.text
    }
    
    func addSubViewToVoicePrint(sView : UIView) {
        
        let trainButton = MUButton()
        
        trainButton.setImage(UIImage(named: "Button-of-buy_iPad_defalut_44"), forState: UIControlState.Normal)
        
        trainButton.setTitle("Train", forState: UIControlState.Normal)
        
        trainButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        trainButton.translatesAutoresizingMaskIntoConstraints = false
        
        trainButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        
        //trainButton.addTarget(self, action: #selector(MURegisteredViewController.startSynthesies), forControlEvents: UIControlEvents.TouchUpInside)
        
        sView.addSubview(trainButton)
        
//        let verfyButton = UIButton()
//        
//        verfyButton.setTitle("Verfy", forState: UIControlState.Normal)
//        
//        verfyButton.setImage(UIImage(named: "Button-of-buy_iPad_defalut_44"), forState: UIControlState.Normal)
//        
//        verfyButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
//        
//        verfyButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        verfyButton.titleLabel?.textAlignment = NSTextAlignment.Center
//        
//        //verfyButton.addTarget(self, action: #selector(MURegisteredViewController.verifyModal(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        
//        sView.addSubview(verfyButton)
//        
//        let querryButton = MUButton()
//        
//        querryButton.setTitle("query", forState: UIControlState.Normal)
//        
//        querryButton.setImage(UIImage(named: "Button-of-buy_iPad_defalut_44"), forState: UIControlState.Normal)
//        
//        querryButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
//        
//        querryButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        querryButton.titleLabel?.textAlignment = NSTextAlignment.Center
//        
       // querryButton.addTarget(self, action: #selector(MURegisteredViewController.queryModal), forControlEvents: UIControlEvents.TouchUpInside)
//        
//        sView.addSubview(querryButton)
//        
//        let hQueryConstraint = NSLayoutConstraint(item: querryButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
//        
//        sView.addConstraint(hQueryConstraint)
//        
//        let stopButton = MUButton()
//        
//        stopButton.setTitle("Stop", forState: UIControlState.Normal)
//        
//        stopButton.setImage(UIImage(named: "Button-of-buy_iPad_defalut_44"), forState: UIControlState.Normal)
//        
//        stopButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
//        
//        stopButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        stopButton.titleLabel?.textAlignment = NSTextAlignment.Center
//        
//        stopButton.frame = CGRectMake(100, 0, 100, 44)
        
        //stopButton.addTarget(self, action: #selector(MURegisteredViewController.stopRecord), forControlEvents: UIControlEvents.TouchUpInside)
        
//        sView.addSubview(stopButton)
//        
//        let hStopConstraint = NSLayoutConstraint(item: stopButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
//        
//        sView.addConstraint(hStopConstraint)
//        
//
//        
//        let hButtonConstraintVFL = "H:|-12-[trainButton]-12-[verfyButton]-12-|"
//        
//        let hButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: nil, views: ["trainButton" : trainButton,"verfyButton" : verfyButton])
//        
//        sView.addConstraints(hButtonConstraint)
//        
//        //let vButtonConstraintVFL = "V:|-12-[trainButton]-12-[verfyButton]-12-|"
//        
//        let vButtonConstraint = NSLayoutConstraint(item: trainButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: sView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
//        
//        sView.addConstraint(vButtonConstraint)

        

    }
    
        
    func handlerLoginButton(button : UIButton) {
        
       // MUSQLiteUserListTool.createDataBase()
        
        let tempModal = MUUserListModal()
        
        let tempArray = NSMutableArray()

        var alertText = ""
         
        if ((self.usernameTextFiled?.text) != nil) {
            
            let emailText = (self.usernameTextFiled?.text)! as NSString
            
            if emailText.length >= 8 && emailText.length <= 18 {
                
               let result = self.validateEmail(emailText as String)
                
                if result {
                    
                    //alertText = "Registration success!"
                     //self.alertView(alertText)
                    
                    //add email
                    tempModal.emailText = emailText as String
                    
                    tempArray.addObject(tempModal.emailText!)
                    
                    if self.passwordTextFiled?.text != nil {
                        
                        let passwordText = (self.passwordTextFiled?.text)! as NSString
                        
                        if passwordText.length >= 6 && passwordText.length <= 18 {
                            
                            if self.validateCharaters((self.passwordTextFiled?.text)!) {
                                
                                //add ,password,username,hImage,bImage,adressText
                                tempModal.passwordText = self.passwordTextFiled?.text
                                
                                tempArray.addObject(tempModal.passwordText!)
                                
                                tempArray.addObject(tempModal.userNameText)
                                
                                tempArray.addObject(tempModal.headerImageText)
                                
                                tempArray.addObject(tempModal.backgroundImageText)
                                
                                tempArray.addObject(tempModal.addressText)
                                
                                MUSQLiteUserListTool.createDataBase()
                                
                                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                                
                                hud.mode = MBProgressHUDMode.Text
                                
                                //detect user if exist
                                let modal = MUSQLiteUserListTool.querryDataInDatabase(tempModal.emailText!)
                                
                                if modal.emailText != nil {
                                  
                                     alertText = "Welcome back!"
                                    
                                    self.usernameTextFiled?.resignFirstResponder()
                                    
                                    self.passwordTextFiled?.resignFirstResponder()
                                    
                                }else{
                                  
                                    MUSQLiteUserListTool.writeDataToDatabase(tempArray)
                                    
                                    alertText = "Registration success!"
                                    
                                    MUCleareCacheTool.CleareCache()
                                    
                                    self.usernameTextFiled?.resignFirstResponder()
                                    
                                    self.passwordTextFiled?.resignFirstResponder()
                                }
                                
                                //userButton!.setImage(UIImage(named: "user-loggedin")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
                                
                                self.userName = modal.userNameText
                                
                                self.emailText = self.usernameTextFiled?.text
                                
                                hud.label.text = alertText
                              
                                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                                    
                                    sleep(2)
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        hud.hideAnimated(true)
                                        
                                        
                                        NSUserDefaults.standardUserDefaults().setObject(self.userName, forKey: "username")
                                        
                                        NSUserDefaults.standardUserDefaults().setObject(self.emailText, forKey: "email")
                                        
                                        MUButtonBdageTool.initButtonBadgeValues(0)
                                        
                                        NSUserDefaults.standardUserDefaults().synchronize()
                                        
                                       
                                    })
                                })

                                self.dismissViewControllerAnimated(false, completion: nil)
                                
                                //self.alertView(alertText)
                            }else{
                                
                                alertText = "It contains illegal characters!"
                                
                                self.alertView(alertText)
                            }
                            
                        }else{
                            
                            alertText = "Sorry,The length of Password does not match!"
                            
                            self.alertView(alertText)
                        }
                    }else{
                        
                        alertText = "Sorry,Password can not be empty!"
                        
                        self.alertView(alertText)
                    }
                    
                    
                    
                   
                }else{
                    
                    alertText = "Sorry,Email formater is incorrect"
                    
                    self.alertView(alertText)
                }
                
            }else{
                
                alertText = "Sorry , The length of Email formater is incorrect!"
                
                self.alertView(alertText)
            }
        }else{
            
            alertText = "Sorry,Email can not be empty!"
            
            self.alertView(alertText)
        }
        
        
        
    }
    
    private func validateCharaters(password : String) -> Bool{
        
        
        let regex = "^[a-zA-Z0-9]{6,18}$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluateWithObject(password)
    }
    
    private func validateEmail(email:String) -> Bool{
        
            var result:Bool = false
        
        do{
            
            let emailRegex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: NSRegularExpressionOptions.CaseInsensitive)
            
          let emailResult = emailRegex.firstMatchInString(email, options: [], range: NSMakeRange(0, email.characters.count))
            
            if emailResult != nil {
                
                result = true
            }else{
                
                result = false
            }
            
        }catch let error as NSError {
            
            print("=========================\(error)")
        }
        
        return result
    }
    
    private func alertView(text:String) {
        
        let alertViewController = UIAlertController(title: "Tips", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let tureAction = UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
            
            //self.usernameTextFiled?.resignFirstResponder()
            
            //self.passwordTextFiled?.resignFirstResponder()
            
             alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertViewController.addAction(tureAction)
        
        let dismissAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Destructive) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
            
           // self.usernameTextFiled?.resignFirstResponder()
            
           // self.passwordTextFiled?.resignFirstResponder()
            
             alertViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertViewController.addAction(dismissAction)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }
    /* func stopRecord() {
        
        isvRet.stopListening()
    }
    
    func queryModal() {
        
       
        
        isvRet.delegate = self
        
        var error:Int32? = -1
        
        isvRet.sendRequest("query", authid: "Jekity", pwdt: 2, ptxt: nil, vid: nil, err: &error!)
        print("error==================\(error)")

    }
    
    func trainModal(button : MUButton) {
        
       // let isvRet = IFlyISVRecognizer.sharedInstance()
        //isvRet.cancel()
        //isvRet.delegate = self
        
        self.tempArray = self.isvRet.getPasswordList(Int32(1)) as NSArray
        
        var str = ""
        
        for element in self.tempArray {
            
            let char = element as! String
            
            str = str + char
        }
        
        button.setTitle(str, forState: UIControlState.Normal)
        
        self.codeMix = "train"
        
        isvRet.setParameter("ivp", forKey: "sub")
        
        isvRet.setParameter("50", forKey: "tsd")
        
        isvRet.setParameter("18000", forKey: "key_speech_timeout")
        
        isvRet.setParameter("1", forKey: "rgn")
        
        //set the password by set the parameter type,1 2 3 respectively text password ,  freedoms and digital password
        isvRet.setParameter("2", forKey: "pwdt")
        
        //set the service type of "train"
        isvRet.setParameter(self.codeMix, forKey: "sst")
        
        //set password type
       isvRet.setParameter("2", forKey: "pwdt")
        
        //freedom skip this step
        //isvRet.setParameter("1", forKey: "ptxt")
        
        //set userId
        isvRet.setParameter("Jekity", forKey: "auth_id")
        
        //settinr limited recording time
        isvRet.setParameter("3000", forKey: "vad_timeout")
        
        //end tone dection time
        isvRet.setParameter("700", forKey: "vad_speech_tail")
        
        isvRet.startListening()

        
    }
    
    func verifyModal(button : MUButton) {
        
        
        //isvRet.cancel()
        //let isvRetverify = IFlyISVRecognizer.sharedInstance()
        
        self.tempArray = self.isvRet.getPasswordList(Int32(1))
        
        var str = ""
        
        for element in self.tempArray {
            
            let char = element as! String
            
            str = str + char
        }
        
        button.setTitle(str, forState: UIControlState.Normal)
        
        self.codeMix = "verify"
        
        isvRet.setParameter("ivp", forKey: "sub")
        
        isvRet.setParameter("50", forKey: "tsd")
        
        isvRet.setParameter("18000", forKey: "key_speech_timeout")
        
        isvRet.setParameter("1", forKey: "rgn")
        
        //set the password by set the parameter type,1 2 3 respectively text password , digital password and freedoms
        isvRet.setParameter("2", forKey: "pwdt")
        
        //set the service type of "train"
        isvRet.setParameter(self.codeMix, forKey: "sst")
        
        //set password type
        isvRet.setParameter("2", forKey: "pwdt")
        
        //freedom skip this step
        //isvRet.setParameter("1", forKey: "ptxt")
        
        //set userId
        isvRet.setParameter("Jekity", forKey: "auth_id")
        
        //settinr limited recording time
        isvRet.setParameter("3000", forKey: "vad_timeout")
        
        //end tone dection time
        isvRet.setParameter("700", forKey: "vad_speech_tail")
        
        isvRet.startListening()

        
    }
    
    func onResult(dic: [NSObject : AnyObject]!) {
        
        print("=================\(dic)")
    }
    
    func onError(errorCode: IFlySpeechError!) {
        
        //print("================\(errorCode.errorDesc) ===\(errorCode.errorCode)")
    }
    
    func onRecognition() {
        
        print("====================processing")
    }
    
    func onVolumeChanged(volume: Int32) {
        
        print("======================\(volume)")
    }
    
    func buttonByClicked(button : UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
