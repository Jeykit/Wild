//
//  MUSQLiteCommentTool.swift
//  Wild
//
//  Created by Adaman on 3/29/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSQLiteCommentTool: NSObject {

    class func createDataBase(tableName : String) {
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let sqlStr = "Create Table If Not Exists " + tableName + "(email TEXT PRIMARY KEY UNIQUE,username TEXT NOT NULL,hImage BLOB NOT NULL,commentText TEXT NOT NULL, score INTEGER NOT NULL,date TEXT NOT NULL)"
        
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
    
    class func writeCommentDataToDatabase(tableName : String,commentrArray:NSArray){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let insertOrderData   = "INSERT INTO " + tableName + "(email,username,hImage,commentText,score,date) VALUES (?,?,?,?,?,?)"
        
        //print("\(path)")
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertOrderData, withArgumentsInArray: commentrArray as [AnyObject])
            
            db.close()
        })
        
    }
    
    class func readCommentDataFromDatabase(tableName : String) -> NSMutableArray{
        
        var tempArray = NSMutableArray()
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM " + tableName
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet =  db.executeQuery(queryData, withArgumentsInArray: [])
            
            while (rs.next()) {
                
                //email,username,hImage,commentText,score,date
                let modal = MUCommentModal()
                
                modal.email = rs.stringForColumn("email")
                
                modal.username = rs.stringForColumn("username")
                
                modal.hImage = rs.dataForColumn("hImage")
                
                modal.commentText = rs.stringForColumn("commentText")
                
                modal.score = Int(rs.intForColumn("score"))
                
                modal.date = rs.stringForColumn("date")
                
                tempArray.addObject(modal)
            }
            db.close()
        })
        
        if tempArray.count > 0 {
            
            tempArray = self.sortByDataArray(tempArray)
            
            //tempArray = self.sortGroupFromArray(tempArray)
        }
        
        return tempArray
        
    }
    
    private class func sortByDataArray(tempArray : NSMutableArray)-> NSMutableArray {
        
        
        let temp:NSArray = tempArray.sortedArrayUsingComparator({ (modal1, modal2) -> NSComparisonResult in
            
            
            let object1 = (modal1 as! MUCommentModal).date
            
            let object2 =  (modal2 as! MUCommentModal).date
            
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

   


    class func querryDataInDatabase(tableName : String,query : String) -> String {
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM " + tableName + " WHERE email = ?"
        
        var commentText = ""
        //UIColor
        let queue = FMDatabaseQueue(path: path)
        
        //self.queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery(queryData, values: [query])
                
                
                while rs.next() {
                    
                    commentText = rs.stringForColumn("commentText")
                    
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return  commentText
    }
    
    class func querryScoreInDatabase(tableName : String,query : String) -> Int {
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let queryData = "SELECT * FROM " + tableName + " WHERE email = ?"
        
        var commentText:Int = 0
        //UIColor
        let queue = FMDatabaseQueue(path: path)
        
        //self.queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery(queryData, values: [query])
                
                
                while rs.next() {
                    
                    commentText = Int(rs.intForColumn("score"))
                    
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return  commentText
    }



}
