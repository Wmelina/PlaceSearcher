//
//  AddingViewController.swift
//  PlaceSearcher
//
//  Created by Alexandr Kurdyukov on 27.09.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import SwiftyJSON
/*
struct Places : Codable {
    var latitude = Double()
    var longitude = Double()
    var name = String()
    var info = String()
    var type = Int()
    init(latitude: Double, longitude: Double, name: String, info: String, type: Int) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.info = info
        self.type = type
    }
}
*/
class AddingViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var info: UITextField!
    @IBOutlet weak var typeTrigger: UISegmentedControl!
    var coordinate = CLLocationCoordinate2D()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinate = manager.location!.coordinate
    }

    @IBAction func postToDB(_ sender: Any) {
        Database.database().reference().setValue(createJson(latitude: coordinate.latitude, longitude: coordinate.longitude, name: name.text!, info: info.text!, type: typeTrigger.selectedSegmentIndex))
    }
    
    
    
    func createJson(latitude: Double, longitude: Double, name: String, info: String, type: Int) -> [String:Any] {
        let jsonData:[String:Any] = ["latitude" : latitude, "longitude" : longitude, "name" : name, "info" : info, "type": type]
        return jsonData
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
