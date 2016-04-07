//
//  MUExpandCellModal.swift
//  Wild
//
//  Created by Adaman on 3/4/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUExpandCellModal: NSObject {

    var subDecription:String?
    
    var detailDecription:String?
    
    var modal:MUCommentModal?
    
    
    override init() {
        
        super.init()
        
        self.subDecription = " "
        
        self.detailDecription = " "
        
      //  NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadDataFromDatabase:", name: "NotificationIdentifier", object: nil)
        
    }
    
//    func reloadDataFromDatabase (notification : NSNotification){
//        
//        let flag = notification.object as! Int
//        
//        print("sdkjfksdgk = \(flag)")
//       
//    }

    
    init(flag : Int) {

        super.init()

        self.openDatabaseForDecription(flag)
    }
    
//    func reloadDataFromDatabase (notification : NSNotification){
//        
//        let flag = notification.object as! Int
//        
//        self.openDatabaseForDecription(flag)
//    }
    
    func openDatabaseForDecription(flag : Int) {
        
        //let tempArray:NSMutableArray = NSMutableArray()
        
       // var tempModal:MUExpandCellModal?
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT * FROM T_GoodsDecription,T_GoodsInfo WHERE T_GoodsInfo.id =" + "\(flag + 1)" + " AND T_GoodsDecription.id = T_GoodsInfo.id", values: nil)
                
                
                while rs.next() {
                    
                    self.subDecription = rs.stringForColumn("subDecription")
                    
                    self.detailDecription = rs.stringForColumn("detailDecription")
                    
                  // self.addObject(tempModal!)
                    
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
    }

}
