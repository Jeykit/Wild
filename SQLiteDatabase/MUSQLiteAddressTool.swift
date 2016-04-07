//
//  MUSQLiteAddressTool.swift
//  Wild
//
//  Created by Adaman on 4/3/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSQLiteAddressTool: NSObject {

    
    class func createDataBase() {
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let sqlStr = "Create Table If Not Exists T_Address (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,email TEXT,receiver TEXT NOT NULL,zipCode NOT NULL,phoneNumber TEXT NOT NULL, address INTEGER NOT NULL,date TEXT NOT NULL UNIQUE,defalut INTEGER NOT NULL)"
        
        let queue:FMDatabaseQueue?
        
         print("============\(filePath)")
        
        //let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                
                _ = try db.executeUpdate(sqlStr, values: [])
                
            }catch let error as NSError{
                
                print("error=\(error)")
            }
            
            db.close()
        })
    }

    class func writeCommentDataToDatabase(addressArray:NSArray){
        
        //email,receiver,zipCode,phoneNumber,address,date,defalut
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let insertOrderData   = "INSERT INTO T_Address (email,receiver,zipCode,phoneNumber,address,date,defalut) VALUES (?,?,?,?,?,?,?)"
        
        //print("\(path)")
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertOrderData, withArgumentsInArray: addressArray as [AnyObject])
            
            db.close()
        })
        
    }
    
    class func readAddressDataFromDatabase(emailText : String) -> NSMutableArray{
        
        let tempArray = NSMutableArray()
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM T_Address WHERE email = ? "
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet =  db.executeQuery(queryData, withArgumentsInArray: [emailText])
            
            while (rs.next()) {
                
                //email,receiver,zipCode,phoneNumber,address,date,defalut
                let modal = MUAddressModal()
                
                modal.email = rs.stringForColumn("email")
                
                modal.receiver = rs.stringForColumn("receiver")
                
                modal.zipCode = rs.stringForColumn("zipCode")
                
                modal.phoneNumber = rs.stringForColumn("phoneNumber")
                
                modal.address = rs.stringForColumn("address")
                
                modal.date = rs.stringForColumn("date")
                
                modal.defalut = Int(rs.intForColumn("defalut"))
                
                tempArray.addObject(modal)
            }
            db.close()
        })
        
       return tempArray
        
    }

    class func updateDataToDatabase(upDateDataWithRowHeight:NSMutableArray){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        //email,receiver,zipCode,phoneNumber,address,date,defalut
        let insertData = "UPDATE T_Address set receiver = ?,zipCode = ?,phoneNumber = ? , address = ? WHERE date = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: upDateDataWithRowHeight as [AnyObject])
            
            db.close()
        })
    }
    
    class func updateDefalutAddressToDatabase(value: Int,date:String,email:String){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        //email,receiver,zipCode,phoneNumber,address,date,defalut
        let insertData = "UPDATE T_Address set defalut = ? WHERE date = ? AND email = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: [value,date,email])
            
            db.close()
        })
    }

    class func querryDefalutAddressInDatabase(email : String) -> MUAddressModal {
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM T_Address WHERE email = ? AND defalut = '1'"
        
        let modal = MUAddressModal()
        //UIColor
        let queue = FMDatabaseQueue(path: path)
        
        //self.queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery(queryData, values: [email])
                
                
                while rs.next() {
                    
                    modal.email = rs.stringForColumn("email")
                    
                    modal.receiver = rs.stringForColumn("receiver")
                    
                    modal.zipCode = rs.stringForColumn("zipCode")
                    
                    modal.phoneNumber = rs.stringForColumn("phoneNumber")
                    
                    modal.address = rs.stringForColumn("address")
                    
                    modal.date = rs.stringForColumn("date")
                    
                    modal.defalut = Int(rs.intForColumn("defalut"))
                    
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return  modal
    }



}
