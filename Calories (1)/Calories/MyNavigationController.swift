//
//  MyNavigationController.swift
//  Calories
//
//  Created by Зиновкин Евгений on 03.12.2020.
//  Copyright © 2020 Зиновкин Евгений. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController, UINavigationBarDelegate {

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        var result : Bool = true
        if let controller = self.topViewController as? CaloriesViewController{
            result = controller.validateFields()
        }
        return result
    }

    


}
