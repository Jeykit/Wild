//
//  MUOrderTableViewController.swift
//  Wild
//
//  Created by Adaman on 2/22/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUOrderTableViewController: UITableViewController,MUShoppingCarViewCellDelegate {

    var modalArray:NSMutableArray?
    
    //var tableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.view.backgroundColor = UIColor.customWhite()
      
        self.tableView = UITableView(frame: self.view.frame)
        
        self.tableView.registerClass(MUOrderedViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.dataSource = self
        
        self.tableView.delegate = self
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.backgroundColor = UIColor.customWhite()

        
    }

    private func customViewForModalArrayEmpty() {
        
        
        let label = UILabel()
        
        label.text = "Car is empty!"
        
        label.font = UIFont.systemFontOfSize(16.0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.addSubview(label)
        
        //self.view.addSubview(label)
        
        let button = UIButton()
        
        button.layer.borderWidth = 2.0
        
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        button.setTitle("Go", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
      //  button.addTarget(self, action: #selector(MUOrderTableViewController.back), forControlEvents: UIControlEvents.TouchUpInside)
        
        //self.view.addSubview(button)
        self.tableView.addSubview(label)
        
        //add constraint to button
        let hButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.tableView, attribute: .CenterX, multiplier: 1.0, constant: 0)
        
        self.tableView.addConstraint(hButtonConstraint)
        
        let vButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.tableView, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(vButtonConstraint)
        
        //add constraint to label
        let hLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.tableView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.tableView.addConstraint(hLabelConstraint)
        
        let vLabelConstraintVFL = "V:[label]-12-[button]"
        
        let vLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label" : label,"button" : button])
        
        self.tableView.addConstraints(vLabelConstraint)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
        MUSQLiteDataMeViewControllerTool.createDataBase()
            
        //self.modalArray = MUSQLiteDataMeViewControllerTool.readOrderedDataFromDatabase()
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            let emailText = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
            
            self.modalArray = MUSQLiteDataMeViewControllerTool.readOrderedDataFromDatabase(emailText)
        }else{
            
            self.modalArray = []
        }

        
        //self.tableView.reloadData()
        //}
       
    }
    override func viewWillDisappear(animated: Bool) {
        
        self.modalArray = nil
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (self.modalArray?.count)!
    }

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MUOrderedViewCell

        // Configure the cell...
        
        cell.indexPath = indexPath
    
        cell.delegate = self
        
        if self.modalArray?.count > 0{
            
          cell.modal = self.modalArray![indexPath.section] as? MUMeOrderedModal
        }
      
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell
    }

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRectMake(0,0,self.view.frame.size.width,12.0))
        
        view.backgroundColor = UIColor.customWhite()
        
        return view
    }
   override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 12.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let modal:MUMeOrderedModal?
        
        
        
        var rowHeight:CGFloat?
        
        if self.modalArray?.count > 0 {
            
            modal = self.modalArray![indexPath.section] as? MUMeOrderedModal
            
            // print("==============\(modal!.orderedGoodsModals!.count)")
            
            if indexPath.section == 0 && indexPath.row == 0 {

                //"44" is height of headerView
                if modal!.orderedGoodsModals!.count > 2 {
                    
                    rowHeight = 2 * 92.0 + 44.0
                }else{
                    
                    rowHeight = CGFloat(modal!.orderedGoodsModals!.count) * 92.0 + 44.0
                }
                
            }else{
                
                if modal!.orderedGoodsModals!.count > 3 {
                    
                    rowHeight = 2 * 92.0 + 44.0
                }else{
                    
                   
                    
                    rowHeight = CGFloat(modal!.orderedGoodsModals!.count) * 92.0
                }
                
                
            }

        }
    
        return rowHeight!
    }

    func moreButtonByClicked(modalArray: NSMutableArray) {
        
        let controller = MUMeMoreOrderDetailViewController()
        
        controller.modalArray = modalArray
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
  

}
