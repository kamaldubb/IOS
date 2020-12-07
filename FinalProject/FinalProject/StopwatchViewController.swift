//
//  StopwatchViewController.swift
//  FinalProject
//
//  Copyright © 2020 Sania Jain. All rights reserved.
//
//Author - Sania Jain
import UIKit


class StopWatchViewController: UIViewController {


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var counter = 0.0
        var timer = Timer()
        var isCounting = false
        
        @objc func UpdateTimer(){
            counter = counter + 0.1
            timeLabel.text = "\(String(format: "%.1f", counter)) seconds"
        }
        @IBAction func startTimer(_ sender: Any) {
            if isCounting{
                return
            }
            displayLabel.text = ""
            startButton.isEnabled = false
            pauseButton.isEnabled = true
            stopButton.isEnabled = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            isCounting = true
        }
    //editing some fields from numberformatter function
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    @IBAction func stopTimer(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        pauseButton.isEnabled = false
        timer.invalidate()
        //add number formatter here.
        let timeSeconds = Measurement(value: counter, unit: UnitDuration.seconds)
        let timeMinutes = timeSeconds.converted(to: UnitDuration.minutes)
        let formattedTime = numberFormatter.string(from: NSNumber(value: timeMinutes.value))!
        displayLabel.text = "You have worked out for \(String(formattedTime)) minutes"
        counter = 0.0
        //timeLabel.text = String(counter)
        
    }
        
        @IBAction func pauseTimer(_ sender: Any) {
            startButton.isEnabled  = true
            pauseButton.isEnabled = false
            stopButton.isEnabled = true
            timer.invalidate()
            isCounting = false
        }
        
        
        @IBAction func resetTimer(_ sender: Any) {
            startButton.isEnabled = true
            pauseButton.isEnabled = false
            stopButton.isEnabled = true
            displayLabel.text = ""
            timer.invalidate()
            isCounting = false
            counter = 0.0
            timeLabel.text = String(counter)
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            displayLabel.text = ""
            timeLabel.text = String(counter)
            pauseButton.isEnabled = false
            // Do any additional setup after loading the view.
        }


    }


    
