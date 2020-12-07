//
//  ViewController.swift
//  FinalProject
//
//  Created by Rahul Auluck on 29/11/20.
//  Copyright © 2020 Sania Jain. All rights reserved.
//

import UIKit

class AppStartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //prepare function that is called as part of segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch(segue.identifier) {
        case "runTracker":
            print("run tracking")
        case "workoutTracker":
            print("workout tracking")
        default:
            preconditionFailure("unexpected segue id")
        }
    }

}

