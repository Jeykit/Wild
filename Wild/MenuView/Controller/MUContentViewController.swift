//
//  MUContentViewController.swift
//  Wild
//
//  Created by Adaman on 1/25/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUContentViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,MUImageByTapDelegate,MUIsPopViewControllerDelegate,UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate {
    

    var sqlite:SQLiteData?
    
    private var items:CGFloat = 1.0
    
    var delegate:MUDelegate?
    
    //when you create it ,it will be a mistake if you have not to be init
    var collectionView:UICollectionView?
    
    var collectionCellModal:MUCollectionViewCellModal = MUCollectionViewCellModal()
    
    private  let detaileViewController = MUDetaileViewController()
    
    private var navigationView      = UIView()
    
    private let menuOfButton        = UIButton()
    
    private let shoppingOfButton    = UIButton()
    
    private let seachView           = UITextField()
    
    private let seacherIcon         = UIImageView()
    
    private let userOfButton        = UIButton()
    
    private var tempViewController:MUDetaileViewController?
    
    private var length = 0
    
    private var seachViewWidth = 0
    
    private var tempNavigationView:UIView?
    
    private var maskView:UIView?
    
    private var window:UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.customWhite()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        sqlite = SQLiteData()
        //My custom navigation bar
        //self.customNavigationBar()
        
        //add colltionView to controller
        self.customCollectionView()
        
        
        //This will be cause carsh
        //self.networkDetection()
        
       
        
    }
    
  override func viewWillAppear(animated: Bool) {
        
    
        maskView = UIView(frame: (self.navigationController!.view.window!.frame))
    
        maskView!.backgroundColor = UIColor.blackColor()
    
        maskView!.alpha = 0.375

        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        
        self.customNavigationBar()
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("flag") != nil) {
            
            var flagObject = NSUserDefaults.standardUserDefaults().valueForKey("flag") as! Bool
            
            if !flagObject {
                
                self.networkDetection()
                
                flagObject = true
                
                NSUserDefaults.standardUserDefaults().setObject(flagObject, forKey: "flag")
                
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            
        }
        
        if MUButtonBdageTool.buttonBadge() {
            
            let shoppingCarNumber = MUButtonBdageTool.getButtonBadgeValues()
            
            shoppingOfButton.badgeValue = "\(shoppingCarNumber)"
        }else{
            
            shoppingOfButton.badgeValue = nil
    }
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MUContentViewController.handlerLoggedInfo(_:)), name: "loggedinInfo", object: nil)
    
    self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        self.navigationView.removeFromSuperview()
    }
    
    func handlerLoggedInfo(notification : NSNotification) {
        
        let flag = notification.object as! Bool
        
        if flag {
            
            //self.navigationController?.view.window!.addSubview(self.maskView!)
            
            let wPopViewController = UIScreen.mainScreen().bounds.width * 0.70
            
            let hPopViewController = wPopViewController / 0.885
            
            let pointX = (UIScreen.mainScreen().bounds.width - wPopViewController)/2
            
            let pointY = (UIScreen.mainScreen().bounds.width - hPopViewController)/2
            
            let contentViewController = MURegisteredViewController()
            
             contentViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            
            contentViewController.preferredContentSize = CGSizeMake(wPopViewController, hPopViewController)
            
            contentViewController.userButton = self.userOfButton
            
            let pop = contentViewController.popoverPresentationController!
            
            pop.canOverlapSourceViewRect = true
            
            //arrow does not display
            pop.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            
            pop.sourceView = self.view
            
            //let centered popViewControll
            pop.sourceRect = CGRectMake(pointX, pointY, wPopViewController , hPopViewController)
  
            pop.delegate = self

            self.presentViewController(contentViewController, animated: true, completion: nil)
            
        }else{
            
            let alertText = "Logout success!"
            
           self.showTips(alertText)
        }
        
    }
    
    private func showTips(tips : String){
    
        let hub = MBProgressHUD.showHUDAddedTo((self.navigationController?.view.window)!, animated: true)
        
        hub.mode = MBProgressHUDMode.Text
    
        hub.label.text = tips
        
        hub.label.font = UIFont.systemFontOfSize(12.0)
        
        hub.label.numberOfLines = 0
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            
            sleep(1)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                hub.hideAnimated(true)
                
                self.navigationController?.navigationBarHidden = false
                
               // self.maskView!.removeFromSuperview()
                
                
            })
        })
    }
    
  private func networkDetection(){
    
       UIActivityIndicatorView.appearanceWhenContainedInInstancesOfClasses([UINavigationController.self]).tintColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
         UIActivityIndicatorView.appearanceWhenContainedInInstancesOfClasses([UINavigationController.self]).backgroundColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
        self.navigationController!.view.window?.addSubview(maskView!)
        
        if Reachability.reachabilityForInternetConnection() != nil {
            
        
           let hub = MBProgressHUD.showHUDAddedTo((self.navigationController?.view.window)!, animated: true)
            
            hub.mode = MBProgressHUDMode.Indeterminate
            
            hub.label.text = "Updating"
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                
                sleep(3)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    hub.hideAnimated(true)
                    
                    self.navigationController?.navigationBarHidden = false
                    
                    self.maskView!.removeFromSuperview()
                    
                    
                })
            })
        }else{
            
            
            let hub:MBProgressHUD = MBProgressHUD.showHUDAddedTo((self.navigationController?.view.window)!, animated: true)
            
            hub.label.text = "No network."
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                
                sleep(3)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    hub.hideAnimated(true)
                    
                    self.navigationController?.navigationBarHidden = false
                    
                    self.maskView!.removeFromSuperview()
                    
                    
                })
            })
        }
        
        
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
        self.maskView?.removeFromSuperview()
        
        self.window?.resignKeyWindow()
        
        self.window?.hidden = true
    }
    
  private func customCollectionView(){
      
        var itemHeight:CGFloat = 1.0
    
        var itemWidth:CGFloat  = 1.0
        //var items:CGFloat      = 1.0
        var space:CGFloat      = 1.0
    
        let subItems:CGFloat   = 4.0
        
        if UIDevice.currentDevice().model == "iPhone"{
            
            items = 2.0
            
            space = ((items-1)+2)*12
            
            itemWidth = (self.view.bounds.width-space)/items
            
            itemHeight = (itemWidth*4/3)+((subItems-1)*12+36)+90
            
            
        }else if UIDevice.currentDevice().model == "iPad"{
            
            items = 3.0
            
            space = ((items-1)+2)*12
            
            itemWidth = (self.view.bounds.width-space)/items
            
            itemHeight = (itemWidth*4/3)+((subItems-1)*12+24)+90+24
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight)
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12.0, 12.0, 12.0)
        
        flowLayout.minimumInteritemSpacing = 0.0
        
        flowLayout.minimumLineSpacing = 0.0
        
        //print(flowLayout.itemSize)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        self.view.addSubview(collectionView!)
        
        collectionView!.backgroundColor = UIColor.customWhite()
        
        collectionView!.alwaysBounceVertical = true
        
        collectionView!.showsHorizontalScrollIndicator = false
        
        collectionView!.showsVerticalScrollIndicator   = false
        
        collectionView!.userInteractionEnabled = true
        
        collectionView!.dataSource = self
        
        collectionView!.delegate = self
        
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(MUContentViewController.handleSwipGesture(_:)))
        
        swip.direction = UISwipeGestureRecognizerDirection.Left.union(UISwipeGestureRecognizerDirection.Right)
        
        swip.numberOfTouchesRequired = 1
        
        swip.delegate = self
        
        collectionView?.addGestureRecognizer(swip)
    
        collectionView?.backgroundColor = UIColor.customWhite()
        //collectionView.collectionViewLayout = flowLayout
        //let cell:AnyClass = UINib(nibName: "cell", bundle: nil) as! AnyClass
        
        //self.collectionView?.registerNib(UINib(nibName: "cell", bundle: nil), forSupplementaryViewOfKind: "MUCollectionCellCollectionViewCell", withReuseIdentifier: "cell")
        collectionView!.registerClass(MUCollectionCellCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        //collectionView!.registerNib(UINib(nibName: "MUCollectionCellCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "cell")

    }
    
    func handleSwipGesture(swip : UISwipeGestureRecognizer){
        
        if swip.direction == UISwipeGestureRecognizerDirection.Right {
            
            self.getImageFromScreen()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        
        var count = (self.sqlite?.goodsInfo?.count)!/2
        
        if UIDevice.currentDevice().model == "iPad" {
            
            count = (self.sqlite?.goodsInfo?.count)!/3
        }
        
        return count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Int(self.items)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MUCollectionCellCollectionViewCell
       
        //self.collectionCellModal.titleOfButton = "okay"
        
        cell.delegate = self
        
        let count = (indexPath.section + indexPath.row) + (Int(self.items) - 1) * indexPath.section
        
        let modal = self.sqlite?.goodsInfo![count] as? MUCollectionViewCellModal
        
        modal?.flag = count
        
        //self.flag = self.flag + 1
        
        cell.collectionCellModal = modal
        
       //print(indexPath)

        return cell
    }
    
    func customNavigationBar() {
        
        
        if self.tempNavigationView != nil {
            
            self.tempNavigationView?.removeFromSuperview()
        }
        
        //custom bg
        navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        menuOfButton.setImage(UIImage(named:"menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        menuOfButton.setImage(UIImage(named:"menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        menuOfButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        menuOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        menuOfButton.addTarget(self, action: #selector(MUContentViewController.getImageFromScreen), forControlEvents: UIControlEvents.TouchUpInside)
        
       shoppingOfButton.setImage(UIImage(named:"Shopping-Cart--icon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        shoppingOfButton.setImage(UIImage(named:"Shopping-Cart--icon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        shoppingOfButton.setBackgroundImage(UIImage(named: "shopping-cart-icon-background")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        shoppingOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        shoppingOfButton.tag = 1001
        
        //shoppingOfButton.badgeBGColor = UIColor.whiteColor()
        
        //shoppingOfButton.badgeTextColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        if MUButtonBdageTool.buttonBadge() {
            
            let shoppingCarNumber = MUButtonBdageTool.getButtonBadgeValues()
            
            shoppingOfButton.badgeValue = "\(shoppingCarNumber)"
            
            shoppingOfButton.badgeOriginY = 0
            
        }
        
        
        shoppingOfButton.addTarget(self, action: #selector(MUContentViewController.goToControllView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //if you use auto layout,you need not to init frame
            
        seachView.background = UIImage(named: "search-background")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //icon length
        self.length = 30
            
        seachView.contentMode = UIViewContentMode.ScaleAspectFit
            
        self.seachViewWidth = Int(self.view.frame.width - 5*12 - 3*CGFloat(length))
       
        seachView.translatesAutoresizingMaskIntoConstraints = false
        
       
        seacherIcon.image = UIImage(named: "seacher_icon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        seacherIcon.translatesAutoresizingMaskIntoConstraints = false
        
        seachView.addSubview(seacherIcon)
        
        userOfButton.setImage(UIImage(named: "user")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
         userOfButton.setImage(UIImage(named: "user")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        userOfButton.setBackgroundImage(UIImage(named: "user-highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        userOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            userOfButton.setImage(UIImage(named: "user-loggedin")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
            
            userOfButton.setImage(UIImage(named: "user-loggedin")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        }
        
        userOfButton.tag = 1002
        
        userOfButton.addTarget(self, action: #selector(MUContentViewController.goToUserViewController), forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationView.addSubview(menuOfButton)
        
        navigationView.addSubview(seachView)
        
        navigationView.addSubview(userOfButton)
        
        navigationView.addSubview(shoppingOfButton)
        
        //add custom constraint
        self.customConstraint()
        
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        self.tempNavigationView = navigationView
        
        
        
    }
    
    func goToUserViewController() {
        
        self.navigationView.removeFromSuperview()
        
        let controllerView = MUMeViewController()
        
        MUSQLiteDataMeViewControllerTool.createDataBase()
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            let emailText = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
            
            controllerView.modalArray = MUSQLiteDataMeViewControllerTool.readOrderedDataFromDatabase(emailText)
        }else{
            
             controllerView.modalArray = []
        }
        
       // print("================\(controllerView.modalArray?.count)====\(controllerView.modalArray)")

        self.navigationController?.pushViewController(controllerView, animated: true)
        
    }
    
    func goToControllView(button:UIButton){
        
        
        
            
            self.navigationView.removeFromSuperview()
            
            MUSQLiteDatabaseShoppingCarTool.createDataBase()
            
            let controllerView = MUShoppingCarViewController()
            
            controllerView.modalArray = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
            
            controllerView.numberOfCount = "\(MUSQLiteDatabaseShoppingCarTool.numberOfCount)"
            
            controllerView.totalPrice = "\(MUSQLiteDatabaseShoppingCarTool.totalPrice)"
            
            controllerView.codeArray = MUSQLiteDatabaseShoppingCarTool.codeArray
            
            controllerView.codeDictionary = MUSQLiteDatabaseShoppingCarTool.codeDict
            
            //MUSQLiteDatabaseShoppingCarTool
            
            self.navigationController?.pushViewController(controllerView, animated: true)
            
            
            //let temp = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
            
        
        self.navigationItem.title = ""
        
        self.navigationView.removeFromSuperview()
    }

    func customConstraint(){
        
        let spaceOfLeftConstraint = NSLayoutConstraint(item: seacherIcon, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: seachView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant: 12)
        
        let centerOfConstraint = NSLayoutConstraint(item: seacherIcon, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: seachView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        seachView.addConstraints([spaceOfLeftConstraint,centerOfConstraint])
        
        let centerToNavigationView = NSLayoutConstraint(item: menuOfButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        navigationView.addConstraint(centerToNavigationView)
        
        let str = "H:|-12-[menuOfButton(==width)]-12-[seachView(==seachViewWidth)]-12-[userOfButton(==menuOfButton)]-12-[shoppingOfButton(==menuOfButton)]-12-|"
        
        let Hcons = NSLayoutConstraint.constraintsWithVisualFormat(str, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop),metrics: ["width": length,"seachViewWidth" : seachViewWidth], views: ["menuOfButton" : menuOfButton,"seachView" : seachView,"userOfButton":userOfButton,"shoppingOfButton" : shoppingOfButton])
        
        navigationView.addConstraints(Hcons)
        
        let vcons = NSLayoutConstraint(item: seachView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 30.0)
        
        navigationView.addConstraint(vcons)
        

    }
    //Cut image from current screen
    func getImageFromScreen(){
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.parentViewController?.view.layer.renderInContext(context!)
        //self.view.layer.renderInContext(context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
       if ((delegate?.respondsToSelector(#selector(MUContentViewController.getImageFromScreen))) != nil){
        
          delegate?.getImage(image)
        }
        
    }
    
    func getImageWhenLanuch() -> UIImage {
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        self.parentViewController?.view.layer.renderInContext(context!)
        
        //self.view.layer.renderInContext(context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image

    }
    
    func getImageInfoByTap(flag flag:Int) {
        
       
        
        self.navigationView.removeFromSuperview()
        
        let tempSize = MUSQLiteToolForContenViewController.openDatabaseForSize(flag)
        
       // let expandModal = self.openDatabaseForDecription(flag)
        //This is chage to backBarButtonItem title
        //self.navigationItem.title = ""
        if self.tempViewController != nil {
            
            self.tempViewController?.removeFromParentViewController()
            
        }
        //let detaileViewController:MUDetaileViewController = MUDetaileViewController()
        
        let tempModal = self.sqlite?.goodsInfo![flag] as? MUCollectionViewCellModal
        
        detaileViewController.DetailModal.imageOfGoods = tempModal?.imageOfGoods
        
        detaileViewController.DetailModal.titleOfLabel = tempModal?.textOfDetaile
        
        detaileViewController.DetailModal.textOfPrice  = tempModal?.textOfPrice
        
        detaileViewController.DetailModal.numberOfCommentImages = self.randomFloat()
        
        detaileViewController.imageArray = MUSQLiteToolForContenViewController.openDatabase(flag)
        
        detaileViewController.colorDict = SQLiteDatabaseTool.openDatabaseForColor(flag)
        
        detaileViewController.sizeArray = tempSize
        
        detaileViewController.delegate = self
        
        detaileViewController.modalArray = MUSQLiteToolForContenViewController.openDatabaseForDecription(flag,tableName : (tempModal?.code)!)
        
       // print("==============\( detaileViewController.modalArray)")
        
        let indentiferFlag = flag + 1000
        
        detaileViewController.indentiferTag = indentiferFlag
        
        detaileViewController.DetailModal.saleOfCode   = (tempModal?.code)!
        
        self.navigationController?.pushViewController(detaileViewController, animated: true)
        
        self.tempViewController = detaileViewController
        
        self.navigationView.removeFromSuperview()
       
         //NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: indentiferFlag )
       
    }
    
    private func randomFloat() -> Float {
        
        let num = arc4random() % 5 + 2
        
        //print("======================num==\(num)")
        
        srand48(Int(num))
        
        let numberFloat = Float(round(drand48() * 10) / 10)
        
        return numberFloat + Float(num)
    }

    
    func IsPopViewController(flag: Bool) {
        
        if flag{
            
            self.customNavigationBar()
            
            self.customConstraint()
        }
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


}
