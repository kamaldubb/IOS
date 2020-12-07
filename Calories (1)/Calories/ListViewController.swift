//
//  ListViewController.swift
//  Calories
//
//  Created by Зиновкин Евгений on 03.12.2020.
//  Copyright © 2020 Зиновкин Евгений. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var currentView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.runTableView.rowHeight = 100
        title = "My Runs"
    }
    var runStore = RunStore()
    required init?(coder: NSCoder) {
        super.init(coder : coder)
    }
    
   @IBOutlet weak var runTableView: UITableView!
    @IBAction func addNewRun(_ sender: Any) {
        let run = Run()
        runStore.runArray.append(run)
        let index = runStore.runArray.count - 1
        let indexPath = IndexPath(row: index, section: 0)
        runTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runTableView.reloadData()
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           case "editSegue"?:
               if let row = runTableView.indexPathForSelectedRow {
                   self.runTableView.deselectRow(at: row, animated: true)
                    let run = runStore.runArray[row.row]
                    let addViewController = segue.destination as! CaloriesViewController
                    addViewController.run = run
                    let totalCal = updateCal()
                    addViewController.totalRuns = "\(totalCal)"
               }
               break
               default:
               preconditionFailure("Unexpected segue identifier")
           }
       }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        if runTableView.isEditing{
            let editTitleBtn = NSLocalizedString("Edit", comment: "")
            sender.title = editTitleBtn
            runTableView.setEditing(false, animated: true)
        }else{
            let doneTitleBtn = NSLocalizedString("Done", comment: "")
            sender.title = doneTitleBtn
            runTableView.setEditing(true, animated: true)
        }
    }
    
    private func updateCal() -> String{
  
    var total = 0.00
        for i in 0..<runStore.runArray.count {
        let cal = Double(runStore.runArray[i].caloriesValue)
            total += cal ?? 0.00
    }
        let calTwoDigits : NSNumber = NSNumber(value: total)
                let nf = NumberFormatter()
                nf.maximumFractionDigits = 0
                nf.minimumFractionDigits = 2
        
        return String(describing: nf.string(from: calTwoDigits)!)
    }
}

extension ListViewController : UITableViewDataSource {
        
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "runCell", for: indexPath) as! RunTableViewCell
            let run = runStore.runArray[indexPath.row]
            
            let weightTxt = NSLocalizedString("My weight:", comment: "")
            cell.WeightLabel?.text = "\(weightTxt) \(run.weightValue)"
            let timeTxt = NSLocalizedString("Run time:", comment: "")
            cell.TimeLabel?.text = "\(timeTxt) \(run.timeValue)"
            let caloriesTxt = NSLocalizedString("Cal:", comment: "")
            cell.calLabel?.text = "\(caloriesTxt) \(run.caloriesValue)"
            
            return cell
        }
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return runStore.runArray.count
        }
}

extension ListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.runStore.runArray[sourceIndexPath.row]
        runStore.runArray.remove(at: sourceIndexPath.row)
        runStore.runArray.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let run = (runStore.runArray[indexPath.row])
            let deleteStr = NSLocalizedString("Delete", comment: "")
            let delStr = NSLocalizedString("Do you want to remove run?", comment: "")
            let alert = UIAlertController(title: deleteStr, message: delStr, preferredStyle: .actionSheet)
            let cancelBtn = NSLocalizedString("Cancel", comment: "")
            let cancelAction = UIAlertAction(title: cancelBtn, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let deleteBtn = NSLocalizedString("Delete", comment: "")
            let deleteAction = UIAlertAction(title: deleteBtn, style: .destructive, handler:
            {(action) ->
                Void in
                let v = self.runStore.runArray.firstIndex(of:  run)
                self.runStore.runArray.remove(at: v!)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alert.addAction(deleteAction)
            present(alert, animated: true, completion: nil)
            }
    }
    
   func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    

}

