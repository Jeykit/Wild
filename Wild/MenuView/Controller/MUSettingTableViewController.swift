//
//  MUSettingTableViewController.swift
//  Wild
//
//  Created by Adaman on 2/22/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSettingTableViewController: UITableViewController {

    private var nameOfArray:NSArray?
    
     var delegate:MURectFromCellDelegate?
    
    var navigationView:UIView?
    
    private var isBack:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(MUSettingTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.dataSource = self
        
        self.tableView.delegate = self
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let path = NSBundle.mainBundle().pathForResource("MUMeSettingMenu", ofType: "plist")
        
        self.nameOfArray = NSArray(contentsOfFile: path!)
        
        //self.tableView.scrollEnabled = false
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if self.isBack {
            
            self.navigationController?.navigationBar.addSubview(self.navigationView!)
        }
        
 }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (self.nameOfArray?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MUSettingTableViewCell
        let cell = MUSettingTableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        // Configure the cell...
        let dict = self.nameOfArray![indexPath.section] as! NSDictionary
        
        let image = UIImage(named: (dict["imageName"] as? String)!)
        
        cell.imageView?.image = image
        
        cell.frame = CGRectMake(0, 0, self.view.frame.width, 44.0)
        
        cell.contentView.backgroundColor = UIColor.customGrayColor()
        
        cell.textLabel?.text = dict["text"] as? String
        
        cell.textLabel?.font = UIFont.systemFontOfSize(12.0)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if (indexPath.section == (self.nameOfArray?.count)! - 1) {
            
            cell.detailTextLabel?.text = "1.0"
            
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(12.0)
            
            cell.isLast = true
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        let view = UIView(frame: CGRectMake(0,0,self.tableView.frame.size.width,12.0))
        
        view.backgroundColor = UIColor.customWhite()
        
        return view
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 12.0
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //you should use GCD
        if indexPath.row == tableView.indexPathsForVisibleRows?.last!.row {
            
        
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let rectInTableView = self.tableView.rectForFooterInSection((self.nameOfArray?.count)! - 1)
                
                let rect = self.tableView.convertRect(rectInTableView, toView: self.tableView.superview)
                
                //self.button = MUButton()
                self.delegate?.getRectFromCell(rect)
            })
            
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        if cell.textLabel?.text == "VoicePrint" {
            
            self.navigationView?.removeFromSuperview()
            
            self.isBack = true
            
            let controller = MUSynthesisViewController()
            
            self.navigationController!.pushViewController(controller, animated: true)
            
        }else if cell.textLabel?.text == "Add delivery address" {
            
            self.navigationView?.removeFromSuperview()
            
            self.isBack = true
            
            let controller = MUAddressViewController()
            
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }



}
