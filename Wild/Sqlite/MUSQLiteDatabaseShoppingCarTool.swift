//
//  MUSQLiteDatabaseShoppingCarTool.swift
//  Wild
//
//  Created by Adaman on 3/11/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSQLiteDatabaseShoppingCarTool: NSObject {

    
   static var totalPrice:Float = 0
    
   static var numberOfCount:Int = 0
    
   static var codeArray:NSMutableArray = []
    
    static var codeDict:NSMutableDictionary?
    
    class func createDataBase(){
        
        let queue:FMDatabaseQueue?
        
        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
       //let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        let createDatabase = "CREATE TABLE IF NOT EXISTS T_ShoppingCar (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,imageName TEXT NOT NULL UNIQUE,price TEXT NOT NULL,title TEXT NOT NULL,size TEXT NOT NULL,color TEXT NOT NULL,time TEXT NOT NULL,date TEXT NOT NULL,code TEXT NOT NULL)"
        
        queue = FMDatabaseQueue(path: path as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                
                _ = try db.executeUpdate(createDatabase, values: [])
                
            }catch let error as NSError{
                
                print("error=\(error)")
            }
            
            db.close()
        })
        
    }
    
    class func writeDataToDatabase(array:NSArray){
        
        let queue:FMDatabaseQueue?

        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
       // let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!

        let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String

        let insertData        = "INSERT INTO T_ShoppingCar (imageName,price,title,size,color,time,date,code) VALUES (?,?,?,?,?,?,?,?)"

        print("\(path)")

        queue                 = FMDatabaseQueue(path: path as String)

        queue?.inDatabase({ (db) -> Void in

            db.open()

            db.executeUpdate(insertData, withArgumentsInArray: array as [AnyObject] )

            db.close()
        })
        
    }

    class func readDataFromDatabase() -> NSMutableArray{
        
        var tempArray         = NSMutableArray()

        var tempPirce:Float   = 0

        let queue:FMDatabaseQueue?

        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]

        let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String

        let queryData         = "SELECT * FROM T_ShoppingCar"

        queue                 = FMDatabaseQueue(path: path)

        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            
            let rs:FMResultSet =  db.executeQuery(queryData, withArgumentsInArray: [])
            
            while (rs.next()) {
                
                //imageName,price,title,size,color,time,date
                let modal       = MUShoppingCarModal()

                modal.imageName = rs.stringForColumn("imageName")

                modal.price     = rs.stringForColumn("price")

                let price       = (modal.price! as NSString).floatValue

                tempPirce       = tempPirce + price

                modal.title     = rs.stringForColumn("title")

                modal.color     = rs.stringForColumn("color")

                modal.size      = rs.stringForColumn("size")

                modal.time      = rs.stringForColumn("time")

                modal.date      = rs.stringForColumn("date")

                modal.code      = rs.stringForColumn("code")


                tempArray.addObject(modal)
            }
            
            db.close()
        })
        
        self.totalPrice = tempPirce
        
        if tempArray.count > 0 {

            self.numberOfCount = tempArray.count

            tempArray          = self.sortByDataarray(tempArray)

            self.codeArray     = self.getPromoCodeFromDataArray(tempArray)

            self.codeDict      = self.createPromoCodeDictionary(self.codeArray)

            tempArray          = self.sortGroupFromArray(tempArray)
            
        }
        
        return tempArray
        
        
    }

    class func deleteRowDataFromDatabase(querryStr:String){
        
        let queue:FMDatabaseQueue?

        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]

        let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String

        let deleteData        = "DELETE FROM T_ShoppingCar WHERE T_ShoppingCar.imageName = ?"

        queue                 = FMDatabaseQueue(path: path)

        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(deleteData, withArgumentsInArray: [querryStr])
            
            db.close()
        })
        
    }
    
    class func deletedDatabase() {
        
        let queue:FMDatabaseQueue?

        let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]

        let path              = filePath.stringByAppendingPathComponent("goods.sqlite") as String

        let deleteData        = "DELETE FROM T_ShoppingCar"

        queue                 = FMDatabaseQueue(path: path)

        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            db.executeUpdate(deleteData, withArgumentsInArray: [])
            
            db.close()
        })

    }
  private class func sortGroupFromArray(tempArray : NSMutableArray) -> NSMutableArray {
    
    var currentDate:String?        = (tempArray[0] as! MUShoppingCarModal).date

    let groupArray:NSMutableArray? = []

    var tArray:NSMutableArray?     = []

    for (_,element) in tempArray.enumerate() {
        
        let modal = element as! MUShoppingCarModal

        if modal.date == currentDate {
            
           tArray?.addObject(modal)
            
//            if index == tempArray.count - 1 {
//                
//                 groupArray?.addObject(tArray!)
//            }
        
        }else{
            
            groupArray?.addObject(tArray!)

            tArray      = NSMutableArray()

            currentDate = modal.date

            tArray?.addObject(modal)
            
//            if index == tempArray.count - 1 {
//                
//
//            }
        }
    }
    groupArray?.addObject(tArray!)
    
    return groupArray!
  }
    
  private class func sortByDataarray(tempArray : NSMutableArray)-> NSMutableArray {
        

        let temp:NSArray = tempArray.sortedArrayUsingComparator({ (modal1, modal2) -> NSComparisonResult in


        let object1      = (modal1 as! MUShoppingCarModal).time

        let object2      = (modal2 as! MUShoppingCarModal).time

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
    
    private class func getPromoCodeFromDataArray(tempArray : NSMutableArray) -> NSMutableArray {
        
        let temp = NSMutableArray()
        
        for element in tempArray {
            
            let modal = element as! MUShoppingCarModal
            
            temp.addObject(modal.code!)
        }
        
        return temp
    }

    private class func createPromoCodeDictionary(tempArray : NSMutableArray) -> NSMutableDictionary {
        
        let tempDict = NSMutableDictionary()
        
        for element in tempArray {
            
            let codeStr = element as! String
            
            let rFloat = self.randomFloat() * 100
            
            tempDict.setValue(rFloat, forKey: codeStr)
        }
        
        return tempDict
    }
    
    private class func randomFloat() -> Float {
        
        let num = random()
        
        srand48(num)
     
        let numberFloat = Float(round(drand48() * 10000) / 10000) / 10
        
        return numberFloat
    }
}
