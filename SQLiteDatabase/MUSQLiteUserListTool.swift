//
//  MUSQLiteUserListTool.swift
//  Wild
//
//  Created by Adaman on 3/27/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSQLiteUserListTool: NSObject {

    class func cleareDateInDatabase(query : String) {
        
        let queue:FMDatabaseQueue?
        
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let deleteData = "DELETE FROM T_ShoppingCar From WHERE email = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(deleteData, withArgumentsInArray: [query])
            
            // db.executeUpdate("UPDATE sqlite_sequence set seq = 0 where name = 'T_TempRowHeight'", withArgumentsInArray: [])
            
            db.close()
        })
        
    }

    class func createDataBase() {
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let sqlStr = "Create Table If Not Exists T_UserList(email TEXT PRIMARY KEY UNIQUE,password TEXT NOT NULL ,username TEXT NOT NULL,hImage TEXT NOT NULL,bImage TEXT NOT NULL,adressText TEXT NOT NULL)"
        
        let queue:FMDatabaseQueue?
        
       // print("============\(filePath)")
        
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
    
   class func querryDataInDatabase(query : String) -> MUUserListModal {
        
    let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    
    let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
    
        //let tempArray:NSMutableArray = NSMutableArray()
        let modal = MUUserListModal()
        //UIColor
        let queue = FMDatabaseQueue(path: path)
            
        //self.queue = FMDatabaseQueue(path: filePath as String)
        
          queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT * FROM T_UserList WHERE email = ?", values: [query])
                
                
                while rs.next() {
                    
                    modal.emailText = rs.stringForColumn("email")
                    
                    modal.userNameText = rs.stringForColumn("username")
                    
                    modal.passwordText = rs.stringForColumn("password")
                    
                    modal.headerImageText = rs.stringForColumn("hImage")
                    
                    modal.backgroundImageText = rs.stringForColumn("bImage")
                    
                    modal.addressText = rs.stringForColumn("adressText")
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })

        return  modal
    }
    
    class func writeDataToDatabase(dataArray : NSMutableArray){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
         //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let insertData = "INSERT INTO T_UserList (email,password,username,hImage,bImage,adressText) VALUES (?,?,?,?,?,?)"
        
        print(path)
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: dataArray as [AnyObject])
            
            db.close()
        })
    }
    
    class func updateDataToDatabase(updataField : String,upDataWithEmailAndData:NSMutableArray){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let insertData = "UPDATE T_UserList set " + updataField + "= ? WHERE email = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: upDataWithEmailAndData as [AnyObject])
            
            db.close()
        })
    }



}
