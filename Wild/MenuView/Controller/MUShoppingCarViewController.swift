//
//  MUShoppingCarViewController.swift
//  Wild
//
//  Created by Adaman on 2/23/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUShoppingCarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MUShoppingCarViewCellDelegate,UIPickerViewDataSource,UIPickerViewDelegate{

    //var array:NSMutableArray?
    
    var modalArray:NSMutableArray?
    
    private let tableView:UITableView = UITableView()
    
    private var removeIndexPath:NSIndexPath?
    
    private let payForView = UIView()
    
    private var tempLabel = UILabel()
    
    private var tempCodeLabel:UILabel?
    
    private var tempTotalPrice:Float?
    
    private var pickerView:UIPickerView?
    
    private var tempSubTotalLabel:UILabel?
    
    private var subTotalLabelPrice:UILabel?
    
    private var tempCount:Int = 0
    
    private var tFlag:Int = 0
    
    var numberOfCount:String?
    
    var totalPrice:String?
    
    var codeArray:NSMutableArray?
    
    var codeDictionary:NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Shopping Car"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(18.0),NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.view.backgroundColor = UIColor.whiteColor()
        
       // self.payForView.backgroundColor = UIColor.purpleColor()
        
//        let leftBarItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.Plain, target: self, action: "backToLastViewControner:")
//        
//        self.navigationItem.leftBarButtonItem = leftBarItem
//        
//        self.navigationItem.hidesBackButton = true
        
        
        //Analying data if it is empty
        if modalArray?.count == 0 {
            
           self.customViewForModalArrayEmpty()
        }else {
            
            self.customViews()

        }
     
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //self.numberOfCount = 0
        
        //self.totalPrice = 0
    }
   
    override func viewWillDisappear(animated: Bool) {
        
        self.numberOfCount = nil
        
        self.totalPrice = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func backToLastViewControner(barButton : UIBarButtonItem) {
//        
//        self.navigationController?.popViewControllerAnimated(true)
//    }
   private func customViewForModalArrayEmpty() {
        
        
        let label = UILabel()
        
        label.text = "Car is empty!"
        
        label.font = UIFont.systemFontOfSize(16.0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        let button = UIButton()
        
        button.layer.borderWidth = 2.0
        
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        button.setTitle("Go", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: "goToContentViewController:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        
        
        //add constraint to button
        let hButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hButtonConstraint)
        
        let vButtonConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(vButtonConstraint)

        //add constraint to label
        let hLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.view.addConstraint(hLabelConstraint)
        
        let vLabelConstraintVFL = "V:[label]-12-[button]"
        
        let vLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label" : label,"button" : button])
        
        self.view.addConstraints(vLabelConstraint)
        
        
    }
    
    func goToContentViewController (button : UIButton) {
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
  private func customViews(){
        
        self.tableView.registerClass(MUShoppingCarViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.estimatedRowHeight = 92.0
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.dataSource = self
        
        self.tableView.delegate = self
    
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(self.tableView)
        
        self.payForView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.payForView)
        
       
        
        let vTableViewConstraint = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
        
        self.view.addConstraint(vTableViewConstraint)
        
        let hTableViewConstraintLeft = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
        
        self.view.addConstraint(hTableViewConstraintLeft)
        
        let hTableViewConstraintRight = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)
        
        self.view.addConstraint(hTableViewConstraintRight)
        
        let botttom = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.payForView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -12.0)
        
        self.view.addConstraint(botttom)
        
        //add constraint to payforView
       let hPayForViewConstraintVFL = "H:|-0-[payForView]-0-|"
        
        let hPayForViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hPayForViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["payForView" : payForView])
        
        self.view.addConstraints(hPayForViewConstraint)
        
        let vPayForViewConstraintVFL = "V:[payForView(==192)]-12-|"
        
        let vPayForViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vPayForViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["payForView" : payForView])
        
        self.view.addConstraints(vPayForViewConstraint)

         self.customPayView()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (self.modalArray?.count)!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let number = (self.modalArray![section] as! NSMutableArray).count
        
        return number
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")! as! MUShoppingCarViewCell
        
        if self.removeIndexPath != nil && self.removeIndexPath == NSIndexPath(forRow: 0, inSection: 0){
            
            cell = MUShoppingCarViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        cell.delegate = self
        
        let reallyModalArray = self.modalArray![indexPath.section] as! NSMutableArray
     
        //cell.modal = reallyModalArray[indexPath.row] as? MUShoppingCarModal
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.tag = self.tFlag + 100
        
        self.tFlag = self.tFlag + 1
        
        cell.indexPath = indexPath
        
        return cell
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRectMake(0,0,self.view.frame.size.width,12.0))
        
        view.backgroundColor = UIColor.blueColor()
        
        return view

    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 12.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 136.0
        }else{
            
            return 92.0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 92.0
    }
    
  private func customPayView(){
        
        let payInfoView = UIView()
        
//        button.setImage(UIImage(named: "shoppingCar_bag_defalut_22"), forState: UIControlState.Normal)
//        
//        button.setTitle("USED COUPONS", forState: UIControlState.Normal)
//        
//        button.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        
        
        //payInfoView.backgroundColor = UIColor.grayColor()
        
        payInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.payForView.addSubview(payInfoView)
        
        let payView = UIView()
        
        payView.translatesAutoresizingMaskIntoConstraints = false
        
        self.payForView.addSubview(payView)
        
        //add consraint to payview
        let hButtonConstraintVFL = "H:|-0-[payInfoView]-0-|"
        
        let hButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: ["payInfoView" : payInfoView])
        
        self.view.addConstraints(hButtonConstraint)
        
        let vButtonConstraintVFL = "V:|-0-[payInfoView(==128)]-12-[payView]-0-|"
        
        let vButtonConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vButtonConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["payInfoView" : payInfoView,"payView" : payView])
        
        self.view.addConstraints(vButtonConstraint)
        
        self.customPayInfoView(payInfoView)
        
        let hPayViewConstraintVFL = "H:|-0-[payView]-0-|"
        
        let hPayViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hPayViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["payView" : payView])
        
        self.view.addConstraints(hPayViewConstraint)
        
        self.customPayView(payView)
        
        
    }
    
   private func customPayInfoView(payInfoView:UIView){
    
    
       payInfoView.backgroundColor = UIColor.lightGrayColor()
    
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Promo Code"
    
        label.textColor = UIColor.whiteColor()
        
        label.font = UIFont.systemFontOfSize(12.0)
    
        //label.backgroundColor = UIColor.purpleColor()
    
        //label.textColor = UIColor.redColor()
        
        payInfoView.addSubview(label)
        
        self.pickerView = UIPickerView()
        
        pickerView!.translatesAutoresizingMaskIntoConstraints = false
    
        pickerView!.selectRow(3, inComponent: 0, animated: false)
        
        pickerView!.dataSource = self
        
        pickerView!.delegate = self
        
        payInfoView.addSubview(pickerView!)
    
        payInfoView.bringSubviewToFront(label)
    
        let hLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: payInfoView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)
    
        payInfoView.addConstraint(hLabelConstraint)
    
       let vLabelConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: payInfoView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)
    
        payInfoView.addConstraint(vLabelConstraint)
    
        let hPickViewConstraint = NSLayoutConstraint(item: pickerView!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
        
        payInfoView.addConstraint(hPickViewConstraint)
        
        let wPickViewConstraint = NSLayoutConstraint(item: pickerView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: payInfoView, attribute: NSLayoutAttribute.Width, multiplier: 0.175, constant: 0.0)
        
        payInfoView.addConstraint(wPickViewConstraint)
//    
//        let vPayforViewConstraint = NSLayoutConstraint(item: pickView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: payInfoView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
//    
//        payInfoView.addConstraint(vPayforViewConstraint)
    
        let vPayForViewVFL = "V:|-12-[pickView]-12-|"
        
        let vPayForViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vPayForViewVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label" : label,"pickView" : pickerView!])
        
        payInfoView.addConstraints(vPayForViewConstraint)
    
        let subTotalLabel = UILabel()
    
        self.subTotalLabel(subTotalLabel, textString: self.numberOfCount!)
    
        self.tempSubTotalLabel = subTotalLabel
    
        //let textOfNumber = "\(self.numberOfCount)"
    
//        let text = "Total " + self.numberOfCount! + " Commodity  Total Price"
//    
//        let nsText = text as NSString
//    
//        let range = nsText.rangeOfString(self.numberOfCount!, options: NSStringCompareOptions.CaseInsensitiveSearch)
//    
//        //print("===========\(range)========\(nsText.length)",self.numberOfCount)
//    
//        self.customLabelInPayInfoView(subTotalLabel, textString: text)
//    
//        let attributeString = NSMutableAttributedString(string: subTotalLabel.text!)
//    
//        attributeString.addAttributes([NSForegroundColorAttributeName : UIColor(hue: 343.0, saturation: 87.0, brightness: 99.0, alpha: 1.0)], range: range)
//    
//        subTotalLabel.attributedText = attributeString
    
        payInfoView.addSubview(subTotalLabel)
    
    
        let subTotalPriceLabel = UILabel()
    
        self.customLabelInPayInfoView(subTotalPriceLabel, textString: "$\(self.totalPrice!)")
    
        self.subTotalLabelPrice = subTotalPriceLabel
    
        payInfoView.addSubview(subTotalPriceLabel)
    
    
       let hSubTotalLabelConstraintVFL = "H:[subTotalLabel]-60-[subTotalPriceLabel]-12-|"
    
       let hSubTotalLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hSubTotalLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: nil, views: ["subTotalLabel" : subTotalLabel,"subTotalPriceLabel" : subTotalPriceLabel])
    
       payInfoView.addConstraints(hSubTotalLabelConstraint)
    
    
        let totalLabel = UILabel()
    
        self.customLabelInPayInfoView(totalLabel, textString: "Total Price(Shippment:Free)")
    
        payInfoView.addSubview(totalLabel)
    
        let codePrice = self.codeDictionary?.valueForKey(self.codeArray![0] as! String) as! Float
    
        let tTotalPrice = (self.totalPrice! as NSString).floatValue - codePrice
    
        self.tempTotalPrice = round(tTotalPrice * 100) / 100
    
        let totalPriceLabel = UILabel()
    
        self.customLabelInPayInfoView(totalPriceLabel, textString: "$\(tTotalPrice)")
    
        totalPriceLabel.font = UIFont.systemFontOfSize(18.0)
    
        totalPriceLabel.textColor = UIColor(hue: 343.0, saturation: 87.0, brightness: 99.0, alpha: 1.0)
    
        self.tempLabel = totalPriceLabel
    
        payInfoView.addSubview(totalPriceLabel)
    
    
       let codeLabel = UILabel()
    
       codeLabel.text = "You have saved "
    
       codeLabel.translatesAutoresizingMaskIntoConstraints = false
    
       codeLabel.textColor = UIColor(hue: 343.0, saturation:87.0, brightness: 99.0, alpha: 0.75)
    
       codeLabel.font = UIFont.systemFontOfSize(12.0)
    
       payInfoView.addSubview(codeLabel)
    
       let codeLabelPrice = UILabel()
    
       codeLabelPrice.text = "$\(codePrice)"
    
       codeLabelPrice.textColor = UIColor(hue: 343.0, saturation: 87.0, brightness: 99.0, alpha: 1.0)
    
       codeLabelPrice.font = UIFont.systemFontOfSize(12.0)
    
       self.tempCodeLabel = codeLabelPrice
    
       codeLabelPrice.translatesAutoresizingMaskIntoConstraints = false
    
       payInfoView.addSubview(codeLabelPrice)
    
    
        let hTotalLabelConstraintVFL = "H:[totalLabel]-60-[totalPriceLabel]-12-|"
    
        let hTotalLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hTotalLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom.union(NSLayoutFormatOptions.AlignAllTop), metrics: nil, views: ["totalLabel" : totalLabel,"totalPriceLabel" : totalPriceLabel])
    
        payInfoView.addConstraints(hTotalLabelConstraint)
    
    
       let vTotalLabelConstraintVFL = "V:[subTotalPriceLabel]-12-[totalPriceLabel]-12-[codeLabelPrice]"
    
    let vTotalLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vTotalLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["subTotalPriceLabel" : subTotalPriceLabel,"totalPriceLabel" : totalPriceLabel,"codeLabelPrice" : codeLabelPrice])
    
       payInfoView.addConstraints(vTotalLabelConstraint)
    
    
      let vLTotalLabelConstraintVFL = "V:[subTotalLabel]-12-[totalLabel]-12-[codeLabel]"
    
    let vLTotalLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLTotalLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["subTotalLabel" : subTotalLabel,"totalLabel" : totalLabel,"codeLabel" : codeLabel])
    
      payInfoView.addConstraints(vLTotalLabelConstraint)
    
    
      let centerYConstraint = NSLayoutConstraint(item: totalPriceLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: pickerView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
    
      payInfoView.addConstraint(centerYConstraint)
    
    
    }
    
    private func subTotalLabel(label : UILabel,textString : String) {
        
        let text = "Total " + textString + " Commodity  Total Price"
        
        let nsText = text as NSString
        
        let range = nsText.rangeOfString(textString, options: NSStringCompareOptions.CaseInsensitiveSearch)
        
        //print("===========\(range)========\(nsText.length)",self.numberOfCount)
        
        self.customLabelInPayInfoView(label, textString: text)
        
        let attributeString = NSMutableAttributedString(string: label.text!)
        
        attributeString.addAttributes([NSForegroundColorAttributeName : UIColor(hue: 343.0, saturation: 87.0, brightness: 99.0, alpha: 1.0)], range: range)
        
        label.attributedText = attributeString

    }
    
    private func customLabelInPayInfoView(label : UILabel,textString : String) {
        
        label.text = textString
        
        label.font = UIFont.systemFontOfSize(12.0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor.whiteColor()

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return (self.codeArray?.count)!
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "Promo Code"
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var label:UILabel?
        
        if view != nil {
            
            label = view as? UILabel
        }else{
           
             label = UILabel()
        }
        
       label?.text = self.codeArray![row] as? String
       
       label!.font = UIFont.systemFontOfSize(12.0)
        
       label?.textColor = UIColor(hue: 343.0, saturation:87.0, brightness: 99.0, alpha: 1.0)
        
       label?.textAlignment = NSTextAlignment.Center
        
        return label!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let codeFloat:Float = self.codeDictionary?.valueForKey(self.codeArray![row] as! String) as! Float
        
        let totalPrice = (self.totalPrice! as NSString).floatValue - codeFloat
        
        self.tempLabel.text = "$\(round(totalPrice * 100) / 100)"
        
        self.tempTotalPrice = round(totalPrice * 100) / 100
        
        self.tempCodeLabel?.text = "$\(codeFloat)"
        
    }
    
   private func customPayView(cView : UIView){
        
        let label = UILabel()
        
        label.text = "If you like it,Please orders it!"
        
        label.font = UIFont.systemFontOfSize(12.0)
        
        label.textAlignment = NSTextAlignment.Center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //label.backgroundColor = UIColor.brownColor()
        
        cView.addSubview(label)
        
        let button = MUButton()
        
        button.setImage(UIImage(named: "shoppongCar_Payfor_bg_44"), forState: UIControlState.Normal)
        
        button.setTitle("Buy now", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        button.addTarget(self, action: "BuyNowButtonByClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cView.addSubview(button)
        
        let hLabelConstraintVFL = "H:[label]-12-[button]-0-|"
        
        let hLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllTop.union(NSLayoutFormatOptions.AlignAllBottom), metrics: nil, views: ["label" : label,"button" : button])
        
        cView.addConstraints(hLabelConstraint)
        
        let vLabelConstraintVFL = "V:|-0-[button]-12-|"
        
        let vLabelConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vLabelConstraintVFL, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["button" : button])
        
        cView.addConstraints(vLabelConstraint)
    
        let wButton = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: cView, attribute: NSLayoutAttribute.Width, multiplier: 0.38, constant: 0.0)
    
        cView.addConstraint(wButton)
        
    }
    
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK MUShoppingCarViewCellDelegate
    
    func removeCellForIndexPath(indexPath: NSIndexPath, imageName: String, flag: Int) {
        
        self.removeIndexPath = indexPath
        
        let reallyModalArray = self.modalArray![indexPath.section] as! NSMutableArray
        
        reallyModalArray.removeObjectAtIndex(indexPath.row)
        
        self.codeDictionary?.removeObjectForKey(self.codeArray![flag] as! String)
        
        self.codeArray?.removeObjectAtIndex(flag)
        
        //print("==================\(flag)")
        
        //self.tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Right)
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
        MUSQLiteDatabaseShoppingCarTool.deleteRowDataFromDatabase(imageName)
        
        self.modalArray = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
        
        self.numberOfCount = "\(MUSQLiteDatabaseShoppingCarTool.numberOfCount)"
        
        self.totalPrice = "\(MUSQLiteDatabaseShoppingCarTool.totalPrice)"
        
        let codePrice = self.codeDictionary?.valueForKey(self.codeArray![0] as! String) as! Float
        
        let tTotalPrice = (self.totalPrice! as NSString).floatValue - codePrice
        
        self.tempLabel.text = "$" + "\(tTotalPrice)"
        
        self.subTotalLabel(self.tempSubTotalLabel!, textString: self.numberOfCount!)
        
        self.subTotalLabelPrice?.text = "$" + self.totalPrice!
        
        self.tFlag = 0
        
        self.tableView.reloadData()
        
        self.pickerView?.reloadAllComponents()

        
    }
    
    func updatePayForViewData(number: Int, price: Float) {
        
        if number > 1 {
            
            var totalNumber = (self.numberOfCount! as NSString).integerValue
            
            totalNumber = totalNumber + number - 1
            
            self.numberOfCount = "\(totalNumber)"
            
            self.subTotalLabel(self.tempSubTotalLabel!, textString: self.numberOfCount!)
            
            let codePriceText = (self.tempCodeLabel?.text)! as NSString
            
            let codePriceString = codePriceText.substringWithRange(NSMakeRange(1, codePriceText.length - 1)) as NSString
            
            let subTotalPrice = Float(number - 1) * price + (self.totalPrice! as NSString).floatValue
            
            self.totalPrice = "\(subTotalPrice - codePriceString.floatValue)"
            
            self.tempLabel.text = self.totalPrice
            
            self.subTotalLabelPrice?.text = "$" + "\(subTotalPrice)"
            
        }
    }
    
    func BuyNowButtonByClicked(button : UIButton) {
        
        //add goodsData
        //imageName,price,title,size,color,date,cod
        
        let tempOrderData = NSMutableArray()
        
        MUSQLiteDataMeViewControllerTool.createDataBase()
        
        for tArray in self.modalArray! {
            
            let mArray = tArray as! NSMutableArray
            
            if mArray.count > 0 {
                
                for element in mArray {
                    
                    let tempGoodsData = NSMutableArray()
                    
                    let modal = element as! MUShoppingCarModal
                    
                    tempGoodsData.addObject(modal.imageName!)
                    
                    tempGoodsData.addObject(modal.price!)
                    
                    tempGoodsData.addObject(modal.title!)
                    
                    tempGoodsData.addObject(modal.size!)
                    
                    tempGoodsData.addObject(modal.color!)
                    
                    let format = NSDateFormatter()
                    
                    let date = NSDate()
                    
                    format.dateFormat = "yyyy/MM/dd HH/mm/ss"
                    
                    let formatDate = format.stringFromDate(date)
                    
                    tempGoodsData.addObject(formatDate)
                    
                    tempGoodsData.addObject(modal.code!)
                    
                    MUSQLiteDataMeViewControllerTool.writeDataToDatabase(tempGoodsData)
                }
            }
        }
        
        //totalPrice,orderDate,orderStatus
        tempOrderData.addObject(self.totalPrice!)
        
        let date = NSDate()
        
        let format = NSDateFormatter()
        
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formatData = format.stringFromDate(date)
        
        tempOrderData.addObject(formatData)
        
        let orderStatus:Int = 1
        
        tempOrderData.addObject(orderStatus)
        
        
        
        MUSQLiteDataMeViewControllerTool.writeOrderDataToDatabase(tempOrderData)
        
        MUSQLiteDatabaseShoppingCarTool.deletedDatabase()
        
        //let controller = MUMeViewController()
        
    }
    
}
