//
//  MUNavigationController.swift
//  Wild
//
//  Created by Adaman on 1/22/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is a class method,it will be used only once when the controller was init.
    override class func initialize(){
    
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigation-background"), forBarMetrics: UIBarMetrics.Default)
       // self.addChildViewController(UINavigationController(rootViewController: ViewController()) as! MUNavigationController)
         //let Controller = ViewController()
        //MUNavigationController(rootViewController: Controller)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
       return UIStatusBarStyle.LightContent
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
