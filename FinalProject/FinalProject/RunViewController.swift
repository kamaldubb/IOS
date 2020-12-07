//
//  RunViewController.swift
//  FinalProject
//
//  Copyright © 2020 Sania Jain. All rights reserved.
//Author Sania Jain

import UIKit
import MapKit



class RunViewController: UIViewController {
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var startRunButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    //creating location manager variable globally
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    var isRunning = false
    var locationsCovered = [CLLocation]()
    var distanceRan = 0.0
    
    
    func startRun() {
        //reset
        reset()
        isRunning = true
        //hide distance label
        distanceLabel.isHidden = true
        mapView.showsUserLocation = true
        //to enable backgroundlocation update add a capability of background modes in signing and capability section
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func stopRun() {
        isRunning = false
        //unhide distance label
        distanceLabel.isHidden = false
        locationManager.allowsBackgroundLocationUpdates = false
        //disabling the user location from updating in mapview
        mapView.showsUserLocation = false
        locationManager.stopUpdatingLocation()
        //display route function call
        displayRoute()
    }
    
    func reset() {
        distanceRan = 0
        locationsCovered.removeAll()
    }
    
    @IBAction func runAction(_ sender: Any) {
        //check if title is start run, call start run function
        if startRunButton.title(for: .normal) == "START RUN" {
            startRunButton.setTitle("STOP RUN", for: .normal)
            startRun()
            startRunButton.setTitleColor(.red, for: .normal)
        } else {
            startRunButton.setTitle("START RUN", for: .normal)
            stopRun()
            startRunButton.setTitleColor(.green, for: .normal)
        }
    }
    
    
    //using this function to get the current location
    func currentLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *){
            locationManager.showsBackgroundLocationIndicator = true
            
        } else{
            //fallback to earlier version
        }
        locationManager.startUpdatingLocation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        // Do any additional setup after loading the view.
    }
    

    //function to set up map initially
    func setUpMapView(){
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        currentLocation()
    }
    
    //function to add locations to array of locations covered
    func addLocToArray(_ locations: [CLLocation]) {
        for location in locations{
            if !locationsCovered.contains(location){
                locationsCovered.append(location)
            }
        }
    }
    
    //editing some fields from numberformatter function
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    //function to calculate and display distance
    func calculateDistance(){
        var totalDistance = 0.0
        for i in 1..<locationsCovered.count{
            let previousLoc = locationsCovered[i-1]
            let currentLoc = locationsCovered[i]
            totalDistance += currentLoc.distance(from: previousLoc)
        }
        distanceRan = totalDistance
        let distancemetres = Measurement(value: distanceRan, unit: UnitLength.meters)
        let distancekm = distancemetres.converted(to: UnitLength.kilometers)
        let formattedDistance = numberFormatter.string(from: NSNumber(value: distancekm.value))!
        print("distance ran\(String(formattedDistance)) kilometres")
        distanceLabel.text = "You ran for \(String(formattedDistance)) kilometers."
        
        //check for unit and convert and display the distance in distance label
    }
    
    //function to display the route of run
    func displayRoute() {
        //add code to display the route on map
        //calculate the distance ran
        calculateDistance()
        
    }

}

extension RunViewController: CLLocationManagerDelegate {
    //implementing protocol methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        
        if isRunning {
            //add locations to array
            addLocToArray(locations)
        }
        
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        //locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


