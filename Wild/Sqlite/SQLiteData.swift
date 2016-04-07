//
//  SQLiteData.swift
//  Wild
//
//  Created by Adaman on 2/26/16.
//  Copyright © 2016 Adaman. All rights reserved.
//

import Foundation
import UIKit

class SQLiteData: NSObject {

    var goodsInfo:NSMutableArray?
    private var queue:FMDatabaseQueue?
    
    private var itemHeight:CGFloat = 1.0
    
    private var image:UIImage?
    
    private  var itemWidth:CGFloat  = 1.0
    private var items:CGFloat      = 1.0
    private var space:CGFloat      = 1.0
    private let subItems:CGFloat   = 4.0

    
    override init() {
        
        super.init()
        
        //self.openDatabase()
        self.getSizeFromScreen()
        self.goodsInfo = NSMutableArray()
        
        //let filePath:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath:NSString = NSBundle.mainBundle().pathForResource("goods", ofType: "sqlite")!
        
        //let path = filePath.stringByAppendingPathComponent("goods.sqlite") as String
        
        
        //print(filePath)
        //UIColor
        
         self.queue = FMDatabaseQueue(path: filePath as String)
        
        self.queue?.inDatabase({ (db) -> Void in
            
            db.open()
            
            do {
                let rs:FMResultSet = try db.executeQuery("SELECT * FROM T_GoodsInfo", values: nil)
                
                
                while rs.next() {
                    
                    let modal = MUCollectionViewCellModal()
                    
                    //let imgPath = "images 2/" + rs.stringForColumn("imageName")
                    
                    let imagePath = NSBundle.mainBundle().pathForResource(rs.stringForColumn("imageName"), ofType: "jpg")
                    
                    self.image = UIImage(contentsOfFile: imagePath!)
                    
                    //print(rs.stringForColumn("goodsName"),rs.stringForColumn("priceText"))
                    
                    modal.textOfDetaile = rs.stringForColumn("goodsName")
                    
                    modal.imageName = rs.stringForColumn("imageName")
                    
                    modal.textOfPrice = rs.stringForColumn("priceText")
                    
                    modal.imageOfGoods = UIImage.resizeImage(image: self.image!, size: CGSizeMake(self.itemWidth, self.itemHeight))
                    
                    modal.code = rs.stringForColumn("saleCode")
                    
                    modal.numberOfCommentimage = self.randomFloat()
                    
                    self.goodsInfo?.addObject(modal)
                    
                }
            }catch let error as NSError {
                
                print(error)
            }

            db.close()
        })
        
    }
    
   private func randomFloat() -> Float {
        
        let num = arc4random() % 5 + 2
        
        //print("======================num==\(num)")
        
        srand48(Int(num))
        
        let numberFloat = Float(round(drand48() * 10) / 10)
        
        return numberFloat + Float(num)
    }

   private  func imageWithNewSize(image : UIImage,newSize : CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    private func getSizeFromScreen(){
        
        if UIDevice.currentDevice().model == "iPhone"{
            
            items = 2.0
            
            space = ((items-1)+2)*12
            
            itemWidth = (UIScreen.mainScreen().bounds.width)/items
            
            itemHeight = itemWidth*4/3
            
            
        }else if UIDevice.currentDevice().model == "iPad"{
            
            items = 3.0
            
            space = ((items-1)+2)*12
            
            itemWidth = (UIScreen.mainScreen().bounds.width)/items
            
            itemHeight = itemWidth*4/3
        }
        

    }
    

}
