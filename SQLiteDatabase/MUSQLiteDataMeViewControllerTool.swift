//
//  MUSQLiteDataMeViewControllerTool.swift
//  Wild
//
//  Created by Adaman on 3/20/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSQLiteDataMeViewControllerTool: NSObject {

    
    class func createDataBase(){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let createDatabase = "CREATE TABLE IF NOT EXISTS T_PurchasedGoods (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,imageName TEXT NOT NULL ,price TEXT NOT NULL,title TEXT NOT NULL,size TEXT NOT NULL,color TEXT NOT NULL,date TEXT NOT NULL,code TEXT NOT NULL,number INTEGER NOT NULL,commentStatus INTEGER NOT NULL,email TEXT NOT NULL)"
        
        let ordered = "CREATE TABLE IF NOT EXISTS T_Ordered (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,totalPrice TEXT NOT NULL,orderDate TEXT NOT NULL,orderStatus INTEGER NOT NULL,email TEXT NOT NULL,addressDate TEXT NOT NULL)"
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                
                _ = try db.executeUpdate(createDatabase, values: [])
                
                db.executeUpdate(ordered, withArgumentsInArray: [])
                
            }catch let error as NSError{
                
                print("error=\(error)")
            }
            
            db.close()
        })
        
    }
    
    class func writeDataToDatabase(goodsArray : NSArray){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let insertData = "INSERT INTO T_PurchasedGoods (imageName,price,title,size,color,date,code,number,commentStatus,email) VALUES (?,?,?,?,?,?,?,?,?,?)"
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: goodsArray as [AnyObject] )
            
            db.close()
        })
        
    }
    
    class func writeOrderDataToDatabase(orderArray:NSArray){
        
       let queue:FMDatabaseQueue?

       let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!

       let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String

       let insertOrderData   = "INSERT INTO T_Ordered (totalPrice,orderDate,orderStatus,email,addressDate) VALUES (?,?,?,?,?)"
        
        //print("\(path)")
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertOrderData, withArgumentsInArray: orderArray as [AnyObject])
            
            db.close()
        })
        
    }
    
    class func readDataFromDatabase(emailText : String) -> NSMutableArray{
        
        var tempArray = NSMutableArray()
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM T_PurchasedGoods WHERE email = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet =  db.executeQuery(queryData, withArgumentsInArray: [emailText])
            
            while (rs.next()) {
                
                //imageName,price,title,size,color,date
                let modal = MUMeOrderedGoodsModal()
                
                modal.imageName = rs.stringForColumn("imageName")
                
                modal.title = rs.stringForColumn("title")
                
                modal.color = rs.stringForColumn("color")
                
                modal.size = rs.stringForColumn("size")
                
                modal.date = rs.stringForColumn("date")
                
                modal.price = rs.stringForColumn("price")
                
                modal.numberOfBuy = Int(rs.intForColumn("number"))
                
                modal.saleCode = rs.stringForColumn("code")
                
                modal.commentStatus = Int(rs.stringForColumn("commentStatus"))
                
                modal.email = rs.stringForColumn("email")

                tempArray.addObject(modal)
            }
            db.close()
        })
        
        if tempArray.count > 0 {
            
            tempArray = self.sortByDataarray(tempArray)
            
            tempArray = self.sortGroupFromArray(tempArray)
        }
        
        return tempArray
        
    }
    
    class func readOrderedDataFromDatabase(emailText : String) -> NSMutableArray{
        
        let tempArray = NSMutableArray()
        
        //get the array corresponding to modal
        var flag:Int = 0
        
        let groupArray = self.readDataFromDatabase(emailText)
        
        //print("====================\(groupArray.count)")
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM T_Ordered WHERE email = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet =  db.executeQuery(queryData, withArgumentsInArray: [emailText])
            
            while (rs.next()) {
                
                //totalPrice,orderDate,orderStatus
                let modal         = MUMeOrderedModal()

                modal.totalPrice  = rs.stringForColumn("totalPrice")

                modal.orderDate   = rs.stringForColumn("orderDate")

                modal.orderStatus = Int(rs.intForColumn("orderStatus"))

                modal.addressDate = rs.stringForColumn("addressDate")
                
                if groupArray.count > 0 && flag < groupArray.count {
                    
                   // print("============\(groupArray.count)")
                    
                    modal.orderedGoodsModals = groupArray[flag] as? NSMutableArray
                    
                    flag = flag + 1
             
                }
                
                  tempArray.addObject(modal)
                  //print("====================\( modal.orderedGoodsModals?.count)")
               // }

            }
            
            rs.close()
            db.close()
        })
        
        //print("================\(flag)")
        
        return tempArray
        
    }


    private class func sortGroupFromArray(tempArray : NSMutableArray) -> NSMutableArray {
        
        var currentDate:String? = (tempArray[0] as! MUMeOrderedGoodsModal).date
        
        //print("====================",currentDate)
        
        let groupArray:NSMutableArray? = []
        
        var tArray:NSMutableArray? = []
        
        for (_,element) in tempArray.enumerate() {
            
            let modal = element as! MUMeOrderedGoodsModal
            
            if modal.date == currentDate {
                
                
                tArray!.addObject(modal)
                
//                if index == tempArray.count - 1 {
//                    
//                    groupArray?.addObject(tArray!)
//                }
                
            }else{
                
                groupArray?.addObject(tArray!)
                
                tArray = NSMutableArray()
                
                currentDate = modal.date!
                
                tArray!.addObject(modal)
//                
//                if index == tempArray.count - 1 {
//                    
//                    groupArray?.addObject(tArray!)
//                }
            }
        }
        
         groupArray?.addObject(tArray!)
        
        
        return groupArray!
    }
    
    private class func sortByDataarray(tempArray : NSMutableArray)-> NSMutableArray {
        
        
        let temp:NSArray = tempArray.sortedArrayUsingComparator({ (modal1, modal2) -> NSComparisonResult in
            
            
            let object1 = (modal1 as! MUMeOrderedGoodsModal).date
            
            let object2 =  (modal2 as! MUMeOrderedGoodsModal).date
            
            if object1 > object2 {
                
                return NSComparisonResult.OrderedAscending
                
            }else if object1 < object2 {
                
                return NSComparisonResult.OrderedDescending
                
            }else{
                
                return NSComparisonResult.OrderedSame
            }
            
        })
        
        return NSMutableArray(array: temp)
        
    }

    class func updateDataToDatabase(updataField : String,upDateDataWithEmail:NSMutableArray){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let insertData = "UPDATE T_PurchasedGoods set " + updataField + "= ? WHERE email = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: upDateDataWithEmail as [AnyObject])
            
            db.close()
        })
    }


}
