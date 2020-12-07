//
//  Run.swift
//  Calories
//
//  Created by Зиновкин Евгений on 03.12.2020.
//  Copyright © 2020 Зиновкин Евгений. All rights reserved.
//

import UIKit

class Run: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool{
        get {
            return true
        }
    }
    
    var weightValue : String
    var timeValue : String
    var caloriesValue : String
    
   override init() {
        weightValue = ""
        timeValue = ""
        caloriesValue = ""
    super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(weightValue, forKey: "weightKey")
        coder.encode(timeValue, forKey: "timeKey")
        coder.encode(caloriesValue, forKey: "calloriesKey")
    }
    
    required init(coder: NSCoder) {
       weightValue = coder.decodeObject(forKey: "weightKey") as! String
        timeValue = coder.decodeObject(forKey: "timeKey") as! String
        caloriesValue = coder.decodeObject(forKey: "calloriesKey") as! String
        super.init()
    }
}

