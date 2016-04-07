//
//  SQLiteDatabaseTool.swift
//  Wild
//
//  Created by Adaman on 3/18/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class SQLiteDatabaseTool: NSObject {

    class func openDatabaseForColor(flag : Int) -> NSMutableDictionary {
        
        let tempDict:NSMutableDictionary = NSMutableDictionary()
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT T_GoodsColor_00.imageName imageName_00,T_GoodsColor_00.color color_00,T_GoodsColor_01.imageName imageName_01,T_GoodsColor_01.color color_01,T_GoodsColor_02.imageName imageName_02,T_GoodsColor_02.color color_02 FROM T_GoodsColor_00,T_GoodsColor_01,T_GoodsColor_02 WHERE T_GoodsColor_00.id =" + "\(flag + 1)" + " AND T_GoodsColor_00.id = T_GoodsColor_01.id AND T_GoodsColor_01.id = T_GoodsColor_02.id", values: nil)
                
                
                while rs.next() {
                    
                    var imageName = rs.stringForColumn("imageName_00")
                    
                    var color =  rs.stringForColumn("color_00")
                    
                    tempDict.setObject(color, forKey : imageName)
                    
                    imageName = rs.stringForColumn("imageName_01")
                    
                     color =  rs.stringForColumn("color_01")
                    
                    tempDict.setObject(color, forKey : imageName)
                    
                    imageName = rs.stringForColumn("imageName_02")
                    
                    color =  rs.stringForColumn("color_02")
                    
                    tempDict.setObject(color, forKey : imageName)
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return tempDict

    }
    
    class func openDatabaseForDecription(flag : Int) -> NSMutableArray {
        
        //let tempArray:NSMutableArray = NSMutableArray()
        
        let tempArray:NSMutableArray? = []
        
        let queue:FMDatabaseQueue?
        
        //let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT * FROM T_GoodsDecription,T_GoodsInfo WHERE T_GoodsInfo.id =" + "\(flag + 1)" + " AND T_GoodsDecription.id = T_GoodsInfo.id", values: nil)
                
                
                while rs.next() {
                    
                    let tempModal:MUExpandCellModal? = MUExpandCellModal()
                    
                    tempModal?.subDecription = rs.stringForColumn("subDecription")
                    
                    tempModal?.detailDecription = rs.stringForColumn("detailDecription")
                    
                    tempArray?.addObject(tempModal!)
                    
                    let tempModal1:MUExpandCellModal? = MUExpandCellModal()
                    
                    tempModal1?.subDecription = rs.stringForColumn("goodsDecription")
                    
                    tempModal1?.detailDecription = rs.stringForColumn("goodsDetailDecription")
                    
                    tempArray?.addObject(tempModal1!)
                    
                    let tempModal2:MUExpandCellModal? = MUExpandCellModal()
                    
                    tempModal2?.subDecription = rs.stringForColumn("sizeDecription")
                    
                    tempModal2?.detailDecription = rs.stringForColumn("sizeDetailDecription")
                    
                    tempArray?.addObject(tempModal2!)
                    
                    
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return tempArray!

    }
    
    class func createDataBase() {
    
        let sqlStr = "Create Table If Not Exists T_TempRowHeight(id INTEGER PRIMARY KEY AUTOINCREMENT,indexPath TEXT UNIQUE,rowHeight INTEGER)"
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        queue = FMDatabaseQueue(path: path as String)
        
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
    
    class func writeDataToDatabase(text:String,rowHeight : Int){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let insertData = "INSERT INTO T_TempRowHeight (indexPath,rowHeight) VALUES (?,?)"
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: [text,rowHeight])
            
            db.close()
        })
    }
    
    class func queryDataFromDataBase(querryStr : String) -> CGFloat{
        
        let queue:FMDatabaseQueue?
        
        var tempFloat:CGFloat?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        let querryData = "SELECT T_TempRowHeight.rowHeight FROM T_TempRowHeight WHERE T_TempRowHeight.indexPath = ? "
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet =  db.executeQuery(querryData, withArgumentsInArray: [querryStr])
            
            while (rs.next()) {
                
                //imageName,price,title,size,color,time,date
                tempFloat = CGFloat(rs.intForColumn("rowHeight"))
            }

            
            db.close()
        })
        
        return tempFloat!
    }
    
   class func deleteDatabase() {
    
    let queue:FMDatabaseQueue?
    
    let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    
    let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
    
    let deleteData = "DROP TABLE T_TempRowHeight"
    
    queue = FMDatabaseQueue(path: path)
    
    queue?.inDatabase({ (db) -> Void in
        
        db.open()
        
        db.executeUpdate(deleteData, withArgumentsInArray: [])
        
       // db.executeUpdate("UPDATE sqlite_sequence set seq = 0 where name = 'T_TempRowHeight'", withArgumentsInArray: [])
        
        db.close()
    })

    }
    
    class func openDatabaseForImage(querryStr:String) ->NSMutableArray {
        
        let tempArray:NSMutableArray = NSMutableArray()
        
        
        let queue:FMDatabaseQueue?
        
        //let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        let str = "SELECT * FROM T_GoodsImage WHERE T_GoodsImage.imagePortrait = ? "
        // print(path)
        //UIColor
        
        queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
                let rs:FMResultSet = db.executeQuery(str, withArgumentsInArray: [querryStr])
                
                
                while rs.next() {
                    
                    
                    var str = rs.stringForColumn("imagePortrait")
                    
                    tempArray.addObject(str)
                    
                    str = rs.stringForColumn("imageBack")
                    
                    tempArray.addObject(str)
                    
                    str = rs.stringForColumn("imageFull")
                    
                    tempArray.addObject(str)
                    
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
        
        let insertData = "UPDATE T_TempRowHeight set rowHeight = ? WHERE indexPath = ?"
        
        queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(insertData, withArgumentsInArray: upDateDataWithRowHeight as [AnyObject])
            
            db.close()
        })
    }
    
    class func isHaveDataInCloumn(querryStr:String) ->Bool {
        
        var flag = false
        
        let queue:FMDatabaseQueue?
        
        //let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        let str = "SELECT * FROM T_TempRowHeight WHERE indexPath = ? "
        // print(path)
        //UIColor
        
        queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet = db.executeQuery(str, withArgumentsInArray: [querryStr])
            
            
            while rs.next() {
                
                
               flag = true
            }
            
            
            db.close()
        })
        
        return flag
        
    }

}
