//
//  MUMenuViewController.swift
//  Wild
//
//  Created by Adaman on 3/19/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate {

    //private let navigationViewController = MUNavigationController(rootViewController:MUContentViewController())
   private var tableView                = UITableView()
    
   private var menuList                 = NSArray()
    
   private var con = NSLayoutConstraint()
    
   private var lLabel:UILabel?
    
   private var is_login:Bool = false
    
    var delegate:MUDelegate?
    
    private var indexPath:NSIndexPath?
    //var imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //self.title = "Welcome"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(18.0),NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let filePath = NSBundle.mainBundle().pathForResource("menuList", ofType: "plist")
        menuList = NSArray(contentsOfFile: filePath!)!
        
        //self.view.addConstraint(con)
        
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        
        self.tableView.dataSource = self
        
        self.tableView.delegate = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.backgroundColor = UIColor.customWhite()
        
        self.tableView.rowHeight = 64.0
        
        //print(self.tableView.rowHeight)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let preIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        
        self.tableView.selectRowAtIndexPath(preIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        
        self.indexPath = preIndexPath
        
        
        self.view.addSubview(self.tableView)
        
        let width = self.view.frame.width * 2/3
        
        //set up leftBarItem
        
        lLabel = UILabel()
        
        lLabel!.text = "Welcome"
        
        lLabel!.frame = CGRectMake(0, 0, width, 30)
        
        lLabel!.font = UIFont.systemFontOfSize(18.0)
        
        lLabel!.textColor = UIColor.customWhite()
        
        lLabel!.textAlignment = NSTextAlignment.Left
        
        let LBarItem = UIBarButtonItem(customView: lLabel!)
        
        self.navigationItem.leftBarButtonItem = LBarItem
        
        //set up rightBarItem
        let rButton = UIButton()
        
        rButton.frame = CGRectMake(0, 0, 60, 30)
        
        rButton.setTitle("Sign in", forState: UIControlState.Normal)
        
        rButton.setTitleColor(UIColor.customWhite(), forState: UIControlState.Normal)
        
        rButton.addTarget(self, action: #selector(MUMenuViewController.handlerLogin(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let rBarItem = UIBarButtonItem(customView: rButton)
        
        self.navigationItem.rightBarButtonItem = rBarItem
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("username") != nil) {
            
            let object = NSUserDefaults.standardUserDefaults().valueForKey("username")
            
            self.lLabel?.text = "Hi," + (object as! String)
            
            self.is_login = true
            
            rButton.setTitle("Logout", forState: UIControlState.Normal)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
   
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    func handlerNotification(notification : NSNotification) {
        
       // delegate?.loginViewDismiss!()
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("username") != nil) {
            
            let object = NSUserDefaults.standardUserDefaults().valueForKey("username")
            
            self.lLabel?.text = "Hi," + (object as! String)
            
            self.is_login = true
        }
        
    }
    func handlerLogin(button : UIButton) {
        
        var is_loggin = false
        
        
        if self.is_login {
            
            MUCleareCacheTool.CleareCache()
            
            self.lLabel?.text = "Welcome"
            
            self.is_login = false
            
            button.setTitle("Sing In", forState: UIControlState.Normal)
            
            delegate?.handlerLoginButton!(false)
            
            NSNotificationCenter.defaultCenter().postNotificationName("loggedinInfo", object: is_loggin)
            
        }else{
            
            delegate?.handlerLoginButton!(true)
            
            is_loggin = true
            
             NSNotificationCenter.defaultCenter().postNotificationName("loggedinInfo", object: is_loggin)

        }
        
       
        
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = menuList[indexPath.row] as? String
        
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.text)!, size: 36.0)
        
        cell.textLabel?.textColor = UIColor.customBlack()
        
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        
        if (self.indexPath != nil) {
            
            if self.indexPath == indexPath {
                
                cell.textLabel?.textColor = UIColor.customColor()
            }
        }else{
            
            if indexPath.row == 0 {
                
                cell.textLabel?.textColor = UIColor.customColor()
            }
        }
        
        
        //cell.backgroundColor = UIColor.brownColor()
        //print("234254")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.textLabel?.textColor = UIColor.customColor()
        
        let preCell = tableView.cellForRowAtIndexPath(self.indexPath!)
        
        preCell?.textLabel?.textColor = UIColor.customBlack()
        
        self.indexPath = indexPath
        
    }

}
