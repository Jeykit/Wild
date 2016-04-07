//
//  MUDetaileViewController.swift
//  Wild
//
//  Created by Adaman on 1/30/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit
import QuartzCore

class MUDetaileViewController: UIViewController,UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,MULabelTextByClickDelegate {

    var textOfTitle              = "Detailes"
    
    var numberOfComment          = 5
    
    var DetailModal:MUDetailViewControllerModal = MUDetailViewControllerModal()
  
    var imageArray:NSMutableArray?
    
    var sizeArray:NSMutableArray?
    
    private var navigationView   = UIView()
    
    private let backOfButton     = UIButton()
    
    private let shoppingOfButton = UIButton()
    
    private let userOfButton     = UIButton()
    
    private let imageViewOfGoods = UIImageView()
    
    private let priceOfLabel     = UILabel()
    
    private let saleOfLabel      = UILabel()
    
    private let titleOfLabel     = UILabel()
    
    private let saleOfButton     = UILabel()
    
    private let dividerOfImageView = UIImageView()
    
    private let colorPickOfLabel = UILabel()
    
    private let colorPickOfContaint = UIView()
    
    private let sizeOfLabel      = UILabel()
    
    private let selectSizeOfContraint = UIView()
    
    private let saleImageView = UIImageView()
    
    private let buttonOfContaint = UIView()
    
    private var tableView:UITableView?
    
    private var tempCurrentOfImageView:UIImageView?
    
    private var tempCurrentOfSizeLabel:UILabel?
    
    private var numberOfBuy:Int = 1
    
    private let pageControll = UIPageControl()
    
    private var collectionView:UICollectionView?
    
    private var scrollViewWidth:CGFloat = 0
    
    private var scrollViewHeight:CGFloat = 0
    
    private let space:CGFloat = 12.0
    
    private let detailView = UIView()
    
    private let commentOfLabel = UILabel()
    
    private let commentOfView = UIView()
    
    private var timer:NSTimer?
    
    private var dictForCell:NSMutableArray?
    
    private var cellByClickedIndexPath:NSArray?
    
    private var tempArray:NSMutableArray?
    
    var delegate:MUIsPopViewControllerDelegate?
    
    private var tempDictArray:NSMutableArray?
    
    private var  cellByClickDictArray:NSMutableArray?
    
    private var hLabelConstraint:[NSLayoutConstraint] = []
    
    private var vLabelConstraint:[NSLayoutConstraint] = []
    
    var colorDict:NSMutableDictionary?
    
    var modalArray:NSMutableArray?
    
    private var rowHeighCache:NSCache?
    
    var indentiferTag:Int?
    
    private var tempNavigationView:UIView?
    
    private var isClicked:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.customWhite()
         //self.customNavigationBar()
        scrollViewWidth = CGFloat(Int((UIScreen.mainScreen().bounds.size.width - CGFloat(3*space))*2/3))
        
        if UIDevice.currentDevice().model == "iPad" {
            
            scrollViewWidth = CGFloat(Int((UIScreen.mainScreen().bounds.size.width - CGFloat(3*space))*0.62))
        }
        
        scrollViewHeight = CGFloat(Int(scrollViewWidth * 4/3))
        
        //self.modalArray =  SQLiteDatabaseTool.openDatabaseForDecription(indentiferTag! % 1000)
        
        self.customSubViews()
        
        self.tableView!.reloadData()

        // Do any additional setup after loading the view.
       // self.customNavigationBar()
        
        //self.view.backgroundColor = UIColor.whiteColor()
        
        //self.rowHeightCache = NSCache()
        //self.addCustomTimer()
        
    }

    override func viewDidAppear(animated: Bool) {
        
        
        self.numberOfBuy = 1

        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //self.allRemoveFromSuperView()
        
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.customNavigationBar()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //self.navigationItem.backBarButtonItem = nil
        
        self.dictForCell = NSMutableArray()
        
        self.tempArray = NSMutableArray()
        
        //self.rowHeighCache = NSCache()
        //self.modalArray = self.openDatabaseForDecription(indentiferTag % 1000)
        
        
        // Do any additional setup after loading the view.
        //self.customNavigationBar()
        self.view.backgroundColor = UIColor.whiteColor()

        self.cellByClickedIndexPath = NSMutableArray()
        
        self.collectionView?.setContentOffset(CGPoint(x: (self.collectionView?.frame.size.width)!*498, y: 0), animated: false)
        
        //print("===================\(self.modalArray)")
        
        self.colorPickOfGoogsImageview()
        
        for (_,element) in self.selectSizeOfContraint.subviews.enumerate() {
            
            element.removeFromSuperview()
        }
        
        self.selectSizeOfContraint.setNeedsDisplay()
        
        if UIDevice.currentDevice().model == "iPhone" {
            
            self.sizeSelectedOfLabel()
        }else if UIDevice.currentDevice().model == "iPad" {
            
            self.sizeSelectedOfLabelAtIpad()
        }
        
        if MUButtonBdageTool.buttonBadge() {
            
            let shoppingCarNumber = MUButtonBdageTool.getButtonBadgeValues()
            
            shoppingOfButton.badgeValue = "\(shoppingCarNumber)"
        }else{
            
            shoppingOfButton.badgeValue = ""
        }
        
//        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
//            
//            let emailText = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
//            
//            self.modalArray = MUSQLiteDataMeViewControllerTool.readOrderedDataFromDatabase(emailText)
//        }else{
//            
//            self.modalArray = []
//        }
        
        self.collectionView?.reloadData()
        
        //self.tableView = UITableView()
        
        self.tableView!.reloadData()


    }
    
    override func viewDidDisappear(animated: Bool) {
        
        
        self.dictForCell = nil
        
        //self.cellByClickedIndexPath = nil
        
        self.tempArray = nil
        
        //self.tableView = nil
        
       // self.rowHeighCache = nil
        
        self.navigationView.removeFromSuperview()
        
//        if self.cellByClickedIndexPath?.count > 0 {
//            
//           self.tableView?.deleteRowsAtIndexPaths(self.cellByClickedIndexPath as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.None)
//        }
        
        self.cellByClickedIndexPath = nil
        
        self.isClicked = false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func customNavigationBar() {
        
        
        // print("======================\(self.navigationController?.navigationBar.subviews)")
        if self.tempNavigationView != nil {
            
            self.tempNavigationView?.removeFromSuperview()
            
            
        }

        //custom bg
       navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        navigationView.tag = 10000
        
        backOfButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        backOfButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        backOfButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        backOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        backOfButton.addTarget(self, action: #selector(MUDetaileViewController.backToSuperViewController), forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationView.addSubview(backOfButton)
        
        
        shoppingOfButton.setImage(UIImage(named:"Shopping-Cart--icon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        shoppingOfButton.setImage(UIImage(named:"Shopping-Cart--icon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        shoppingOfButton.setBackgroundImage(UIImage(named: "shopping-cart-icon-background")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        if MUButtonBdageTool.buttonBadge() {
            
            let shoppingCarNumber = MUButtonBdageTool.getButtonBadgeValues()
            
            shoppingOfButton.badgeValue = "\(shoppingCarNumber)"
        }else{
            
            shoppingOfButton.badgeValue = ""
        }
    
        shoppingOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        shoppingOfButton.addTarget(self, action: #selector(MUDetaileViewController.goToViewController(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        shoppingOfButton.tag = 1001
        
        userOfButton.setImage(UIImage(named: "user")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        userOfButton.setImage(UIImage(named: "user")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        userOfButton.setBackgroundImage(UIImage(named: "user-highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        userOfButton.addTarget(self, action: #selector(MUDetaileViewController.goToViewController(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        userOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        userOfButton.tag = 1002
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            userOfButton.setImage(UIImage(named: "user-loggedin")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
            
            userOfButton.setImage(UIImage(named: "user-loggedin")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        }
        
        navigationView.addSubview(userOfButton)
        
        navigationView.addSubview(shoppingOfButton)
        
        self.title = self.textOfTitle
        
        //change navigationController title of color and font
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.customWhite(),NSFontAttributeName : UIFont.systemFontOfSize(18)]
        
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        self.tempNavigationView = navigationView
        
        self.customConstraint()
        
        
        
    }

    func goToViewController(button:UIButton){
        
       
        
        if button.tag % 1000 == 1{
           
            self.navigationView.removeFromSuperview()
            
            MUSQLiteDatabaseShoppingCarTool.createDataBase()
            
           let controllerView = MUShoppingCarViewController()
            
            controllerView.modalArray = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
            
            controllerView.numberOfCount = "\(MUSQLiteDatabaseShoppingCarTool.numberOfCount)"
            
            controllerView.totalPrice = "\(MUSQLiteDatabaseShoppingCarTool.totalPrice)"
            
            controllerView.codeArray = MUSQLiteDatabaseShoppingCarTool.codeArray
            
            controllerView.codeDictionary = MUSQLiteDatabaseShoppingCarTool.codeDict

            
            self.navigationController?.pushViewController(controllerView, animated: true)

           
            //let temp = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
            
            
        }else if button.tag % 1000 == 2 {
            
           let controllerView = MUMeViewController()
            
            MUSQLiteDataMeViewControllerTool.createDataBase()
            
            if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
                
                let emailText = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
                
                controllerView.modalArray = MUSQLiteDataMeViewControllerTool.readOrderedDataFromDatabase(emailText)
            }else{
                
                 controllerView.modalArray = []
            }
            
            self.navigationController?.pushViewController(controllerView, animated: true)

        }
       
        
        self.navigationItem.title = ""
        
        self.navigationView.removeFromSuperview()
    }
    
    func customConstraint(){
        
        let backButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: backOfButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant: 12)
        
        let backButtonConstraint_center = NSLayoutConstraint(item: backOfButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hbackButtonConstraint_center = NSLayoutConstraint(item: backOfButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        navigationView.addConstraints([backButtonConstraint_spaceOfLeft,backButtonConstraint_center,hbackButtonConstraint_center])
        
        
        let hUserAndShoppingVFL         = "H:[userOfButton(==30)]-12-[shoppingOfButton(==userOfButton)]-12-|"
        
        let hUserAndShoppingConstraint  = NSLayoutConstraint.constraintsWithVisualFormat(hUserAndShoppingVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop),metrics: nil, views: ["userOfButton":userOfButton,"shoppingOfButton" : shoppingOfButton])
        
        navigationView.addConstraints(hUserAndShoppingConstraint)
        
        let userOfCenter = NSLayoutConstraint(item: userOfButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        navigationView.addConstraint(userOfCenter)

        
    }
    
    func backToSuperViewController(){
    
        
        self.numberOfBuy = 1
        
        self.imageArray = nil
        
        self.sizeArray = nil
        
        //self.modalArray = nil
        
        //self.tableView = nil
        
        //self.modalArray = nil
       // self.cellByClickDictArray = nil
        
        //NSNotificationCenter.defaultCenter().removeObserver(self)
        
        self.navigationView.removeFromSuperview()
        
        self.navigationController?.popViewControllerAnimated(true)
        
       // self.tableView?.removeFromSuperview()
        
        delegate?.IsPopViewController(true)
        
        SQLiteDatabaseTool.deleteDatabase()
        
        //if not clear data before back to preViewControll,the data in cell will duplication
        
//        for element in (self.tableView?.visibleCells)! {
//            
//            let cell = element as! MUExpandTableViewCell
//            
//            cell.removeTextLabel()
//        }
        
    }
    
   private func customSubViews(){
        
        //let space = 12.0
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSizeMake(scrollViewWidth, scrollViewHeight)
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
       // flowLayout.sectionInset = UIEdgeInsetsMake(-8, 0.0, 0, 0)
        
        flowLayout.minimumInteritemSpacing = 0.0
        
        flowLayout.minimumLineSpacing      = 0.0
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, scrollViewWidth, scrollViewHeight), collectionViewLayout: flowLayout)
        
        self.view.addSubview(self.collectionView!)
        
        self.collectionView?.dataSource = self
        
        self.collectionView?.delegate = self
        
        self.collectionView?.alwaysBounceHorizontal = true
        
        self.collectionView?.showsHorizontalScrollIndicator = false
        
        self.collectionView?.pagingEnabled = true
        
        self.collectionView?.setContentOffset(CGPoint(x: (self.collectionView?.frame.size.width)!*498, y: 0), animated: false)
        
       // self.collectionView?.showsVerticalScrollIndicator = false
        
        self.collectionView?.backgroundColor = UIColor.grayColor()
        
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView?.registerClass(MUCycleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        self.pageControll.translatesAutoresizingMaskIntoConstraints = false
        
        self.pageControll.numberOfPages = 3
        
        self.pageControll.currentPage = 0
        
        self.pageControll.pageIndicatorTintColor = UIColor.grayColor()
        
        self.pageControll.currentPageIndicatorTintColor = UIColor.customColor()
        self.view.addSubview(self.pageControll)
        
        
        self.priceOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceOfLabel.sizeToFit()
        
        self.priceOfLabel.text = "$" + DetailModal.textOfPrice!
        
        self.priceOfLabel.textColor = UIColor.customColor()
        
        self.priceOfLabel.font = UIFont.systemFontOfSize(DetailModal.fontSizeOfPriceLabel)
        
        self.view.addSubview(self.priceOfLabel)
        
        self.saleOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //self.saleOfLabel.sizeToFit()
        self.saleOfLabel.sizeThatFits(CGSize(width: 20, height: 20))
        
        self.saleOfLabel.text = DetailModal.textOfSize
        
        self.saleOfLabel.textColor = UIColor.customColor()
        
        self.saleOfLabel.font = UIFont.systemFontOfSize(10.0)
        
        self.saleOfLabel.layer.borderColor = UIColor.customColor().CGColor
    
        self.saleOfLabel.textAlignment = NSTextAlignment.Center
    
        self.saleOfLabel.contentMode = UIViewContentMode.Center
        
        self.saleOfLabel.layer.borderWidth = 1.0
        
        //self.saleOfLabel.hidden = true
        
        self.view.addSubview(self.saleOfLabel)
        
        self.titleOfLabel.text = DetailModal.titleOfLabel
        
        self.titleOfLabel.numberOfLines = 0
        
        self.titleOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleOfLabel.font = UIFont.systemFontOfSize(DetailModal.fontSizeOfTitleLabel)
        
        self.view.addSubview(self.titleOfLabel)
        
        let str = "Sale on extral 10% one learary cloth with code :" + DetailModal.saleOfCode
        
        self.saleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.saleImageView.image = DetailModal.imageOfSaleButton
        
        self.view.addSubview(self.saleImageView)
        
        self.saleOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.saleOfButton.text = str
        
        self.saleOfButton.numberOfLines = 0
        
        self.saleOfButton.font = UIFont.systemFontOfSize(10.0)
        
        self.saleOfButton.textColor = UIColor.customColor()
    
        
        self.view.addSubview(self.saleOfButton)
        
       // self.view.addSubview(self.saleOfButton)
        
        self.dividerOfImageView.image = DetailModal.imageOfDivider
        
        self.dividerOfImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.dividerOfImageView)
        
        self.colorPickOfLabel.text = "Color Pick"
        
        self.colorPickOfLabel.font = UIFont.systemFontOfSize(16.0)
        
        self.colorPickOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.colorPickOfLabel)
        
        self.colorPickOfContaint.translatesAutoresizingMaskIntoConstraints = false
        
        //self.colorPickOfContaint.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(self.colorPickOfContaint)
        
        self.sizeOfLabel.text = "Select Size"
        
        self.sizeOfLabel.font = UIFont.systemFontOfSize(16.0)
        
        self.sizeOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.sizeOfLabel)
        
        self.selectSizeOfContraint.translatesAutoresizingMaskIntoConstraints = false
        
        //self.selectSizeOfContraint.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(self.selectSizeOfContraint)
        
        self.colorPickOfGoogsImageview()
        
        //add constraint to sizeOfLabel
        if UIDevice.currentDevice().model == "iPhone"{
            
            self.sizeSelectedOfLabel()
            
        }else if UIDevice.currentDevice().model == "iPad"{
            
            self.sizeSelectedOfLabelAtIpad()
        }
        
        
        self.buttonOfContaint.translatesAutoresizingMaskIntoConstraints = false
        
       // self.buttonOfContaint.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(self.buttonOfContaint)
        
        self.buttonOfConstraint()
        
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        
        self.tableView!.estimatedRowHeight = 44.0
        
        self.tableView!.rowHeight = UITableViewAutomaticDimension
    
        self.tableView?.backgroundColor = UIColor.customWhite()
        
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView!)
        
        self.tableView!.backgroundColor = UIColor.whiteColor()
        
        self.tableView!.dataSource = self
        
        self.tableView!.delegate = self
        
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView!.showsVerticalScrollIndicator = false
        
        self.tableView!.registerClass(MUExpandTableViewCell.self, forCellReuseIdentifier: "cell")
    
        self.tableView?.registerClass(MUDetailHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        if UIDevice.currentDevice().model == "iPad" {
            
            self.detailView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(self.detailView)
        }

        self.commentOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.commentOfLabel.text = "Guests view"
        
        self.commentOfLabel.font = UIFont.systemFontOfSize(16.0)
        
        self.view.addSubview(self.commentOfLabel)
        
        self.commentOfView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.commentOfView)
        
        self.customSubViewsConstrain()
        
        self.commentOfViewWithSubView()
    }

   private func buttonOfConstraint(){
        
        var height = 30
        if UIDevice.currentDevice().model == "iPad"{
            
            height = 44
        }
        
        let rightOfButton = MUButton()
        
        rightOfButton.setTitle("Add to car", forState: UIControlState.Normal)
        
        rightOfButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        rightOfButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        rightOfButton.setImage(DetailModal.imageOfRightButton, forState: UIControlState.Normal)
        
        rightOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightOfButton.addTarget(self, action: #selector(MUDetaileViewController.addToCarButtonByTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.buttonOfContaint.addSubview(rightOfButton)
        
        let leftOfButton = MUButton()
        
        leftOfButton.setTitle("1", forState: UIControlState.Normal)
        
        leftOfButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        leftOfButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        leftOfButton.setImage(DetailModal.imageOfLeftButton, forState: UIControlState.Normal)
        
        leftOfButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftOfButton.addTarget(self, action: #selector(MUDetaileViewController.leftButtonByTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        buttonOfContaint.addSubview(leftOfButton)
        
        let vLeftButtonOfContaintVFL = "V:|-0-[leftOfButton(==height)]-0-|"
        
        let vLeftButtonOfContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLeftButtonOfContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["height" : height], views: ["leftOfButton" : leftOfButton])
        
        self.buttonOfContaint.addConstraints(vLeftButtonOfContaintConstraint)
        
        let hLeftButtonOfContaintVFL = "H:|-12-[leftOfButton]-0-[rightOfButton]-12-|"
        
        let hLeftButtonOfContaintConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hLeftButtonOfContaintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["leftOfButton" : leftOfButton,"rightOfButton" : rightOfButton])
        
        self.buttonOfContaint.addConstraints(hLeftButtonOfContaintConstraint)
        

    }
    
   private func customSubViewsConstrain(){
        
        var widthSpace = scrollViewWidth/2
        
        //let widthSpace = CGFloat(Int(UIScreen.mainScreen().bounds.size.width - scrollViewWidth - 3*space))
        
        var buttonHeight = 30
        
        var spaceHeight = 4
        
        var spacHeights = 24
        
        if UIDevice.currentDevice().model == "iPad"{
            
           widthSpace = CGFloat(Int(UIScreen.mainScreen().bounds.size.width - scrollViewWidth - 3*space))
            
            buttonHeight = 44
            
            spaceHeight = 12
            
            spacHeights = 12
        }
       
        //add constraint to scrollView
        let hScrollViewVFL = "H:|-12-[collectionView(==scrollViewWidth)]-12-[priceOfLabel]-(>=space)-[saleOfLabel]-12-|"
        
        let hScrollViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hScrollViewVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: ["space" : space,"scrollViewWidth" : scrollViewWidth], views: ["collectionView" : self.collectionView!,"priceOfLabel" : self.priceOfLabel,"saleOfLabel" : self.saleOfLabel])
        
        self.view.addConstraints(hScrollViewConstraint)
        
        // add constraint to V
        let vScrollViewVFL = "V:|-12-[collectionView(==scrollViewHeight)]-0-[pageController]"
        
        let vScrollViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vScrollViewVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: ["scrollViewHeight": scrollViewHeight], views: ["collectionView" : self.collectionView!,"pageController" : self.pageControll])
        
        self.view.addConstraints(vScrollViewConstraint)
        
        // add constraint to commentOfLabel
        let vConstraint = NSLayoutConstraint(item: self.commentOfLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        self.view.addConstraint(vConstraint)
        
        let vCon = NSLayoutConstraint(item: self.commentOfLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.pageControll, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraint(vCon)
        
        //add constraint to commentOfView
        let vCons = "V:[commentOfLabel]-8-[commentOfView]-12-[tableView]-0-|"
        
        let vConConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vCons, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["commentOfLabel" : commentOfLabel,"commentOfView" : commentOfView,"tableView" : self.tableView!])
        self.view.addConstraints(vConConstraint)
        
        //add constraint to priceOfLabel
        let vPriceOfLabelVFL    = "V:|-12-[priceOfLabel]-spaceHeight-[titleOfLabel]-12-[saleImageView]-spacHeights-[dividerOfImageView]"
        
        let vPriceOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vPriceOfLabelVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: ["spaceHeight" : spaceHeight,"spacHeights" : spacHeights], views: ["priceOfLabel" : self.priceOfLabel,"titleOfLabel" : self.titleOfLabel,"saleImageView" : self.saleImageView,"dividerOfImageView" : self.dividerOfImageView])
        
        self.view.addConstraints(vPriceOfLabelConstraint)
        
        //add constraint to sale Of label
        let vSaleOfLabelVFL    = "V:|-12-[saleOfLabel(==16)]-(>=12)-|"
        
        let vSaleOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSaleOfLabelVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["saleOfLabel" : self.saleOfLabel])
        
        self.view.addConstraints(vSaleOfLabelConstraint)
        
        let hSaleOfLabelConstraint = NSLayoutConstraint(item: self.saleOfLabel, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30)
        
        self.view.addConstraint(hSaleOfLabelConstraint)
        
        //add constraint to title Of label
        let hTitleOfLabelVFL    = "H:[titleOfLabel(<=widthSpace)]-(>=space)-|"
        
        let hTitleOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTitleOfLabelVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["space" : space,"widthSpace" : widthSpace], views: ["titleOfLabel" : self.titleOfLabel])
        
        self.view.addConstraints(hTitleOfLabelConstraint)
        
        // add constraint to sale of button
        let hSaleOfButtonVFL    = "H:[saleImageView]-[saleOfButton(<=widthSpace)]-(>=space)-|"
        
        let hSaleOfButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSaleOfButtonVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["space": space,"widthSpace":widthSpace], views: ["saleOfButton" : self.saleOfButton,"saleImageView" : self.saleImageView])
        
        self.view.addConstraints(hSaleOfButtonConstraint)
        
        //add constraint to colorPickOfLabel
        let vColorPickOfLabelVFL    = "V:[dividerOfImageView]-12-[colorPickOfLabel]-12-[colorPickOfContaint]-12-[sizeOfLabel]-12-[selectSizeOfContraint]-12-[buttonOfContaint(==buttonHeight)]"
        
        let vColorPickOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vColorPickOfLabelVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["buttonHeight" : buttonHeight,"detailView" : detailView], views: ["dividerOfImageView" : self.dividerOfImageView,"colorPickOfLabel" : self.colorPickOfLabel,"colorPickOfContaint" : self.colorPickOfContaint,"sizeOfLabel" : self.sizeOfLabel,"selectSizeOfContraint" : self.selectSizeOfContraint,"buttonOfContaint" : self.buttonOfContaint])
        self.view.addConstraints(vColorPickOfLabelConstraint)

        //add constraint to colorPickOfContaint
        let hColorPickOfConstraint = NSLayoutConstraint(item: self.colorPickOfContaint, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hColorPickOfConstraint)
        
        //add constraint to selectSizeOfContraint
        let hSelectSizeOfConstraint = NSLayoutConstraint(item: self.selectSizeOfContraint, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hSelectSizeOfConstraint)
        
        //add constraint to buttonOfContaint
        let hButtonOfContaint = NSLayoutConstraint(item: self.buttonOfContaint, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.collectionView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        self.view.addConstraint(hButtonOfContaint)
        
        let hButtonOfContaintVFL = NSLayoutConstraint(item: self.buttonOfContaint, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
        self.view.addConstraint(hButtonOfContaintVFL)
        
        
        let hTableViewVFL = "H:|-12-[tableView(==scrollViewWidth)]"
        
        let hTableViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTableViewVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: ["scrollViewWidth" : scrollViewWidth], views: ["tableView" : self.tableView!])
        
        self.view.addConstraints(hTableViewConstraint)

        
        if UIDevice.currentDevice().model == "iPad" {
            
            let vDetailViewVFL = "V:[buttonOfContaint]-0-[detailView]"
            
            let vDetailViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vDetailViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["buttonOfContaint" : buttonOfContaint,"detailView" : detailView])
            self.view.addConstraints(vDetailViewConstraint)
            
            let hDetailViewVFL = "H:|-12-[collectionView]-0-[detailView]-0-|"
            
            let hDetailViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hDetailViewVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["collectionView":collectionView!,"detailView" : detailView])
            
            self.view.addConstraints(hDetailViewConstraint)
            
            self.detailViewConstraint()
            

        }
    }
    
    func colorPickOfGoogsImageview(){
        
        var width:CGFloat = 30.0
        
         width = CGFloat((Int(UIScreen.mainScreen().bounds.size.width - scrollViewWidth - 5*space)/3))
        
        let imageView_00 = UIImageView()
        
        imageView_00.layer.borderColor = UIColor.customColor().CGColor
        
        imageView_00.layer.borderWidth = 2.0
        
        imageView_00.tag = 10
        
       self.setImageViewContaintSubView(imageView_00, cornerRadius: width)
        
        self.tempCurrentOfImageView = imageView_00
        
        let imageView_01 = UIImageView()
        
        imageView_01.tag = 11
        
        self.setImageViewContaintSubView(imageView_01, cornerRadius: width)
        
        let imageView_02 = UIImageView()
        
        imageView_02.tag = 12
        
        self.setImageViewContaintSubView(imageView_02, cornerRadius: width)
        
        let hSubViewVFL = "H:|-12-[imageView_00(==width)]-12-[imageView_01(==width)]-12-[imageView_02(==width)]"
        
        let hSubViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSubViewVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["width" : width], views: ["imageView_00" : imageView_00,"imageView_01" :imageView_01,"imageView_02" : imageView_02])
        
        
        self.colorPickOfContaint.addConstraints(hSubViewConstraint)
        
        let vSubViewVFL = "V:|-0-[imageView_01(==width)]-0-|"
        
        let vSubViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: ["width" : width], views: ["imageView_01" :imageView_01])
        
        self.colorPickOfContaint.addConstraints(vSubViewConstraint)

    }
    
    func setImageViewContaintSubView(imageView : UIImageView,cornerRadius : CGFloat){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUDetaileViewController.imageColorOfSelected(_:)))
        
        tap.delegate = self
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1

        imageView.layer.cornerRadius = cornerRadius/2.0
        
        imageView.layer.masksToBounds = true
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        let image = UIImage.getImageFromStr(self.imageArray![imageView.tag % 10] as! String)
        
        imageView.image = UIImage.resizeImage(image: image, size: CGSizeMake(cornerRadius, cornerRadius))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.userInteractionEnabled = true
        
        self.colorPickOfContaint.addSubview(imageView)
        
        imageView.addGestureRecognizer(tap)

    }
    
    func sizeSelectedOfLabel(){
        
        let sizeOfLabel_00 = UILabel()
        
        sizeOfLabel_00.text = "34"
        
        sizeOfLabel_00.layer.borderColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0).CGColor
        
        self.setSelectedContaintSubViews(sizeOfLabel_00)
        
        self.tempCurrentOfSizeLabel = sizeOfLabel_00
        
        
        
        let sizeOfLabel_01 = UILabel()
        
        sizeOfLabel_01.text = "36"
        
        self.setSelectedContaintSubViews(sizeOfLabel_01)
        
        let sizeOfLabel_02 = UILabel()
        
        sizeOfLabel_02.text = "38"
        
        self.setSelectedContaintSubViews(sizeOfLabel_02)
        
        let sizeOfLabel_03 = UILabel()
        
        sizeOfLabel_03.text = "40"
        
        self.setSelectedContaintSubViews(sizeOfLabel_03)
        
        for (index,element) in self.selectSizeOfContraint.subviews.enumerate() {
            
            let num = Int(self.sizeArray![index] as! NSNumber)
            
            if element.isKindOfClass(UILabel) &&  !Bool(num){
                
                let label =  element as! UILabel
                
                label.userInteractionEnabled = false
                
                label.backgroundColor = UIColor.lightGrayColor()
                
            }
            
            //print("index=\(index)")
            
        }
        
       // print("subViews = \(self.selectSizeOfContraint.subviews)")
        
        let width = CGFloat((Int(UIScreen.mainScreen().bounds.size.width - scrollViewWidth - 4*space)/2))
        
        let hSubViewOfLabelVFL = "H:|-12-[sizeOfLabel_00(==width)]-12-[sizeOfLabel_01(==width)]-12-|"
        
        let hSubViewOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSubViewOfLabelVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["width" : width], views: ["sizeOfLabel_00" : sizeOfLabel_00,"sizeOfLabel_01" :sizeOfLabel_01])
        
        selectSizeOfContraint.addConstraints(hSubViewOfLabelConstraint)
        
        let vSubViewOfLabelVFL = "V:|-0-[sizeOfLabel_00(==22)]"
        
        let vSubViewOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubViewOfLabelVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["sizeOfLabel_00" :sizeOfLabel_00])
        
        selectSizeOfContraint.addConstraints(vSubViewOfLabelConstraint)
        
        
        let hSubViewOfLabelVFL_00 = "H:|-12-[sizeOfLabel_02(==width)]-12-[sizeOfLabel_03(==width)]-12-|"
        
        let hSubViewOfLabelConstraint_00 = NSLayoutConstraint.constraintsWithVisualFormat(hSubViewOfLabelVFL_00, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["width":width], views: ["sizeOfLabel_02" : sizeOfLabel_02,"sizeOfLabel_03" :sizeOfLabel_03])
        
        selectSizeOfContraint.addConstraints(hSubViewOfLabelConstraint_00)
        
        let vSubViewOfLabelVFL_00 = "V:[sizeOfLabel_00]-12-[sizeOfLabel_02(==22)]-0-|"
        
        let vSubViewOfLabelConstraint_00 = NSLayoutConstraint.constraintsWithVisualFormat(vSubViewOfLabelVFL_00, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["sizeOfLabel_00" :sizeOfLabel_00,"sizeOfLabel_02" : sizeOfLabel_02])
        
        selectSizeOfContraint.addConstraints(vSubViewOfLabelConstraint_00)

    }
    
    func sizeSelectedOfLabelAtIpad(){
        
        let sizeOfLabel_00 = UILabel()
        
        sizeOfLabel_00.text = "34"
        
        self.setSelectedContaintSubViews(sizeOfLabel_00)
        
        sizeOfLabel_00.layer.borderColor = UIColor.customColor().CGColor
        
        self.tempCurrentOfSizeLabel = sizeOfLabel_00
        
        
        let sizeOfLabel_01 = UILabel()
        
        sizeOfLabel_01.text = "36"
        
        self.setSelectedContaintSubViews(sizeOfLabel_01)
        
        let sizeOfLabel_02 = UILabel()
        
        sizeOfLabel_02.text = "38"
        
        self.setSelectedContaintSubViews(sizeOfLabel_02)
        
        
        let sizeOfLabel_03 = UILabel()
        
        sizeOfLabel_03.text = "40"
        
        self.setSelectedContaintSubViews(sizeOfLabel_03)
        
        let sizeOfLabel_04 = UILabel()
        
        sizeOfLabel_04.text = "42"
        
        self.setSelectedContaintSubViews(sizeOfLabel_04)
        
        let sizeOfLabel_05 = UILabel()
        
        sizeOfLabel_05.text = "44"
        
        self.setSelectedContaintSubViews(sizeOfLabel_05)
        
        for (index,element) in self.selectSizeOfContraint.subviews.enumerate() {
            
            let num = Int(self.sizeArray![index] as! NSNumber)
            
            if element.isKindOfClass(UILabel) && !Bool(num){
                
                let label =  element as! UILabel
                
                label.userInteractionEnabled = false
                
                label.backgroundColor = UIColor.customGrayColor()

            }
            
            
            
        }
        
       let width:CGFloat = CGFloat((Int(UIScreen.mainScreen().bounds.size.width - scrollViewWidth - 5*space)/3))
        
        let hSubViewOfLabelVFL = "H:|-12-[sizeOfLabel_00(==width)]-12-[sizeOfLabel_01(==width)]-12-[sizeOfLabel_02(==width)]-12-|"
        
        let hSubViewOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSubViewOfLabelVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["width" : width], views: ["sizeOfLabel_00" : sizeOfLabel_00,"sizeOfLabel_01" :sizeOfLabel_01,"sizeOfLabel_02" : sizeOfLabel_02])
        
        selectSizeOfContraint.addConstraints(hSubViewOfLabelConstraint)
        
        let vSubViewOfLabelVFL = "V:|-0-[sizeOfLabel_00(==30)]"
        
        let vSubViewOfLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vSubViewOfLabelVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["sizeOfLabel_00" :sizeOfLabel_00])
        
        selectSizeOfContraint.addConstraints(vSubViewOfLabelConstraint)
        
        
        let hSubViewOfLabelVFL_00 = "H:|-12-[sizeOfLabel_03(==width)]-12-[sizeOfLabel_04(==width)]-12-[sizeOfLabel_05(==width)]-12-|"
        
        let hSubViewOfLabelConstraint_00 = NSLayoutConstraint.constraintsWithVisualFormat(hSubViewOfLabelVFL_00, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: ["width" : width], views: ["sizeOfLabel_03" : sizeOfLabel_03,"sizeOfLabel_04" :sizeOfLabel_04,"sizeOfLabel_05" : sizeOfLabel_05])
        
        selectSizeOfContraint.addConstraints(hSubViewOfLabelConstraint_00)
        
        let vSubViewOfLabelVFL_00 = "V:[sizeOfLabel_00]-12-[sizeOfLabel_03(==sizeOfLabel_00)]-0-|"
        
        let vSubViewOfLabelConstraint_00 = NSLayoutConstraint.constraintsWithVisualFormat(vSubViewOfLabelVFL_00, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["sizeOfLabel_00" :sizeOfLabel_00,"sizeOfLabel_03" : sizeOfLabel_03])
        
        selectSizeOfContraint.addConstraints(vSubViewOfLabelConstraint_00)
    }
    
    func setSelectedContaintSubViews(label : UILabel){
        
        label.layer.borderWidth = 2.0
        
        label.layer.borderColor = UIColor.customBlack().CGColor
        
        label.textAlignment = NSTextAlignment.Center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFontOfSize(10.0)
        
        label.userInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MUDetaileViewController.sizeLabelOfTap(_:)))
        
        tap.delegate = self
        
        tap.numberOfTapsRequired = 1
        
        tap.numberOfTouchesRequired = 1
        
        label.addGestureRecognizer(tap)
        
        self.selectSizeOfContraint.addSubview(label)
    }
    
   private func detailViewConstraint(){
        
        let tLabel = UILabel()
        
        let dLabel = UILabel()
        
        let shippmentIcon = UIImageView()
        
        let returnsIcon = UIImageView()
        
        let rTLabel = UILabel()
        
        let rDLabel = UILabel()
        
        rDLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rTLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.detailView.addSubview(rTLabel)
        
        self.detailView.addSubview(rDLabel)
        
        rDLabel.text = "Enjoy free returns on your order."
        
        rDLabel.font = UIFont.systemFontOfSize(12.0)
        
        rDLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        rDLabel.numberOfLines = 0
        
        rTLabel.textColor = UIColor.customBlack()
        
        rTLabel.font = UIFont.systemFontOfSize(16.0)
        
        rTLabel.text = "Complimentary Returns:"
        
        
        
        returnsIcon.translatesAutoresizingMaskIntoConstraints = false
        
        shippmentIcon.translatesAutoresizingMaskIntoConstraints = false
        
        self.detailView.addSubview(returnsIcon)
        
        self.detailView.addSubview(shippmentIcon)
        
        returnsIcon.image = UIImage(named: "Repeat")
        
        shippmentIcon.image = UIImage(named: "Truck")
        
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.detailView.addSubview(tLabel)
        
        self.detailView.addSubview(dLabel)
        
        tLabel.text = "Complimentary Shippment:"
        
        tLabel.textColor = UIColor.customBlack()
        
        tLabel.font = UIFont.systemFontOfSize(16.0)
        
        dLabel.text = "Complimentary delivery within is 1-5 days from the shipping of date."
        
        dLabel.font = UIFont.systemFontOfSize(12.0)
        
        dLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        dLabel.numberOfLines = 0
        
        let hConVFL = "H:|-12-[shippmentIcon(==24)]-12-[tLabel]|"
        
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hConVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["shippmentIcon":shippmentIcon,"tLabel" : tLabel])
        self.detailView.addConstraints(hConstraint)
        
        let vConstraint = NSLayoutConstraint(item: tLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.detailView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        self.view.addConstraint(vConstraint)
        
        let dLabelConstraint = NSLayoutConstraint(item: dLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: tLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.view.addConstraint(dLabelConstraint)
        
        let hDLabelConstraint = NSLayoutConstraint(item: dLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.detailView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.view.addConstraint(hDLabelConstraint)
        
        let hDLabelConstraintLeft = NSLayoutConstraint(item: dLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: tLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hDLabelConstraintLeft)
        
        //aadd constraint to returnsIcon
        let vReturnsIconConstraint = NSLayoutConstraint(item: returnsIcon, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: dLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.view.addConstraint(vReturnsIconConstraint)
        
        let hReturnsIconConstraint = NSLayoutConstraint(item: returnsIcon, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: shippmentIcon, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hReturnsIconConstraint)
        
        //add constraint to rTlabel
        
        let hRConVFL = "H:|-12-[returnsIcon(==24)]-12-[rTLabel]|"
        
        let hRConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hRConVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["returnsIcon":returnsIcon,"rTLabel" : rTLabel])
        
        self.detailView.addConstraints(hRConstraint)
        
        //add constraint to rDlable
        let rDLabelConstraint = NSLayoutConstraint(item: rDLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: rTLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12.0)
        
        self.view.addConstraint(rDLabelConstraint)
        
        let hRDLabelConstraint = NSLayoutConstraint(item: rDLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.detailView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.view.addConstraint(hRDLabelConstraint)
        
        let hRDLabelConstraintLeft = NSLayoutConstraint(item: rDLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: rTLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hRDLabelConstraintLeft)

        
        

    }
    
   private func commentOfViewWithSubView(){
        
        let imageV_00 = UIImageView()
        
        imageV_00.translatesAutoresizingMaskIntoConstraints = false
        
        imageV_00.image = UIImage(named: "comment-icon-none")
        
        self.commentOfView.addSubview(imageV_00)
        
        let imageV_01 = UIImageView()
        
        imageV_01.translatesAutoresizingMaskIntoConstraints = false
        
        imageV_01.image = UIImage(named: "comment-icon-none")
    
        
        self.commentOfView.addSubview(imageV_01)
        
        let imageV_02 = UIImageView()
        
        imageV_02.translatesAutoresizingMaskIntoConstraints = false
        
        imageV_02.image = UIImage(named: "comment-icon-none")
        
        self.commentOfView.addSubview(imageV_02)
        
        let imageV_03 = UIImageView()
        
        imageV_03.translatesAutoresizingMaskIntoConstraints = false
        
        imageV_03.image = UIImage(named: "comment-icon-none")
        
        self.commentOfView.addSubview(imageV_03)
        
        let imageV_04 = UIImageView()
        
        imageV_04.translatesAutoresizingMaskIntoConstraints = false
        
        imageV_04.image = UIImage(named: "comment-icon-none")
    
        self.commentOfView.addSubview(imageV_04)
        
        let hConstraintVFL = "H:|-12-[imageV_00]-12-[imageV_01]-12-[imageV_02]-12-[imageV_03]-12-[imageV_04]-12-|"
        
        let hConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["imageV_00" : imageV_00,"imageV_01" : imageV_01,"imageV_02" : imageV_02,"imageV_03" : imageV_03,"imageV_04" : imageV_04])
        
        let vConstraintVFL = "V:|-0-[imageV_00]-0-|"
        
        let vConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["imageV_00" : imageV_00])
        
        self.commentOfView.addConstraints(vConstraint)
        
        self.commentOfView.addConstraints(hConstraint)
    
        self.addCustomCommentImage()
    

    }
    
   private func addCustomCommentImage() {
        
        var commentNumber = Int((self.DetailModal.numberOfCommentImages)!)
        
        if commentNumber >= 5 {
            
            commentNumber = 5
        }
        
        for (index,element) in commentOfView.subviews.enumerate() {
            
            if index < commentNumber{
                
                if element.isKindOfClass(UIImageView){
                    
                    let imageview = element as! UIImageView
                    
                    imageview.image = UIImage(named: "comment-icon-normal_24px")
                    
                }
                
            }
        }
        
        if commentNumber <= 3 {
            
            let imageView = commentOfView.subviews[commentNumber] as! UIImageView
            
            if ((self.DetailModal.numberOfCommentImages)! - Float(commentNumber) >= 0.5){
                
                imageView.image = UIImage(named: "comment-icon-half")
                
            }
            
        }
        
        
    }

    
    func addCustomTimer(){
        
        self.timer = NSTimer(timeInterval: 2.0, target: self, selector: #selector(MUDetaileViewController.autoScrollToNextItem), userInfo: nil, repeats: true)
        
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    
    }
    
    func autoScrollToNextItem() {
        
        
    }
    
    func removeCustomTimer(){
        
        self.timer?.invalidate()
        
        self.timer = nil
    }
    
    func imageColorOfSelected(tap:UITapGestureRecognizer){
        
        let imageView = tap.view as! UIImageView
        
        let tempNum = imageView.tag % 10 + 498
        
        if tap.numberOfTouches() == 1{
            
            if (tap.view != self.tempCurrentOfImageView){
                
                imageView.layer.borderWidth = 2.0
                
                
                imageView.layer.borderColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0).CGColor
                
                self.tempCurrentOfImageView?.layer.borderWidth = 2.0
                
                self.tempCurrentOfImageView?.layer.borderColor = UIColor.clearColor().CGColor
                
                self.tempCurrentOfImageView = imageView
                
                self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow: tempNum, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                
                self.pageControll.currentPage = imageView.tag % 10

                
               // self.removeCustomTimer()
                
            }
        }
        
        
    }
    
    func sizeLabelOfTap(tap:UITapGestureRecognizer){
        
        let sizeLabel = tap.view as! UILabel
        
        if tap.numberOfTouches() == 1{
            
            if (tap.view != self.tempCurrentOfSizeLabel){
                
                sizeLabel.layer.borderWidth = 2.0
                
                sizeLabel.layer.borderColor = UIColor.customColor().CGColor
                
                self.tempCurrentOfSizeLabel?.layer.borderColor = UIColor.customBlack().CGColor
                
               // self.tempCurrentOfSizeLabel?.layer.borderColor = UIColor.clearColor().CGColor
                
                self.tempCurrentOfSizeLabel = sizeLabel
                
            }else{
                
                
            }
        }

    }
    
    func leftButtonByTouch(button:MUButton){
        
        if self.numberOfBuy < 3{
            
             self.numberOfBuy = self.numberOfBuy + 1
            
            button.setTitle(String(stringInterpolationSegment: self.numberOfBuy), forState: UIControlState.Normal)
            
            button.titleLabel?.font = UIFont.systemFontOfSize(12.0)
            
            button.titleLabel?.textAlignment = NSTextAlignment.Center
        }
    }
    
    func addToCarButtonByTouch(button : UIButton) {
        
        
        //imageName,price,title,size,color,time,date
        let tempShoppingData = NSMutableArray()
        
        let imageName = self.imageArray![(self.tempCurrentOfImageView?.tag)! % 10] as! String
        //add imageName
        tempShoppingData.addObject(imageName)
        
        //add price
        tempShoppingData.addObject(self.DetailModal.textOfPrice!)
        
        //add title
        tempShoppingData.addObject(self.DetailModal.titleOfLabel!)
        
        //add size
        tempShoppingData.addObject((self.tempCurrentOfSizeLabel?.text)! as String)
        
        let color = self.colorDict?.valueForKey(imageName) as! String
        
        //add color
         tempShoppingData.addObject(color)
        
        //add time
        let date = NSDate()
        
        let dateStr = "\(date)"
        tempShoppingData.addObject(dateStr)
        
        //add date
        let format = NSDateFormatter()
        
        format.dateFormat = "yyyy/MM/dd"
        
        let formatDate = format.stringFromDate(date)
        
        tempShoppingData.addObject(formatDate)
        
        //add promo code
        tempShoppingData.addObject(DetailModal.saleOfCode)
        
        MUSQLiteDatabaseShoppingCarTool.createDataBase()
        
        MUSQLiteDatabaseShoppingCarTool.writeDataToDatabase(tempShoppingData as NSArray)
        
        //shoppingCar values add 1
        MUButtonBdageTool.setAddButtonBadgeValues()
        
        let shoppingCarValues = MUButtonBdageTool.getButtonBadgeValues()
        
        self.shoppingOfButton.badgeValue = "\(shoppingCarValues)"
        
        //print("======================\(tempShoppingData)")
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.imageArray?.count)! * 1000
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MUCycleCollectionViewCell
        
        let str = self.imageArray![indexPath.item % (self.imageArray?.count)!] as! String
        
        let image = UIImage.getImageFromStr(str)
        
       cell.image = UIImage.resizeImage(image: image, size: CGSizeMake(self.scrollViewWidth, self.scrollViewHeight))
        
        //cell.delegate = self
        
        cell.indexPath = indexPath
        
        //cell.imageArray = self.imageArray
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
     
    
        return (self.modalArray?.count)!
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        let modal = self.modalArray![section] as! NSMutableArray
        
        var numberRows = 1
        
        if section == 1{
           
            if self.isClicked {
                
                //print("===========================")
                numberRows = modal.count
                
            }else{
                
                return 1
            }
        }else{
            
            numberRows = modal.count
        }
        
        return numberRows
        
     }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        if section == 0 {
//            
//            return "Design"
//        }else if section == 1{
//            
//            return "Comments"
//        }else{
//           
//            return "Dimension"
//        }
//        
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("header") as!
        MUDetailHeaderFooterView
        
        //headerView.frame = CGRectMake(0, 0, tableView.frame.width, 30.0)
        
        if section == 0 {
            
            headerView.title = "Design concept"
            
            headerView.iconImage = UIImage(named: "design-icon_black")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
        }else if section == 1{
            
            headerView.title = "Comments"
            
            headerView.iconImage = UIImage(named: "comment-icon_black")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
        }else{
            
             headerView.title = "Dimension"
            
             headerView.iconImage = UIImage(named: "ruler_black")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
        headerView.section = section
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? MUExpandTableViewCell
        
        cell?.textLabel?.text = nil
        
        cell?.imageView?.image = nil
        
        cell?.removeTextLabel()
        
        cell!.indexPath = indexPath
        
        let modal = self.modalArray![indexPath.section] as? NSMutableArray
        
        cell!.modal = modal![indexPath.row] as? MUExpandCellModal
        
       // print("=====================\(modal!.count)")
        
        cell!.delegate = self
     
        if self.cellByClickedIndexPath?.count > 0 {
            
           // print("=====================\(cell?.modal?.detailDecription)")
            for preIndexPath in self.cellByClickedIndexPath! {
                
                
                    if (preIndexPath as! NSIndexPath) == indexPath {
                        
                        //if you not use GCD,it will not refresh data
                     dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                        cell?.addTextLable(indexPath)
                        
                      })
                    
                    }
            }
        }
        
        if self.isClicked && indexPath.section == 1 && indexPath.row != 0 {
            
            cell?.addTextLable(indexPath)
        }
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell!
    }
    
        
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var page = 0
        
        if self.imageArray?.count > 0 {
            
          page = Int(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % (self.imageArray?.count)!
        }
        
        
        self.pageControll.currentPage = page
        
       //self.saleOfLabel.re
        
    }

    func labelTextByClick(rowHeight: CGFloat, indexPath: NSIndexPath) {
    
        
        tempArray!.addObject(indexPath)
        
            if self.tempArray?.count >= 2 {
                
                self.cellByClickedIndexPath = self.tempArray!.sortedArrayUsingComparator({ (indexPath1, indexPath2) -> NSComparisonResult in
                    
                    
                    let object1 = (indexPath1 as! NSIndexPath).section
                    
                    let object2 =  (indexPath2 as! NSIndexPath).section
                    
                    if object1 > object2 {
                        
                        return NSComparisonResult.OrderedDescending
                    }else if object1 < object2 {
                        
                        return NSComparisonResult.OrderedAscending
                    }else{
                        
                        return NSComparisonResult.OrderedSame
                    }
                    
                })
            }else{
                
                self.cellByClickedIndexPath = self.tempArray
                
            }
        
        if indexPath.section == 1 {
            
            self.isClicked = true
        }
        
        let text = "MU" + "\(indexPath.section)" + "\(indexPath.row)"
        
        SQLiteDatabaseTool.createDataBase()
        
        SQLiteDatabaseTool.writeDataToDatabase(text, rowHeight: Int(rowHeight))
           
        //if SQLiteDatabaseTool.isHaveDataInCloumn(text) {
            
            SQLiteDatabaseTool.updateDataToDatabase([Int(rowHeight),text])
       // }
        
        //if you use global refresh,  early data appear to refresh
             //self.tableView!.reloadData()
        
        //self.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
        self.tableView?.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
 }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight:CGFloat = 44.0
        
        if self.cellByClickedIndexPath?.count > 0 {
            
            for preIndexPath in self.cellByClickedIndexPath! {
                
                if (preIndexPath as! NSIndexPath) == indexPath {
                    
                  let text = "MU" + "\(indexPath.section)" + "\(indexPath.row)"
                
                  rowHeight = SQLiteDatabaseTool.queryDataFromDataBase(text)
                    
                }
            }
        }
        
        if self.isClicked && indexPath.section == 1 && indexPath.row != 0 {
            
            rowHeight = 100.0
        }
        
        return rowHeight
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44.0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
       let imageViewController = MUImageViewController()
        
        let str = self.imageArray![indexPath.item % (self.imageArray?.count)!] as! String
        
        imageViewController.imageArray = SQLiteDatabaseTool.openDatabaseForImage(str)
        
       // print("======================================\(indexPath.item)=======\( imageViewController.imageArray?.count)")
        
        self.presentViewController(imageViewController, animated: true, completion: nil)
        
        self.navigationView.removeFromSuperview()
        
        //self.navigationController?.pushViewController(imageViewController, animated: true)
    }

}
