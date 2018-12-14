//
//  StoresNearMeViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-18.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit
import MapKit
class StoresNearMeViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet var myMapView : MKMapView!
    
    var locations = [CLLocation(latitude: 43.655787, longitude: -79.739534),
                     CLLocation(latitude: 43.469682, longitude: -79.697276),
                     CLLocation(latitude: 43.591278, longitude: -79.646814),
                     CLLocation(latitude: 43.774518, longitude: -79.257484),
                     CLLocation(latitude: 43.642667, longitude: -79.386531)]
    
    let locationManager = CLLocationManager()
    
    let regionRadius : CLLocationDistance = 20000
    
    func centerMapOnLocation()
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(locations[4].coordinate, regionRadius * 2.0, regionRadius * 2.0)
        myMapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func findStores()
    {
        centerMapOnLocation()
        
        for i in 0 ..< locations.count
        {
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = locations[i].coordinate
            myMapView.addAnnotation(dropPin)
            myMapView.selectAnnotation(dropPin, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let pinImage = UIImage(named: "shop")
        annotationView!.image = pinImage
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation selected")
        // get the particular pin that was tapped
        let pinToZoomOn = view.annotation
        
        // optionally you can set your own boundaries of the zoom
        let span = MKCoordinateSpanMake(0.5, 0.5)
        
        // or use the current map zoom and just center the map
        // let span = mapView.region.span
        
        // now move the map
        let region = MKCoordinateRegion(center: pinToZoomOn!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            findStores()
        }
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
