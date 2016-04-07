//
//  MUMeMoreOrderDetailViewController.swift
//  Wild
//
//  Created by Adaman on 3/21/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit



class MUMeMoreOrderDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MUCommentDelegate{

    var modalArray:NSMutableArray?
    
    private var tableView:UITableView?
    
    private var navigationView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView = UITableView(frame: self.view.frame)
        
        self.tableView?.registerClass(MUMeOrderDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView?.estimatedRowHeight = 92.0
        
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView?.dataSource = self
        
        self.tableView?.delegate = self
        
        self.view.addSubview(self.tableView!)
        
        self.customBackItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.navigationView?.removeFromSuperview()
    }
    
    private func customBackItem() {
        
        self.navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        let lButton:UIButton = UIButton()
        
        lButton.addTarget(self, action: #selector(MUMeMoreOrderDetailViewController.handlerBackItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        
        lButton.setImage(UIImage(named:"back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.setBackgroundImage(UIImage(named:"menu_highlight")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        
        lButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView!.addSubview(lButton)
        
        let backButtonConstraint_spaceOfLeft = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Left, multiplier:1.0, constant: 12)
        
        let backButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hbackButtonConstraint_center = NSLayoutConstraint(item: lButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: navigationView, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 30.0)
        
        
        navigationView!.addConstraints([backButtonConstraint_spaceOfLeft,backButtonConstraint_center,hbackButtonConstraint_center])
        
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
    }
    
    func handlerBackItem(button : UIButton) {
        
        self.navigationView?.removeFromSuperview()
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return (self.modalArray?.count)!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MUMeOrderDetailTableViewCell
        
        cell.modal = self.modalArray![indexPath.row] as? MUMeOrderedGoodsModal
        
        cell.indexPath = indexPath
        
        if ((cell.modal?.commentStatus) != 0) {
            
            cell.commenText = MUSQLiteCommentTool.querryDataInDatabase(cell.modal!.saleCode!, query: cell.modal!.email!)
            
             cell.preScore = MUSQLiteCommentTool.querryScoreInDatabase(cell.modal!.saleCode!, query: cell.modal!.email!)
        }
        cell.delegate = self
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 228.0
        }else{
            
            return 194.0
        }
    }
    
    func submitButtonByclickError(alertText: String, flag: Bool, indexPath: NSIndexPath) {
        
        if flag {
            
            let tempModal = self.modalArray![indexPath.row] as? MUMeOrderedGoodsModal
            
            tempModal?.commentStatus = 1
        }
        
        self.alertView(alertText)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
