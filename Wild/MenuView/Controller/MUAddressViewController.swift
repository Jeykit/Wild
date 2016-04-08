//
//  MUAddressViewController.swift
//  Wild
//
//  Created by Adaman on 4/2/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUAddressViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MUAddressDelegate {

    private var navigationView:UIView?
    
    private var collectionView:UICollectionView?
    
    private var addressView:MUAddAddressInfoView?
    
    private var modalArray:NSMutableArray?
    
    var tempModal:MUAddressModal?
    
    var navView:UIView?
    
    var currentIndexPath:NSIndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.customGrayColor()
        
        self.customCollectionView()
        
        self.title = "Address"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(18.0),NSForegroundColorAttributeName : UIColor.whiteColor()]
        //let sview = MUAddressView(frame: CGRectMake(12.0,12.0,240.0,148.0))
        
        
    }

    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
        
        self.customBackItem()
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
            
            MUSQLiteAddressTool.createDataBase()
            
            self.modalArray = MUSQLiteAddressTool.readAddressDataFromDatabase(email)
            
        }else{
            
            self.modalArray = []
        }

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationView?.removeFromSuperview()
        
        self.modalArray = nil
        
        if (self.tempModal != nil) {
            
            if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
                
                let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
                
                let modal = MUSQLiteAddressTool.querryDefalutAddressInDatabase(email)
                
                if (modal.date != nil) {
                    
                    MUSQLiteAddressTool.updateDefalutAddressToDatabase(0, date: modal.date!, email: modal.email!)
                }
                
                 MUSQLiteAddressTool.updateDefalutAddressToDatabase(1, date: (self.tempModal?.date)!,email: (self.tempModal?.email)!)
            }

        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func customCollectionView() {
        
        let itemHeight:CGFloat = 148.0
        
        var itemWidth:CGFloat  = 1.0
        
        itemWidth = (UIScreen.mainScreen().bounds.width - 4*12)/3
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight)
        
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        flowLayout.sectionInset = UIEdgeInsetsMake(12,12, 12.0, 12.0)
        
        flowLayout.minimumInteritemSpacing = 0
        
        flowLayout.minimumLineSpacing = 12.0
        
        //print(flowLayout.itemSize)
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 180.0), collectionViewLayout: flowLayout)
        
        self.view.addSubview(collectionView!)
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
        collectionView!.backgroundColor = UIColor.customWhite()
        
        self.collectionView?.pagingEnabled = true
        
        collectionView!.alwaysBounceHorizontal = true
        
       // collectionView?.bounces = false
        
        collectionView!.showsHorizontalScrollIndicator = false
        
        collectionView!.showsVerticalScrollIndicator   = false
        
        collectionView!.userInteractionEnabled = true
        
        collectionView!.dataSource = self
        
        collectionView!.delegate = self

        collectionView!.registerClass(MUAddressCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.addressView = MUAddAddressInfoView(frame: CGRectMake(0,192.0,self.view.frame.width,434.0))
        
        //print("==============\(sview.textHeight)")
        
        self.addressView!.backgroundColor = UIColor.customGrayColor()
        
        self.addressView?.delegate = self
        
        self.view.addSubview(self.addressView!)
        
    }
    
    private func customBackItem() {
        
        self.navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        let lButton:UIButton = UIButton()
        
        lButton.addTarget(self, action: #selector(MUAddressViewController.handlerBackItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView!.addSubview(lButton)
        
        let backButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant: 12)
        
        let backButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hbackButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        
        navigationView!.addConstraints([backButtonConstraint_spaceOfLeft,backButtonConstraint_center,hbackButtonConstraint_center])
        
        
        let editButton = UIButton()
        
        editButton.addTarget(self, action: #selector(MUAddressViewController.handlerEditButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        editButton.setImage(UIImage(named:"add_address_new")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        editButton.setImage(UIImage(named:"add_address_new")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        editButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView!.addSubview(editButton)
        
        let editButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: editButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Right, multiplier:1.0, constant: -12)
        
        let editButtonConstraint_center = NSLayoutConstraint(item: editButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let heditButtonConstraint_center = NSLayoutConstraint(item: editButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        let veditButtonConstraint_center = NSLayoutConstraint(item: editButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 30.0)
        
        navigationView!.addConstraints([editButtonConstraint_spaceOfLeft,editButtonConstraint_center,heditButtonConstraint_center,veditButtonConstraint_center])
        
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
    }
    
    func handlerEditButton(button : MUButton) {
        
        let modal = MUAddressModal()
        
        self.addressView?.updateInfo(modal,flag: false)
    }
    
    func handlerBackItem(button : UIButton) {
        
        self.navigationView?.removeFromSuperview()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.modalArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MUAddressCollectionViewCell
        
        cell.addressView?.delegate = self
        
        cell.indexPath = indexPath
        
        cell.delegate = self

        let tempModal = self.modalArray![indexPath.row] as! MUAddressModal
        
        if (self.currentIndexPath != nil) {
            
            if self.currentIndexPath == indexPath {
                
                 tempModal.defalut = 1
                
                self.tempModal = tempModal
            }else{
                
                tempModal.defalut = 0
            }
           
        }
        cell.modal = tempModal
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0,12, 12.0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        
        let itemHeight:CGFloat = 148.0
        
        let itemWidth = (UIScreen.mainScreen().bounds.width - 4*12)/3
        
         return CGSizeMake(itemWidth, itemHeight)
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }

    func editButtonByClicked(modal: MUAddressModal, indexPath: NSIndexPath) {
        
        self.currentIndexPath = indexPath
        
        self.addressView?.updateInfo(modal, flag: true)
        
        self.collectionView?.reloadData()
    }
    
    func checkedImageViewByTap(indexPath: NSIndexPath) {
        
        self.currentIndexPath = indexPath
        
        self.collectionView?.reloadData()
        
    }
    
    func addNewDataToDatabase() {
        
        let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
        
        self.modalArray = MUSQLiteAddressTool.readAddressDataFromDatabase(email)
        
        self.collectionView?.reloadData()
    }
    
    func emptyEmail() {
        
        self.alertView("you are not logged in")
    }
    private func alertView(text:String) {
        
        let alertViewController = UIAlertController(title: "Tips", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let tureAction = UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertViewController.addAction(tureAction)
        
        let dismissAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Destructive) { (action) in
            
            alertViewController.dismissViewControllerAnimated(true, completion: nil)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertViewController.addAction(dismissAction)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }

}
