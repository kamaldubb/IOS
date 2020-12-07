//
//  RunStore.swift
//  Calories
//
//  Created by Зиновкин Евгений on 03.12.2020.
//  Copyright © 2020 Зиновкин Евгений. All rights reserved.
//

import UIKit

class RunStore: NSObject {
    var runArray : [Run] = []
       let runArchiveURL : URL = {
           let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           var documentDirectory = documentDirectories.first!
           print(documentDirectory)
           return documentDirectory.appendingPathComponent("run.archive")
       }()
       
    override init(){
           do {
               if let data = UserDefaults.standard.data(forKey: "SavedItems"){
                   let archivedItems = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Run.self], from: data) as? [Run]
                   self.runArray = archivedItems!
               }else{
                   print("data does not exist in defaults")
               }
           } catch {
              print("unarchived failed")
           }
       }
       
       func saveChanges() -> Bool{
           var result : Bool = true
           print("Saving items to \(runArchiveURL.path)")
           
           do{
               let data = try NSKeyedArchiver.archivedData(withRootObject: runArray, requiringSecureCoding: true)
               try data.write(to: runArchiveURL)
               UserDefaults.standard.set(data, forKey: "SavedItems")
           } catch {
               result = false
               print("write failed")
           }
           return result
       }

}
