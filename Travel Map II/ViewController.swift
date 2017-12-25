//
//  ViewController.swift
//  Travel Map II
//
//  Created by Subhamoy Paul on 12/25/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var chosenLatitude : Double = 0
    var chosenLongitude : Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapview and locationmanager attributes
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //gesture recognition
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let chosenCoordinate = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            self.chosenLatitude = chosenCoordinate.latitude
            self.chosenLongitude = chosenCoordinate.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = chosenCoordinate
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
        }
        
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context)
        newLocation.setValue(nameText.text, forKey: "title")
        newLocation.setValue(commentText.text, forKey: "subtitle")
        newLocation.setValue(self.chosenLatitude, forKey: "latitude")
        newLocation.setValue(self.chosenLongitude, forKey: "longitude")
        
        do {
            try context.save()
            print("we managed to save")
        } catch {
            print("error")
        }
        
        
        
    }
    
    



}

