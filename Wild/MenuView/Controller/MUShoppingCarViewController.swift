//
//  MUShoppingCarViewController.swift
//  Wild
//
//  Created by Adaman on 2/23/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUShoppingCarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MUShoppingCarViewCellDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIPopoverPresentationControllerDelegate,UIPopoverControllerDelegate{

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
    
    private var navigationView:UIView?
    
    private var numberDicitonary:NSMutableDictionary = NSMutableDictionary()
    
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
        
        self.view.backgroundColor = UIColor.customWhite()
        
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
        
        self.navigationItem.hidesBackButton = true
        
        self.modalArray = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
        
        self.numberOfCount = "\(MUSQLiteDatabaseShoppingCarTool.numberOfCount)"
        
        self.totalPrice = "\(MUSQLiteDatabaseShoppingCarTool.totalPrice)"
        
        self.codeArray = MUSQLiteDatabaseShoppingCarTool.codeArray
        
        self.codeDictionary = MUSQLiteDatabaseShoppingCarTool.codeDict
        
        self.customBackItem()
    }
   
    override func viewWillDisappear(animated: Bool) {
        
        self.numberOfCount = nil
        
        self.totalPrice = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func customBackItem() {
        
        self.navigationView = UIView(frame: (self.navigationController?.navigationBar.bounds)!)
        
        let lButton:UIButton = UIButton()
        
        lButton.addTarget(self, action: #selector(MUShoppingCarViewController.handlerBackItem(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        button.addTarget(self, action: #selector(MUShoppingCarViewController.goToContentViewController(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        self.navigationView?.removeFromSuperview()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
  private func customViews(){
        
        self.tableView.registerClass(MUShoppingCarViewCell.self, forCellReuseIdentifier: "cell")

       self.tableView.translatesAutoresizingMaskIntoConstraints  = false

       self.tableView.estimatedRowHeight                         = 92.0

       self.tableView.rowHeight                                  = UITableViewAutomaticDimension

       self.tableView.dataSource                                 = self

       self.tableView.delegate                                   = self

       self.tableView.separatorStyle                             = UITableViewCellSeparatorStyle.None

        self.view.addSubview(self.tableView)

       self.payForView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.payForView)



       let vTableViewConstraint                                  = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12.0)

        self.view.addConstraint(vTableViewConstraint)

       let hTableViewConstraintLeft                              = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 12.0)

        self.view.addConstraint(hTableViewConstraintLeft)

       let hTableViewConstraintRight                             = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -12.0)

        self.view.addConstraint(hTableViewConstraintRight)

       let botttom                                               = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.payForView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -12.0)

        self.view.addConstraint(botttom)

        //add constraint to payforView
       let hPayForViewConstraintVFL                              = "H:|-0-[payForView]-0-|"

       let hPayForViewConstraint                                 = NSLayoutConstraint.constraintsWithVisualFormat(hPayForViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["payForView" : payForView])

        self.view.addConstraints(hPayForViewConstraint)

       let vPayForViewConstraintVFL                              = "V:[payForView(==192)]-12-|"

       let vPayForViewConstraint                                 = NSLayoutConstraint.constraintsWithVisualFormat(vPayForViewConstraintVFL, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: ["payForView" : payForView])

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
     
        cell.modal = reallyModalArray[indexPath.row] as? MUShoppingCarModal
        
        let initNumber:Int = 1
        
        self.numberDicitonary.setValue(initNumber, forKey: (cell.modal?.imageName)!)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.tag = self.tFlag + 100
        
        self.tFlag = self.tFlag + 1
        
        cell.indexPath = indexPath
        
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
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 136.0
        }else{
            
            return 104.0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 104.0
    }
    
   private func customPayView(){
        
        let payInfoView = UIView()
        
        payInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.payForView.addSubview(payInfoView)
        
        let payView = UIView()
        
        payView.translatesAutoresizingMaskIntoConstraints = false
    
        payView.backgroundColor = UIColor.customWhite()
        
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
    
    
       payInfoView.backgroundColor = UIColor.customGrayColor()
    
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Promo Code"
    
        label.textColor = UIColor.lightGrayColor()
        
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
    
        let text = "Total " + self.numberOfCount! + " Commodity  Total Price"
    
        let nsText = text as NSString
    
        let range = nsText.rangeOfString(self.numberOfCount!, options: NSStringCompareOptions.CaseInsensitiveSearch)
    
        //print("===========\(range)========\(nsText.length)",self.numberOfCount)
    
        self.customLabelInPayInfoView(subTotalLabel, textString: text)
    
        let attributeString = NSMutableAttributedString(string: subTotalLabel.text!)
    
        attributeString.addAttributes([NSForegroundColorAttributeName : UIColor.customColor()], range: range)
    
        subTotalLabel.attributedText = attributeString
    
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
    
        totalPriceLabel.textColor = UIColor.customColor()
    
        self.tempLabel = totalPriceLabel
    
        payInfoView.addSubview(totalPriceLabel)
    
    
       let codeLabel = UILabel()
    
       codeLabel.text = "You have saved "
    
       codeLabel.translatesAutoresizingMaskIntoConstraints = false
    
       codeLabel.textColor = UIColor.customColor()
    
       codeLabel.font = UIFont.systemFontOfSize(12.0)
    
       payInfoView.addSubview(codeLabel)
    
       let codeLabelPrice = UILabel()
    
       codeLabelPrice.text = "$\(codePrice)"
    
       codeLabelPrice.textColor = UIColor.customColor()
    
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
        
        label.textColor = UIColor.lightGrayColor()

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
        
        button.setImage(UIImage(named: "shopping-car-button"), forState: UIControlState.Normal)
        
        button.setTitle("Buy now", forState: UIControlState.Normal)
        
        button.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        button.addTarget(self, action: #selector(MUShoppingCarViewController.BuyNowButtonByClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        MUButtonBdageTool.setDecrementsButtonBadgeValues(1)
        
        //print("==================\(flag)")
        
        //self.tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Right)
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
        MUSQLiteDatabaseShoppingCarTool.deleteRowDataFromDatabase(imageName)
        
        self.modalArray = MUSQLiteDatabaseShoppingCarTool.readDataFromDatabase()
        
        self.numberOfCount = "\(MUSQLiteDatabaseShoppingCarTool.numberOfCount)"
        
        self.totalPrice = "\(MUSQLiteDatabaseShoppingCarTool.totalPrice)"
        
        if self.codeArray?.count > 0 {
            
            let codePrice = self.codeDictionary?.valueForKey(self.codeArray![0] as! String) as! Float
            
            let tTotalPrice = (self.totalPrice! as NSString).floatValue - codePrice
            
            self.tempLabel.text = "$" + "\(tTotalPrice)"

        }
        
        self.subTotalLabel(self.tempSubTotalLabel!, textString: self.numberOfCount!)
        
        self.subTotalLabelPrice?.text = "$" + self.totalPrice!
        
        self.tFlag = 0
        
        if self.modalArray?.count == 0 {
            
            self.customViewForModalArrayEmpty()
            
            self.payForView.removeFromSuperview()
            
            self.tableView.removeFromSuperview()
            
        }else{
            
             self.pickerView?.reloadAllComponents()
             self.tableView.reloadData()
        }
           // print("====================\(self.modalArray?.count)")
        
            
        
        

        
    }
    
    func updatePayForViewData(imageName: String, number: Int, price: Float) {
        
       // print("=============\(number)")
        if number >= 1 {
            
            //var totalNumber = (self.numberOfCount! as NSString).integerValue
            
           // totalNumber = totalNumber + number - 1
            
            self.numberOfCount = "\(number)"
            
            self.subTotalLabel(self.tempSubTotalLabel!, textString: self.numberOfCount!)
            
            let codePriceText = (self.tempCodeLabel?.text)! as NSString
            
            let codePriceString = codePriceText.substringWithRange(NSMakeRange(1, codePriceText.length - 1)) as NSString
            
            //let subTotalPrice = Float(number - 1) * price + (self.totalPrice! as NSString).floatValue
            
            let subTotalPrice = Float(number) * price
            
            self.totalPrice = "\(subTotalPrice - codePriceString.floatValue)"
            
            self.tempLabel.text = self.totalPrice
            
            self.subTotalLabelPrice?.text = "$" + "\(subTotalPrice)"
            
        }
        
        self.numberDicitonary.setValue(number, forKey: imageName)

    }
    
    func BuyNowButtonByClicked(button : UIButton) {
        
        //add goodsData
        //imageName,price,title,size,color,date,cod
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("email") != nil) {
            
            let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
            
            MUSQLiteAddressTool.createDataBase()
            
            let addressModal = MUSQLiteAddressTool.querryDefalutAddressInDatabase(email)
            
            if (addressModal.date != nil) {
                
               let tempArray = self.addDataToDatabase()
                
                tempArray.addObject(addressModal.date!)
                
                MUSQLiteDataMeViewControllerTool.writeOrderDataToDatabase(tempArray)
                
                MUSQLiteDatabaseShoppingCarTool.deletedDatabase()
                
                MUButtonBdageTool.initButtonBadgeValues(0)
                
                self.tableView.removeFromSuperview()
                
                self.payForView.removeFromSuperview()
                
                self.customViewForModalArrayEmpty()
                
            }else{
                
                let controller = MUAddressViewController()
                
               self.navigationController?.pushViewController(controller, animated: true)
            }

        }else{
            
            let wPopViewController = UIScreen.mainScreen().bounds.width * 0.70
            
            let hPopViewController = wPopViewController / 0.885
            
            let pointX = (UIScreen.mainScreen().bounds.width - wPopViewController)/2
            
            let pointY = (UIScreen.mainScreen().bounds.width - hPopViewController)/2
            
            let contentViewController = MURegisteredViewController()
            
            contentViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            
            contentViewController.preferredContentSize = CGSizeMake(wPopViewController, hPopViewController)
            
            // self.view.addSubview(contentViewController.view)
            
            //self.addChildViewController(contentViewController)
            
            let pop = contentViewController.popoverPresentationController!
            
            pop.canOverlapSourceViewRect = true
            
            //arrow does not display
            pop.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            
            pop.sourceView = self.view
            
            //let centered popViewControll
            pop.sourceRect = CGRectMake(pointX, pointY, wPopViewController , hPopViewController)
            
            //self.popoverViewController?.popoverLayoutMargins = UIEdgeInsets(top: pointY, left: pointX, bottom: pointY, right: pointX)
            
            pop.delegate = self
            //popViewController.popov
            
            self.presentViewController(contentViewController, animated: true, completion: nil)
            
           // contentViewController.view.frame = CGRectMake(pointX, pointY, wPopViewController , hPopViewController)
            
            //self.navigationController?.view.window?.addSubview(contentViewController.view)
        }
    
    }
    

    private func addDataToDatabase() -> NSMutableArray{
        
        
        var deviation:NSString?
        
        var firstDate:NSString?
        
        let tempOrderData = NSMutableArray()

         MUSQLiteDataMeViewControllerTool.createDataBase()
        
        for tArray in self.modalArray! {
            
            let mArray = tArray as! NSMutableArray
            
            if mArray.count > 0 {
                
                for (index,element) in mArray.enumerate() {
                    
                    let tempGoodsData = NSMutableArray()
                    
                    let modal         = element as! MUShoppingCarModal
                    
                    tempGoodsData.addObject(modal.imageName!)
                    
                    let number        = self.numberDicitonary.valueForKey(modal.imageName!) as! Int
                    
                    let price         = (modal.price! as NSString).floatValue * Float(number)
                    
                    let priceText     = "\(price)"
                    
                    modal.price       = priceText
                    
                    tempGoodsData.addObject(modal.price!)
                    
                    tempGoodsData.addObject(modal.title!)
                    
                    tempGoodsData.addObject(modal.size!)
                    
                    tempGoodsData.addObject(modal.color!)
                    
                    let format        = NSDateFormatter()
                    
                    let date          = NSDate()
                    
                    format.dateFormat = "yyyy/MM/dd HH/mm/ss"
                    
                    var formatDate    = format.stringFromDate(date)
                    
                    if index == 0 {
                        
                        let deviationFormat        = NSDateFormatter()
                        
                        deviationFormat.dateFormat = "yyyyMMddHHmmss"
                        
                        let deviationDate          = deviationFormat.stringFromDate(date)
                        
                        deviation                  = deviationDate
                        
                        firstDate = formatDate
                        
                    }else {
                        
                        if index == mArray.count - 1 {
                            
                            let deviationFormat        = NSDateFormatter()
                            
                            deviationFormat.dateFormat = "yyyyMMddHHmmss"
                            
                            let deviationDate          = deviationFormat.stringFromDate(date)
                            
                            if (deviation?.floatValue)! - (deviationDate as NSString).floatValue == 1 {
                                
                                formatDate                 = firstDate as! String
                            }
                        }
                    }
                    
                    tempGoodsData.addObject(formatDate)
                    
                    tempGoodsData.addObject(modal.code!)
                    
                    tempGoodsData.addObject(number)
                    
                    //add comment status
                    
                    let commentStatus:Int = 0
                    
                    tempGoodsData.addObject(commentStatus)
                    
                    //add email
                    let emailObject = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
                    
                    tempGoodsData.addObject(emailObject)
                    
                    
                    MUSQLiteDataMeViewControllerTool.writeDataToDatabase(tempGoodsData)
                }
            }
        }
        
        //totalPrice,orderDate,orderStatus
        tempOrderData.addObject(self.totalPrice!)
        
        let date            = NSDate()
        
        let format          = NSDateFormatter()
        
        format.dateFormat   = "yyyyMMddHHmmss"
        
        let formatData      = format.stringFromDate(date)
        
        tempOrderData.addObject(formatData)
        
        let orderStatus:Int = 1
        
        tempOrderData.addObject(orderStatus)
        
        //add email
        let emailObject = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
        
        tempOrderData.addObject(emailObject)
        
        return tempOrderData
       
    }
    
    private func showTips(){
        
        
        // UIActivityIndicatorView.appearance().backgroundColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        // UIProgressView.appearance().tintColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
        // UIProgressView.appearance().backgroundColor = UIColor(hue: 343, saturation: 87, brightness: 99, alpha: 1.0)
        
        let tipsX = (self.view.frame.width - 300)/2.0
        
        let tipsY = (self.view.frame.height - 300)/2.0
        
        
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        hub.mode = MBProgressHUDMode.Text
        
        hub.frame = CGRectMake(tipsX, tipsY, 300, 200)
        
        hub.label.text = "You are not logged in!"
        
        hub.label.font = UIFont.systemFontOfSize(12.0)
        
        hub.label.numberOfLines = 0
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
            
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                hub.hideAnimated(true)
                
                self.navigationController?.navigationBarHidden = false
                
            })
        })
        
    }
    
}
