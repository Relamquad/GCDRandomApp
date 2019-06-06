//
//  Model.swift
//  GCDRandomApp
//
//  Created by Konstantin Kalivod on 6/6/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class MyModel {
    
    // MARK: - Random String
    class func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    // MARK: - Generator Random Strings
    class func generatorRandomStrings(length: Int) {

        var array = [String]()
        for _ in 0 ... length {
            print(randomString(length: 5))
            array.append(randomString(length: 5))
            addToCoreData(string: randomString(length: 5))

        }
        
    }
    
    class func addToCoreData(string: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let privateManagedObjectContext: NSManagedObjectContext = {
            let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            moc.parent = context
            return moc
        }()
        let titleObject = NSEntityDescription.insertNewObject(forEntityName: "Titles", into: privateManagedObjectContext) as! Titles
        titleObject.title = string
        privateManagedObjectContext.perform {
        do {
            try privateManagedObjectContext.save()
            print("All okey!!!!")
        } catch {
            print(error.localizedDescription)
            }
            
        }
    }
}
