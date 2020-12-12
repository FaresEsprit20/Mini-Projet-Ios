//
//  myMapViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 8/12/2020.
//

import UIKit
import MapKit

class myMapViewController: UIViewController {

    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set initial location in Honolulu
        // Latitude and longitude of tunis
        //36.8065° N, 10.1815° E
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 36.8065, longitude: 10.1815)
        myMap.addAnnotation(annotation)
        
    }
    

}
