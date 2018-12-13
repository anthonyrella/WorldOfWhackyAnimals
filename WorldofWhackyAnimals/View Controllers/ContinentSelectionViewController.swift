//
//  ContinentSelectionViewController.swift
//  WorldofWhackyAnimals
//
//  Created by Anthony Rella on 2018-11-18.
//  Copyright © 2018 AnthonyRella. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ContinentSelectionViewController: UIViewController, MKMapViewDelegate {
    
    let locationDictionary = ["North America":1, "South America":2,"Europe":3,"Africa":4,"Asia":5,"Australia":6,"Antartica":7,"THE PACIFIC OCEAN!?":8]
    
    let locationManager = CLLocationManager()
    let northAmerica = CLLocation(latitude: 43.655787, longitude: -79.739534)
    let southAmerica = CLLocation(latitude: -8.783195, longitude: -55.491478)
    let europe = CLLocation(latitude: 48.346895, longitude: 12.806909)
    let africa = CLLocation(latitude: 13.036669, longitude: 19.465645)
    let asia = CLLocation(latitude: 34.047863, longitude: 100.619652)
    let australia = CLLocation(latitude: -25.274399, longitude: 133.775131)
    let antartica = CLLocation(latitude: -82.862755, longitude: 135.000000)
    let secret = CLLocation(latitude: 32.435613, longitude: -174.550841)
    
    
    let globeLoc = CLLocationCoordinate2D(latitude: 43.655787, longitude: -79.739534)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var levelSelectionLabel: UILabel!
    @IBOutlet var myMapView : MKMapView!
    

    //todo center around current animal
    private func updateMapToShowGlobe(location :CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 130, longitudeDelta: 130)
        let region = MKCoordinateRegion(center: location, span: span)
        if( region.center.latitude > -90 && region.center.latitude < 90 && region.center.longitude > -180 && region.center.longitude < 180 ){
            myMapView.setRegion(region, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(appDelegate.currentDifficultySelection == nil){
        
            if(appDelegate.levelOfDifficulty != 8) {
            
                if(appDelegate.currentDifficultySelection != 8){
                
                    //Fill selection label from initial app load from database level of difficulty first. Should we auto increment to higher level????????????????
                    levelSelectionLabel.text = "Current Level Selection: \(appDelegate.levelOfDifficulty)"
                    
                }else{
                    
                  levelSelectionLabel.text = "Current Level Selection: BONUS"
                }
                
            }else{
                
                  levelSelectionLabel.text = "Current Level Selection: BONUS"
            }
           
        }else{
            
            if(appDelegate.currentDifficultySelection == 8){
                
                 levelSelectionLabel.text = "Current Level Selection: BONUS"
                
            }else{
                levelSelectionLabel.text = "Current Level Selection: \(appDelegate.currentDifficultySelection!)"
            }
            
        }
        
        updateMapToShowGlobe(location: globeLoc)
        let northAmericaDropPin = MKPointAnnotation()
        let southAmericaDropPin = MKPointAnnotation()
        let europeDropPin = MKPointAnnotation()
        let africaDropPin = MKPointAnnotation()
        let asiaDropPin = MKPointAnnotation()
        let australiaDropPin = MKPointAnnotation()
        let antarticaDropPin = MKPointAnnotation()
        let secretDropPin = MKPointAnnotation()
        
        
        let btn = UIButton(type: .detailDisclosure)
    
        let pin = MKPinAnnotationView()
        
        pin.rightCalloutAccessoryView = btn

        northAmericaDropPin.coordinate = northAmerica.coordinate
        northAmericaDropPin.title = "North America"
        northAmericaDropPin.subtitle = "Level 1: WHAC-A-BEAR!"
        
        southAmericaDropPin.coordinate = southAmerica.coordinate
        southAmericaDropPin.title = "South America"
        southAmericaDropPin.subtitle = "Level 2: WHAC-A-JAGUAR!"
        
        europeDropPin.coordinate = europe.coordinate
        europeDropPin.title = "Europe"
        europeDropPin.subtitle = "Level 3: WHAC-A-REINDEER!"
        
        africaDropPin.coordinate = africa.coordinate
        africaDropPin.title = "Africa"
        africaDropPin.subtitle = "Level 4: WHAC-A-LION!"
        
        asiaDropPin.coordinate = asia.coordinate
        asiaDropPin.title = "Asia"
        asiaDropPin.subtitle = "Level 5: WHAC-A-PANDA!"
        
        australiaDropPin.coordinate = australia.coordinate
        australiaDropPin.title = "Australia"
        australiaDropPin.subtitle = "Level 6: WHAC-A-KANGAROO!"
        
        antarticaDropPin.coordinate = antartica.coordinate
        antarticaDropPin.title = "Antartica"
        antarticaDropPin.subtitle = "Level 7: WHAC-A-PENGUIN!"
        
        secretDropPin.coordinate = secret.coordinate
        secretDropPin.title = "THE PACIFIC OCEAN!?"
        secretDropPin.subtitle = "Level BONUS: WHAC-A-DRAGONFLY!"
        
        
        self.myMapView.addAnnotation(northAmericaDropPin)
        self.myMapView.addAnnotation(southAmericaDropPin)
        self.myMapView.addAnnotation(europeDropPin)
        self.myMapView.addAnnotation(africaDropPin)
        self.myMapView.addAnnotation(asiaDropPin)
        self.myMapView.addAnnotation(australiaDropPin)
        self.myMapView.addAnnotation(antarticaDropPin)
        self.myMapView.addAnnotation(secretDropPin)
        
        self.myMapView.mapType = .mutedStandard
    
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if !(annotation is MKUserLocation) {
            
            let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
           
            //checking which Animals are playable. Users current level of success plus 1
            if(locationDictionary[annotation.title!!]! <= (appDelegate.levelOfDifficulty + 1)){
                    
                  //  print(locationDictionary[i]!)
                    print(annotation.title!!)
                  
                    let rightButton = UIButton(type: .contactAdd)
                    rightButton.tag = annotation.hash
                    
                    pinView.calloutOffset = CGPoint(x: -5, y: 5)
                    pinView.canShowCallout = true
                    pinView.rightCalloutAccessoryView = rightButton
                    pinView.tintColor = UIColor.red
                    pinView.image = UIImage(named: annotation.title!! as String)
                
                }else{
                
                //A user has to have beaten level 7 in order to be able to view the bonus level 8
                if(annotation.title != "THE PACIFIC OCEAN!?"){
                    
                     //display padlock
                     pinView.image = UIImage(named: "Padlock2")
                    
                }
            }
                
           return pinView
           
        }else {
            return nil
        }
        
    }
    
    // Level Selection. When the user presses the red plus sign, the level will get set in the app delegates currentDifficultySelection property
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            
         
            if(view.annotation!.title != "THE PACIFIC OCEAN!?" ){
                
                self.levelSelectionLabel.text = "Current Level Selection: \(locationDictionary[view.annotation!.title!!]!)"
                appDelegate.currentDifficultySelection = locationDictionary[view.annotation!.title!!]
                
                
            }else{
                
                 self.levelSelectionLabel.text = "Current Level Selection: BONUS"
                 appDelegate.currentDifficultySelection = locationDictionary[view.annotation!.title!!]
                
            }
           
            
            
       
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
