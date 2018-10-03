//
//  MapViewController.swift
//  PlaceSearcher
//
//  Created by Alexandr Kurdyukov on 27.09.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var placeType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        addMarkOnMap(latitude: 35.7020691, longitude: 139.7753268, title: "MARAKANA", subtitle: "Pomoika dlya daunov", type: 0)
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        Database.database().reference().observe(.value, with: { (snapshot) in
            guard let value = snapshot.value, snapshot.exists() else {
                print("Error")
                return
            }

        })
        
    }
    
    func addMarkOnMap(latitude: Double, longitude: Double, title: String, subtitle: String, type: Int) {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        
        map.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print(locValue.latitude)
        print(locValue.longitude)
        let userLoc = locations.last
        let viewReg = MKCoordinateRegion.init(center: (userLoc?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewReg, animated: true)
        
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
