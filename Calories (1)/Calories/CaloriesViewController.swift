//
//  CaloriesViewController.swift
//  Calories
//
//  Created by Зиновкин Евгений on 03.12.2020.
//  Copyright © 2020 Зиновкин Евгений. All rights reserved.
//

import UIKit

class CaloriesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Enter options"
    }
    var run = Run()
    var totalRuns : String = ""
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    let fillFieldsTitle = NSLocalizedString("Error", comment: "")
    var validated : Bool = false
    
    
    @IBAction func tapGesture(_ sender: Any) {
        if weightField.isFirstResponder {
            weightField.resignFirstResponder()
        }else if timeField.isFirstResponder {
            timeField.resignFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(run.weightValue != ""){
            weightField.text = run.weightValue
         }
         if(run.timeValue != ""){
            timeField.text = run.timeValue
         }
         let totalOfTxt = NSLocalizedString("Total burned", comment: "")
         let caloriesTxt = NSLocalizedString("Cal", comment: "")
         totalLabel.text = "\(totalOfTxt) \(totalRuns) \(caloriesTxt)"
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    @IBAction func calculateBtn(_ sender: Any) {
        let value =  3.5
        let met = 10.00
        let time:Double? = Double(timeField.text!)
        let weight:Double? = Double(weightField.text!)
        let total:Double? = time!*(met*value*weight!)/200
        //total = timeReal * (met*value*weightReal)/200
        let _: String = String(total!)
    
    }
    func addCallories()->String{
        let value =  3.5
        let met = 10.00
        let time:Double? = Double(timeField.text!)
        let weight:Double? = Double(weightField.text!)
        let total:Double? = time!*(met*value*weight!)/200
        //total = timeReal * (met*value*weightReal)/200
        let cal: String = String(total!)
        return cal
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
         view.endEditing(true)
        run.weightValue = weightField.text ?? ""
        run.timeValue = timeField.text ?? ""
        run.caloriesValue = addCallories()
    }
    
    func validateFields()-> Bool {
         if checkText(weightField.text!) && checkText(timeField.text!)    {
             return true
        }else{
            return false
        }
    }
    
    private func checkText(_ strNumber : String)->Bool {
        var result : Bool = true
        if strNumber.count == 0 {
            let blankFieldsMsg = NSLocalizedString("Fill time/weight fields", comment: "")
           showMessage(str: blankFieldsMsg ,title: fillFieldsTitle)
            result = false
        }
        return result
    }
    
   
    
    private func showMessage(str: String? = nil, title : String?){
        let alert = UIAlertController(title: title, message: str, preferredStyle: .alert)
        let okBtn = NSLocalizedString("Ok", comment: "")
        alert.addAction(UIAlertAction(title: okBtn, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

   

}

extension CaloriesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var result : Bool = true
        let currentLocale = NSLocale.current
        let decimalSeparator = currentLocale.decimalSeparator!
        if let oldString = textField.text{
            if let _ = oldString.range(of: decimalSeparator){
                if let _ = string.range(of: decimalSeparator){
                    result = false
                }
            }
        } else{
            result = false
        }
        return result
    }
}



extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
 
