//
//  MUSQLiteToolForContenViewController.swift
//  Wild
//
//  Created by Adaman on 3/26/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import UIKit

class MUSQLiteToolForContenViewController: NSObject {

  class func openDatabaseForSize(flag : Int) -> NSMutableArray{
        
        let tempArray:NSMutableArray = NSMutableArray()
        
        let queue:FMDatabaseQueue?
        
        // let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        
        queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT * FROM T_GoodsSize,T_GoodsInfo WHERE T_GoodsInfo.id =" + "\(flag + 1)" + " AND T_GoodsSize.id = T_GoodsInfo.id", values: nil)
                
                
                while rs.next() {
                    
                    var str = NSNumber(int: rs.intForColumn("size34"))
                    
                    tempArray.addObject(str)
                    
                    str = NSNumber(int: rs.intForColumn("size36"))
                    
                    tempArray.addObject(str)
                    
                    str = NSNumber(int: rs.intForColumn("size38"))
                    
                    tempArray.addObject(str)
                    
                    str = NSNumber(int: rs.intForColumn("size40"))
                    
                    tempArray.addObject(str)
                    
                    str = NSNumber(int: rs.intForColumn("size42"))
                    
                    tempArray.addObject(str)
                    
                    str = NSNumber(int: rs.intForColumn("size44"))
                    
                    tempArray.addObject(str)
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return tempArray
    }

    class func openDatabaseForDecription(flag : Int,tableName : String) -> NSMutableArray {
        
        //let tempArray:NSMutableArray = NSMutableArray()
        
        let tempArray:NSMutableArray = NSMutableArray()
        
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
                    
                    let tArray:NSMutableArray = NSMutableArray()
                    
                    let tempModal:MUExpandCellModal? = MUExpandCellModal()
                    
                    tempModal?.subDecription = rs.stringForColumn("subDecription")
                    
                    tempModal?.detailDecription = rs.stringForColumn("detailDecription")
                    
                    tArray.addObject(tempModal!)
                    
                    tempArray.addObject(tArray)
                    
                    
                    
                    let tArray1:NSMutableArray = NSMutableArray()
                    
                    MUSQLiteCommentTool.createDataBase(tableName)
                    
                    var commentModalArray = MUSQLiteCommentTool.readCommentDataFromDatabase(tableName)
                    
                    if commentModalArray.count > 0{
                        
                         commentModalArray = self.sortByCommentDataArray(commentModalArray)
                        
                        for element in commentModalArray{
                            
                            let commentModal = element as! MUCommentModal
                            
                            let tempModal1:MUExpandCellModal? = MUExpandCellModal()
                            
                            tempModal1?.subDecription = rs.stringForColumn("subDecription")
                            
                            tempModal1?.detailDecription = rs.stringForColumn("detailDecription")
                            
                            tempModal1?.modal = commentModal
                            
                            tArray1.addObject(tempModal1!)
                        }
                    }else{
                        
                        let tempModal1:MUExpandCellModal? = MUExpandCellModal()
                        
                        tempModal1?.subDecription = rs.stringForColumn("subDecription")
                        
                        tempModal1?.detailDecription = rs.stringForColumn("detailDecription")
                        
                         tArray1.addObject(tempModal1!)
                    }
                    
                    
                    tempArray.addObject(tArray1)
                    
                    
                    
                    
                    let tArray2:NSMutableArray = NSMutableArray()
                    
                    let tempModal2:MUExpandCellModal? = MUExpandCellModal()
                    
                    tempModal2?.subDecription = rs.stringForColumn("sizeDecription")
                    
                    tempModal2?.detailDecription = rs.stringForColumn("sizeDetailDecription")
                    
                    tArray2.addObject(tempModal2!)
                    
                    tempArray.addObject(tArray2)
                    
                    
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return tempArray
    }
    
    private class func sortByCommentDataArray(tempArray : NSMutableArray)-> NSMutableArray {
        
        
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


   class func openDatabase(flag : Int) -> NSMutableArray{
        
        let tempArray:NSMutableArray = NSMutableArray()
        
        
        let queue:FMDatabaseQueue?
        
        //let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        // print(path)
        //UIColor
        
        queue = FMDatabaseQueue(path: filePath as String)
        
        queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT T_GoodsColor_00.imageName img_00,T_GoodsColor_01.imageName img_01,T_GoodsColor_02.imageName img_02 FROM T_GoodsColor_00,T_GoodsColor_01,T_GoodsColor_02,T_GoodsInfo WHERE T_GoodsInfo.id = " + "\(flag + 1)" + " AND" + " T_GoodsInfo.id = T_GoodsColor_00.id AND T_GoodsColor_00.id = T_GoodsColor_01.id AND T_GoodsColor_01.id = T_GoodsColor_02.id", values: nil)
                
                
                while rs.next() {
                    
                    
                    var str = rs.stringForColumn("img_00")
                    
                    tempArray.addObject(str)
                    
                    str = rs.stringForColumn("img_01")
                    
                    tempArray.addObject(str)
                    
                    str = rs.stringForColumn("img_02")
                    
                    tempArray.addObject(str)
                    
                }
            }catch let error as NSError {
                
                print(error)
            }
            
            db.close()
        })
        
        return tempArray
        
    }
    
    private func randomFloat() -> Float {
        
        let num = arc4random() % 5 + 2
        
        //print("======================num==\(num)")
        
        srand48(Int(num))
        
        let numberFloat = Float(round(drand48() * 10) / 10)
        
        return numberFloat + Float(num)
    }

    
}
