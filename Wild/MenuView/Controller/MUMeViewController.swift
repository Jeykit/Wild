//
//  MUMeViewController.swift
//  Wild
//
//  Created by Adaman on 2/16/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

import CoreLocation

import CoreGraphics

import MapKit

class MUMeViewController: UIViewController,MURectFromCellDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,MUShoppingCarViewCellDelegate,UIPopoverPresentationControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate{

    private let headView         = UIView()

    private var vHeight          = 0

    private var isLeft           = true

    private var mOrderViewController:MUOrderTableViewController?

    private let dividerImageView = UIImageView()

    private var mViewController:MUSettingTableViewController?

    private var pickViewControler:UIImagePickerController?

    var modalArray:NSMutableArray?

    private var tableView:UITableView?
    
    private var popoverViewController:UIPopoverPresentationController?
    
    private var is_header:Bool = true
    
    private var imageView_bg:UIImageView?
    
    private var headerImageView:UIImageView?
    
    private let locationManager = CLLocationManager()
    
    private var editButton:UIButton?
    
    private var is_get_location:Bool = true
    
    private var location:String? = ""
    
    private var MapView:MKMapView?
    
    private var addressLabel:UILabel?
    
    private var navigationView:UIView?
    
    private var tempButton:UIButton?
    
    private let orderButton = UIButton()
    
    private var sLayer = CAShapeLayer()
    
    private var isReturn:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title                                                   = "Me"

        

        vHeight                                                      = Int((UIScreen.mainScreen().bounds.size.height - 78.0)*0.62*0.38)

        self.view.backgroundColor                                    = UIColor.customWhite()

        self.pickViewControler                                       = UIImagePickerController()

        self.pickViewControler?.delegate                             = self

        self.pickViewControler?.allowsEditing                        = true
        
        
        self.customView()
        
        self.customBackItem()
        
        self.locationManager.delegate = self
        
        self.getLocationInfo()
        
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
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(18.0),NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.navigationItem.hidesBackButton = true
              
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            let emailText = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
            
            self.modalArray = MUSQLiteDataMeViewControllerTool.readOrderedDataFromDatabase(emailText)
            
        }else{
            
          self.modalArray = []
 
          self.showTips()
        }

        if (self.tempButton != nil) {
            
            self.drawTriangle(self.tempButton!)
        }
        
    }
    
//    override func viewDidDisappear(animated: Bool) {
//        
//        self.navigationView?.removeFromSuperview()
//    }
    
    private func getLocationInfo() {
        
        
        
        //locationManager.delegate = self
        
        //setting positioning accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //updating distance
        locationManager.distanceFilter = 10.0
        
        
        //send an authorization request
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            
            if locationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
                
                locationManager.requestWhenInUseAuthorization()
                
                //print("start location")
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
                
                
               self.location = " "
                
                CLGeocoder().reverseGeocodeLocation(currLocation) { (placeMark, error) in
                    
                    //let currentCoordinate:CLLocationCoordinate2D?
                    
                    if ((placeMark?.last?.location?.coordinate) != nil){
                        
                        //print("================\(self.location)")
                        
                        // print("================\(self.location)")
                        //record latiude and longitude
                        //self.currentCoordinate = newCurrentCoordinate
                        
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
                        if let stree = place.thoroughfare {
                            
                            self.location = self.location! + stree + " "
                        }
                        
                        //city
                        
                        if  let city = place.locality {
                            
                            self.location = self.location! + city + " "
                        }
                        
                        if let area = place.administrativeArea {
                           
                             self.location = self.location! + area + " "
                        }
                       
                        
                        //county
                        if let county = place.country {
                            
                             self.location = self.location! + county
                        }
                        
                        
                        NSUserDefaults.standardUserDefaults().setObject(self.location, forKey: "address")
                        
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        self.alertView(self.location!)
                        
                        self.addressLabel?.text = self.location
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
    

    private func customBackItem() {
        
        self.navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        let lButton:UIButton = UIButton()
        
        lButton.addTarget(self, action: #selector(MUMeViewController.handlerBackItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView!.addSubview(lButton)
        
        let backButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant: 12)
        
        let backButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hbackButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        
        navigationView!.addConstraints([backButtonConstraint_spaceOfLeft,backButtonConstraint_center,hbackButtonConstraint_center])

        
        self.editButton = UIButton()
        
        editButton!.addTarget(self, action: #selector(MUMeViewController.handlerEditButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        editButton!.setTitle("Edit", forState: UIControlState.Normal)
        
        editButton!.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        editButton!.setTitleColor(UIColor.customWhite(), forState: UIControlState.Normal)
        
        editButton!.setTitle("Edit", forState: UIControlState.Highlighted)
        
        editButton!.setTitleColor(UIColor.customWhite(), forState: UIControlState.Highlighted)
        
        editButton!.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        editButton!.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView!.addSubview(editButton!)
        
        let editButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: editButton!, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Right, multiplier:1.0, constant: -12)
        
        let editButtonConstraint_center = NSLayoutConstraint(item: editButton!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let heditButtonConstraint_center = NSLayoutConstraint(item: editButton!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        let veditButtonConstraint_center = NSLayoutConstraint(item: editButton!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 30.0)

         navigationView!.addConstraints([editButtonConstraint_spaceOfLeft,editButtonConstraint_center,heditButtonConstraint_center,veditButtonConstraint_center])
        
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
    }
    
    func handlerEditButton(button : MUButton) {
        
        
    }
    
    func handlerBackItem(button : UIButton) {
        
        self.navigationView?.removeFromSuperview()
        
        self.navigationController?.popViewControllerAnimated(true)
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
    
    private func showTips(){
        
        
        // UIActivityIndicatorView.appearance().backgroundColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        // UIProgressView.appearance().tintColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
        // UIProgressView.appearance().backgroundColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
        //let tipsX = (self.view.frame.width - 200)/2.0
        
        //let tipsY = (self.view.frame.height - 200)/2.0
    
        
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
         hub.mode = MBProgressHUDMode.Text
        
        // hub.frame = CGRectMake(tipsX, tipsY, 200, 200)
        
         hub.label.text = "You are not logged in!"
        
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

    
    override func viewWillDisappear(animated: Bool) {
        
        self.modalArray = nil
    }
    func customView(){
        
        //add headView to view
        self.headView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.headView)

        self.headView.backgroundColor = UIColor.customGrayColor()
        
        self.tableView = UITableView()
        
        self.tableView?.dataSource = self
        
        self.tableView?.delegate = self
        
        self.tableView?.registerClass(MUOrderedViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView!.backgroundColor = UIColor.customWhite()
        
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView!)
        
        self.customViewConstraint()
        
        self.subViewOfHeadView()
        
       
        
        
    
    }
    

    func customViewConstraint(){
        
       
        //add constraint to headView
        let hHeadViewVFL = "H:|-0-[headView]-0-|"
        
        let hHeadViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hHeadViewVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["headView" : headView])
        
        self.view.addConstraints(hHeadViewConstraint)
        
        let vHeadViewVFL = "V:|-12-[headView(==vHeight)]"
        
        let vHeadViewCnstraint = NSLayoutConstraint.constraintsWithVisualFormat(vHeadViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["vHeight" : vHeight], views: ["headView" : headView])
        
        self.view.addConstraints(vHeadViewCnstraint)
        
        //self.tableView.estimatedRowHeight = 122.0
        //self.mOrderViewController = MUOrderTableViewController()
        
        //self.mOrderViewController?.modalArray = self.modalArray
     
        //self.addChildViewController(mOrderViewController!)
        
        
        self.customTableViewConstraint(tableView: tableView!,space: 12.0)
        
        }
    
    func subViewOfHeadView(){
        
        let height = Int(CGFloat(vHeight) * 0.38)
        
        imageView_bg = UIImageView()
        
        imageView_bg!.image = UIImage(named: "Me_bg_defalut_66")
        
        imageView_bg!.tag = 1000
        
        imageView_bg!.userInteractionEnabled = true
        
        imageView_bg!.translatesAutoresizingMaskIntoConstraints = false
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("bImage") != nil) {
            
            let imageData = NSUserDefaults.standardUserDefaults().valueForKey("bImage") as! NSData
            
            imageView_bg!.image = UIImage(data: imageData)
        }
        
        let tap_00 = UITapGestureRecognizer(target: self, action: #selector(MUMeViewController.changeHeaderImage(_:)))
        
        tap_00.delegate = self
        
        tap_00.numberOfTapsRequired = 1
        
        tap_00.numberOfTouchesRequired = 1
        
        imageView_bg!.addGestureRecognizer(tap_00)
        
        self.headView.addSubview(imageView_bg!)
        
        let hImage_bgVFL = "H:|-0-[imageView_bg]-0-|"
        
        let hImage_bgConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hImage_bgVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["imageView_bg" : imageView_bg!])
        
        self.headView.addConstraints(hImage_bgConstraint)
        
        let vImage_bgVFL = "V:|-0-[imageView_bg(==height)]"
        
        let vImage_bgConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vImage_bgVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["height" : height], views: ["imageView_bg" : imageView_bg!])
        
        self.headView.addConstraints(vImage_bgConstraint)
        
        
        let hWidth_img = CGFloat(self.vHeight) * 0.62
        
        let vHeight_img = hWidth_img * 3/4
        
        let v_space_img = CGFloat(Int(vHeight_img/3))
        
        headerImageView = UIImageView()
        
        headerImageView!.translatesAutoresizingMaskIntoConstraints = false
        
        headerImageView!.frame.size = CGSizeMake(hWidth_img, vHeight_img)
        
        headerImageView!.tag = 1001
        
        headerImageView!.frame.size = CGSizeMake(hWidth_img, vHeight_img)
        
        var image =  UIImage(named: "Me_userImage_defalut_78")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("headerImage") != nil) {
            
            let object = NSUserDefaults.standardUserDefaults().valueForKey("headerImage") as! NSData
            
             image = UIImage(data: object)
            
           // headerImageView!.image = UIImage.resizeImage(image: image!, size: CGSizeMake(hWidth_img, vHeight_img))
        }
        
        headerImageView!.image = UIImage.resizeImage(image: image!, size: CGSizeMake(hWidth_img, vHeight_img))
        
        headerImageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        headerImageView!.userInteractionEnabled = true
        
        self.headView.bringSubviewToFront(headerImageView!)
        
        self.headView.addSubview(headerImageView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUMeViewController.changeHeaderImage(_:)))
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        tap.delegate = self
        
        headerImageView!.addGestureRecognizer(tap)
        
        
        let hHeadImageConstraint = NSLayoutConstraint(item: headerImageView!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: .Left, multiplier: 1.0, constant: 12.0)
        
        self.headView.addConstraint(hHeadImageConstraint)
        
        let vHeadImageConstraint = NSLayoutConstraint(item: headerImageView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView_bg, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -v_space_img)
        
        self.headView.addConstraint(vHeadImageConstraint)
        
        let userLabel = UILabel()
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.headView.addSubview(userLabel)
        
        userLabel.text = "Adaman"
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("username") != nil) {
            
            let object = NSUserDefaults.standardUserDefaults().valueForKey("username") as! String
            
            userLabel.text = object
        }
        
        userLabel.font = UIFont.systemFontOfSize(16.0)
        
        let hUserLabelConstaint = NSLayoutConstraint(item: userLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: headerImageView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12)
        
        self.headView.addConstraint(hUserLabelConstaint)
        
        let vUserLabelConstraint = NSLayoutConstraint(item: userLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView_bg, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 8)
        
        self.headView.addConstraint(vUserLabelConstraint)
        
        addressLabel = UILabel()
        
         addressLabel!.text = "San Francisco California"
        
        addressLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // NSUserDefaults.standardUserDefaults().setObject(self.location, forKey: "adress")
        if (NSUserDefaults.standardUserDefaults().objectForKey("address") != nil) {
            
            let object = NSUserDefaults.standardUserDefaults().valueForKey("address") as! String
            
            addressLabel!.text = object
            
        }
        
        
        self.headView.addSubview(addressLabel!)
        
        addressLabel!.font = UIFont.systemFontOfSize(11.0)
        
//        let temp = (addressLabel.text! as NSString).sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(11.0)])
//        
//        print(temp)
        
        let hAddressLabelConstraint = NSLayoutConstraint(item: addressLabel!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: headerImageView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 12)
        
        self.headView.addConstraint(hAddressLabelConstraint)
        
        let vAddressLabelConstraint = NSLayoutConstraint(item: addressLabel!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: userLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 4.0)
        
        self.headView.addConstraint(vAddressLabelConstraint)
        
        
       
        
        //orderButton.backgroundColor = UIColor.whiteColor()
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        
        orderButton.setTitle("Order", forState: UIControlState.Normal)
        
        orderButton.setTitleColor(UIColor.customColor(), forState: UIControlState.Normal)
        
        orderButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        orderButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        orderButton.contentMode = UIViewContentMode.Center
        
        orderButton.selected = true
        
        orderButton.addTarget(self, action: #selector(MUMeViewController.buttonOfTouchUpInside(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        orderButton.tag = 1
        
        self.tempButton = orderButton
        //orderButton.setImage(UIImage(named: "Me_Button_Edit_defalut_30"), forState: UIControlState.Normal)hWidth_img
        
        self.headView.addSubview(orderButton)
        
        let lOrderButtonConstraint = NSLayoutConstraint(item: orderButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.headerImageView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        self.headView.addConstraint(lOrderButtonConstraint)
        
        let rOrderButtonConstraint = NSLayoutConstraint(item: orderButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.headerImageView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        
        self.headView.addConstraint(rOrderButtonConstraint)
        
        let vOrderButtonConstraint = NSLayoutConstraint(item: orderButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        self.headView.addConstraint(vOrderButtonConstraint)
        
        let hOrderButtonConstraint = NSLayoutConstraint(item: orderButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 30.0)
        
        self.headView.addConstraint(hOrderButtonConstraint)
        
        let settingButton = UIButton()
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingButton.setTitle("Setting", forState: UIControlState.Normal)
        
        settingButton.setTitleColor(UIColor.customBlack(), forState: UIControlState.Normal)
        
        settingButton.contentMode = UIViewContentMode.Center
        
        settingButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        settingButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        settingButton.tag = 2
        
        settingButton.addTarget(self, action: #selector(MUMeViewController.buttonOfTouchUpInside(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.headView.addSubview(settingButton)
        
        let rSettingButtonConstraint = NSLayoutConstraint(item: settingButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.headView.addConstraint(rSettingButtonConstraint)
        
        let wSettingButtonConstraint = NSLayoutConstraint(item: settingButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: CGFloat(self.vHeight) * 0.62)
        
        self.headView.addConstraint(wSettingButtonConstraint)

        
        let vSettingButtonConstraint = NSLayoutConstraint(item: settingButton, attribute: NSLayoutAttribute.Bottom , relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        
        self.headView.addConstraint(vSettingButtonConstraint)
        
        let hhOrderButtonConstraint = NSLayoutConstraint(item: settingButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.headView, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 30.0)
        
        self.headView.addConstraint(hhOrderButtonConstraint)
        
        self.view.needsUpdateConstraints()
        
         self.drawTriangle(self.tempButton!)

        
    }
    
    
    func goToRegisterViewController(button : MUButton) {
        
       //MUSQLiteUserListTool.updateDataToDatabase("password", upDataWithEmailAndData: ["1234567","392071745@qq.com"])
        
        
    }
    
    
    //MARK UIPopoverPresentViewControllerDelegate
    
    //daaptive layout makes iPhone
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        if UIDevice.currentDevice().model == "iPhone" {
            
            return UIModalPresentationStyle.None
        }else{
            
            return UIModalPresentationStyle.Popover
        }
    }
    
    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        
        self.view.alpha = 0.60
        
        self.navigationController?.navigationBar.alpha = 0.60
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
        self.view.alpha = 1.0
        
        self.navigationController?.navigationBar.alpha = 1.0
    }
    //change header image from photos
    func changeHeaderImage(tap:UITapGestureRecognizer) {
        
        
        
        if tap.numberOfTouches() == 1{
            
            let imageView = tap.view as! UIImageView
           
            if imageView.tag % 1000 == 0 {
                
                
                self.pickViewControler?.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                
                self.pickViewControler?.navigationBar.tintColor = UIColor.whiteColor()
                
                self.pickViewControler?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
                
                self.pickViewControler?.navigationBar.barTintColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
                
                self.presentViewController(self.pickViewControler!, animated: true, completion: nil)
                
                self.is_header = false

            }else{
                
                self.is_header = true
                
                let alertController = UIAlertController(title: "PickerOrTakePhotos", message: "Custom your Image.", preferredStyle: UIAlertControllerStyle.ActionSheet)
                
                alertController.modalPresentationStyle = UIModalPresentationStyle.PageSheet
                //we need to set a anchorPoint on the iPad
                
                let popover = alertController.popoverPresentationController
                
                if popover != nil {
                    
                    popover?.sourceView = self.view
                    
                    popover?.sourceRect = self.view.bounds
                    
                    popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                }
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                    
                    //print("======================")
                    let cameraAction = UIAlertAction(title: "take photos", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                        
                        self.pickViewControler?.sourceType = UIImagePickerControllerSourceType.Camera
                        
                        self.presentViewController(self.pickViewControler!, animated: true, completion: nil)
                    })
                    
                    alertController.addAction(cameraAction)
                    
                    
                }
                
                
                let photoLibaryAction = UIAlertAction(title: "Photos", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    
                    self.pickViewControler?.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    
                    self.pickViewControler?.navigationBar.tintColor = UIColor.whiteColor()
                    
                    self.pickViewControler?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
                    
                    self.pickViewControler?.navigationBar.barTintColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
                    
                    
                    self.presentViewController(self.pickViewControler!, animated: true, completion: nil)
                })
                
                alertController.addAction(photoLibaryAction)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
            
            
    }
    
    //implement image picker delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
  
        var image:UIImage?
        
        if picker.allowsEditing {
            
            image = info[UIImagePickerControllerEditedImage] as? UIImage
            
        }else {
            
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        let imageData = UIImagePNGRepresentation(image!)
        
        if self.is_header {
            
            let hWidth_img = CGFloat(self.vHeight) * 0.62
            
            let vHeight_img = hWidth_img * 3/4

            NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "headerImage")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.headerImageView?.image = UIImage.resizeImage(image: image!, size: CGSizeMake(hWidth_img, vHeight_img))
            
            //self.headerImageView?.frame.size = CGSizeMake(hWidth_img, vHeight_img)
        }else{
            
            NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "bImage")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.imageView_bg?.image = UIImage.resizeImage(image: image!, size: CGSizeMake(self.view.frame.width,CGFloat(self.vHeight)))

        }
        
       self.dismissViewControllerAnimated(true, completion: nil)

    }
   
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.is_header = true
    }
    func buttonOfTouchUpInside(button:UIButton){
        
        if button != self.tempButton {
            
            if button.tag == 1 {
                
                self.tempButton?.setTitleColor(UIColor.customBlack(), forState: UIControlState.Normal)
                
                self.tempButton?.backgroundColor = UIColor.clearColor()
                
                button.setTitleColor(UIColor.customColor(), forState: UIControlState.Normal)
                
                button.backgroundColor = UIColor.customGrayColor()
                
                self.tempButton = button
                
                self.mViewController?.removeFromParentViewController()
                
                self.mViewController?.view.removeFromSuperview()
                
                self.mOrderViewController = MUOrderTableViewController()
                
                self.mOrderViewController?.tableView.translatesAutoresizingMaskIntoConstraints = false
                
                self.addChildViewController(self.mOrderViewController!)
                
                self.view.addSubview((self.mOrderViewController?.tableView)!)
                
                self.customTableViewConstraint(tableView: (self.mOrderViewController?.tableView)!,space: 12.0)
                
                //self.drawTriangle(button)
                
            }else{
                self.tempButton?.setTitleColor(UIColor.customBlack(), forState: UIControlState.Normal)
                
                self.tempButton?.backgroundColor = UIColor.clearColor()
                
                button.setTitleColor(UIColor.customColor(), forState: UIControlState.Normal)
                
                button.backgroundColor = UIColor.customGrayColor()
                
                 self.tempButton = button

                self.mOrderViewController?.removeFromParentViewController()
                
                self.mOrderViewController?.tableView.removeFromSuperview()
                
                self.mViewController = MUSettingTableViewController()
                
                self.mViewController?.navigationView = self.navigationView
                
                self.mViewController!.delegate = self
                
                self.mViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.addChildViewController(self.mViewController!)
                
                self.view.addSubview(self.mViewController!.tableView)
                
                self.customTableViewConstraint(tableView: (self.mViewController?.tableView)!,space: 0)
                
                self.isReturn = true
            }
        }
        
        self.drawTriangle(button)

    }
    
    func customTableViewConstraint(tableView tableView:UITableView, space:CGFloat){
        
        let hTableViewConstraintVFL = "H:|-space-[tableView]-space-|"
        
        let hTableViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTableViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["space" : space], views: ["tableView" : tableView])
        
        self.view.addConstraints(hTableViewConstraint)
        
        let vTableViewConstraintVFL = "V:[headView]-12-[tableView]-12-|"
        
        let vTableViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vTableViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["headView" : headView,"tableView" : tableView])
        
        self.view.addConstraints(vTableViewConstraint)
        

    }
    
    func getRectFromCell(rect: CGRect) {
        
        //print(rect)
        let button = MUButton()
        
        let image = UIImage(named: "Me_Button_logistics_defalut_30")
        
        button.setImage(image, forState: UIControlState.Normal)
        
        button.setTitle("Login In", forState: UIControlState.Normal)
        
        button.frame.origin.x = (self.view.frame.width - (image?.size.width)!)/2
        
        button.frame.origin.y = rect.origin.y + 56
        
       // self.view.addSubview(button)
        
        //self.view.bringSubviewToFront(button)
    }
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        if (self.modalArray != nil) {
            
            return (self.modalArray?.count)!
            
        }else{
            
           return 0
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MUOrderedViewCell
        
        // Configure the cell...

        cell.indexPath = indexPath

        cell.delegate  = self
        
        if self.modalArray?.count > 0{
            
            cell.modal = self.modalArray![indexPath.section] as? MUMeOrderedModal
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRectMake(0,0,self.view.frame.size.width,12.0))
        
        view.backgroundColor = UIColor.customWhite()
        
        return view
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 12.0
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let modal:MUMeOrderedModal?
      
        var rowHeight:CGFloat?
        
        if self.modalArray?.count > 0 {
            
            modal = self.modalArray![indexPath.section] as? MUMeOrderedModal
            
                       
            if indexPath.section == 0 && indexPath.row == 0 {
                
                //"44" is height of headerView
                
                if modal!.orderedGoodsModals!.count > 2 {
                    
                    rowHeight = 80.0 * 2.0 + 44.0 + 2*12.0
                    
                }else{
                    
                    rowHeight = CGFloat(modal!.orderedGoodsModals!.count) * 12.0 + 44.0 + 80.0 * CGFloat(modal!.orderedGoodsModals!.count)
                }

                
            }else{
            
            
                if modal!.orderedGoodsModals!.count > 2 {
                    
                    rowHeight = (2+1)*12.0 + 80.0 * 2.0
                    
                }else{
                    
                    
                   rowHeight = CGFloat(modal!.orderedGoodsModals!.count + 1) * 12.0 + 80.0 * CGFloat(modal!.orderedGoodsModals!.count)
                    
                }

            }
    }
        return rowHeight!
    }

    func moreButtonByClicked(modalArray: NSMutableArray) {
        
        let controller        = MUMeMoreOrderDetailViewController()

        controller.modalArray = modalArray

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
  private func drawTriangle(button : UIButton) {
    
    
        self.sLayer.removeFromSuperlayer()
    
        self.sLayer = CAShapeLayer()
    
        sLayer.frame = self.view.frame
        
        let bezier = UIBezierPath()
    
        let centerX = button.center.x
    
        let heightY = CGRectGetMinY(button.frame) - 24.0
    
        bezier.moveToPoint(CGPointMake(centerX - 11, heightY))
    
        bezier.addLineToPoint(CGPointMake(centerX + 11, heightY))
    
        bezier.addLineToPoint(CGPointMake(centerX , heightY + 9))
    
        //bezier.addLineToPoint(CGPointMake(centerX , heightY))
    
        bezier.lineWidth = 1.0
    
        bezier.closePath()
    
        sLayer.path = bezier.CGPath
    
        sLayer.fillColor = UIColor.customGrayColor().CGColor
    
        self.view.layer.addSublayer(sLayer)
    
        //self.view.layer.backgroundColor = UIColor.redColor().CGColor

        
    }
    
   
    //it is work for me
    override func viewDidAppear(animated: Bool) {
        
        if !self.isReturn {
            
             self.orderButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
       
        
    }
}
