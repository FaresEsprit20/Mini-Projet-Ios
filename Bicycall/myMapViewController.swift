//
//  myMapViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 8/12/2020.
//

import UIKit
import MapKit


extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 5, height: 5)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}


class myMapViewController: UIViewController, MKMapViewDelegate {
   
    
    enum PlaceType: String {
        case shop, community, circuit, cyclist

        var color: UIColor {
            switch self {
            case .shop:
                return .purple
            case .community:
                return .green
            case.circuit:
                return .red
            case .cyclist:
                return .yellow
            }
        }
        
        
    }
    
    struct Place {
        let id: Int
        let title: String
        let latitude: Double
        let longitude: Double
        let type: PlaceType
        
        var coordinate: CLLocationCoordinate2D {
                CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
    
    }
    
    
    var places: [Place] = []
    var shops = [Shops]()
    var communities = [Community]()
    var cyclists = [Cyclist]()
    var circuits = [Circuit]()
    var BR = BaseUrl.baseUrl
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    
    
    /*func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        switch annotation.title!! {
            case shop:
                annotationView.markerTintColor = UIColor(red: (69.0/255), green: (95.0/255), blue: (170.0/255), alpha: 1.0)
            case "Central Park":
                annotationView.markerTintColor = UIColor(red: (52.0/255), green: (114.0/255), blue: (1.0/255), alpha: 1.0)
            case "Empire State Building":
                annotationView.markerTintColor = UIColor(red: (246.0/255), green: (233.0/255), blue: (212.0/255), alpha: 1.0)
            case "Brooklyn Bridge":
                annotationView.markerTintColor = UIColor(red: (146.0/255), green: (187.0/255), blue: (217.0/255), alpha: 1.0)
            default:
                annotationView.markerTintColor = UIColor.blue
        }
        
        
        //annotationView.markerTintColor = UIColor.blue
        return annotationView
    }*/
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          guard annotation is MKPointAnnotation else { return nil }

          let identifier = "Annotation"
          var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

          if let annotationView = annotationView {
              annotationView.annotation = annotation
          } else {
              annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              annotationView?.canShowCallout = true
              if let place = places.first(where: { $0.title == annotation.title }) {
                  annotationView?.image = UIImage(color: place.type.color)
              }
          }
           return annotationView
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func addPlacesAnnotations() {
          for place in places {
              let pointAnnotation = MKPointAnnotation()
              pointAnnotation.title = place.title
              pointAnnotation.coordinate = place.coordinate
            DispatchQueue.main.async {
                self.myMap.addAnnotation(pointAnnotation)
            }
          }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.myMap.delegate = self
            
            self.getShops()
            self.getCircuits()
            self.getCyclists()
            self.getCommunities()
      
        //shops.append(Shops(id: 0, title: "Shop1", latitude: 36.553015 , longitude: 10.592774))
        //shops.append(Shops(id: 0, title: "Shop2", latitude: 35.499414 , longitude: 10.824846))
        //communities.append(Community(id: 0, title: "community1", latitude: 37.276943 , longitude: 10.934709 ))
        //communities.append(Community(id: 0, title: "community2", latitude: 35.427828 , longitude: 9.748186 ))
        //circuits.append(Circuit(id: 0, title: "circuit1", latitude: 33.773035 , longitude: 10.857805 ))
        //cyclists.append(Cyclist(id: 0, title: "cyclist1", latitude: 35.785118 , longitude: 10.000871 ))
    
   
        
    }
    

    
    
    func createShopsAnnotations(locations:[Shops]){
        
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location.title as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude as! CLLocationDegrees , longitude: location.longitude as! CLLocationDegrees)
            DispatchQueue.main.async {
                self.myMap.addAnnotation(annotations)
            }
            
        }}
        
        
        func createCircuitsAnnotations(locations:[Circuit]){
            
            for location in locations {
                let annotations = MKPointAnnotation()
                annotations.title = location.title as? String
                annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude as! CLLocationDegrees , longitude: location.longitude as! CLLocationDegrees)
                DispatchQueue.main.async {
                    self.myMap.addAnnotation(annotations)
                }
            }
            
    }

    

    func createCommunityAnnotations(locations:[Community]){
        
        for location in locations {
            
            let annotations = MKPointAnnotation()
            annotations.title = location.title as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude as! CLLocationDegrees , longitude: location.longitude as! CLLocationDegrees)
            DispatchQueue.main.async {
                self.myMap.addAnnotation(annotations)
            }
            
            
        }}
    
    
    
    func createCyclistsAnnotations(locations:[Cyclist]){
        
        for location in locations {
            
            let annotations = MKPointAnnotation()
            annotations.title = location.title as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude as! CLLocationDegrees , longitude: location.longitude as! CLLocationDegrees)
            
            DispatchQueue.main.async {
                self.myMap.addAnnotation(annotations)
            }
            
        }}
    
    func createPlacesAnnotations(locations:[Place]){
        
        for location in locations {
            
            let annotations = MKPointAnnotation()
            annotations.title = location.title as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude as! CLLocationDegrees , longitude: location.longitude as! CLLocationDegrees)
            
            DispatchQueue.main.async {
                self.myMap.addAnnotation(annotations)
            }
            
        }}
    
    
    func getShops(){
    
        //get
      
       guard let url = URL(string: BR+"/shops") else {
       return
       }
       let session = URLSession.shared
       session.dataTask(with: url)  { ( data , response ,error) in
           if let response = response {
               print(response)
           }
           
           if let data = data {
               print(data)
               do
               {
                   let json = try JSONSerialization.jsonObject(with: data, options: [])as! [[String:Any]]
                self.shops.removeAll()
                
                for item in json {
                    let id = item["shop_id"] as! Int
                    let title = item["title"] as! String
                    let latitude = item["latitude"] as! Double
                    let longitude = item["longitude"] as! Double
                    self.shops.append(Shops(id: id, title: title, latitude: latitude , longitude: longitude))
                    self.places.append(Place(id: id, title: title, latitude: latitude , longitude: longitude, type: .shop))
                 
                }
                
                for item in self.shops {
                    print(item.shop_id)
                    print(item.title)
                    print(item.latitude)
                    print(item.longitude)
                }
                //self.createShopsAnnotations(locations: self.shops)
                self.createPlacesAnnotations(locations: self.places)
              
               }catch{
                   print(error)
               }
           }
           
       }.resume()
        
            
        }
    
    
    
    
    func getCommunities(){
    
        //get
      
       guard let url = URL(string: BR+"/communities") else {
       return
       }
       let session = URLSession.shared
       session.dataTask(with: url)  { ( data , response ,error) in
           if let response = response {
               print(response)
           }
           
           if let data = data {
               print(data)
               do
               {
                   let json = try JSONSerialization.jsonObject(with: data, options: [])as! [[String:Any]]
                self.communities.removeAll()
                
                for item in json {
                    let id = item["community_id"] as! Int
                    let title = item["title"] as! String
                    let latitude = item["latitude"] as! Double
                    let longitude = item["longitude"] as! Double
                    self.communities.append(Community(id: id, title: title, latitude: latitude , longitude: longitude))
                    self.places.append(Place(id: id, title: title, latitude: latitude , longitude: longitude, type: .community))
                }
                
                for item in self.communities {
                    print(item.community_id)
                    print(item.title)
                    print(item.latitude)
                    print(item.longitude)
                }
                //self.createCommunityAnnotations(locations: self.communities)
                self.createPlacesAnnotations(locations: self.places)
               
               }catch{
                   print(error)
               }
           }
           
       }.resume()
        
            
        }
  
    
    
    
    func getCircuits(){
    
        //get
      
       guard let url = URL(string: BR+"/circuits") else {
       return
       }
       let session = URLSession.shared
       session.dataTask(with: url)  { ( data , response ,error) in
           if let response = response {
               print(response)
           }
           
           if let data = data {
               print(data)
               do
               {
                   let json = try JSONSerialization.jsonObject(with: data, options: [])as! [[String:Any]]
                self.circuits.removeAll()
                
                for item in json {
                    let id = item["circuit_id"] as! Int
                    let title = item["title"] as! String
                    let latitude = item["latitude"] as! Double
                    let longitude = item["longitude"] as! Double
                    self.circuits.append(Circuit(id: id, title: title, latitude: latitude , longitude: longitude))
                    self.places.append(Place(id: id, title: title, latitude: latitude , longitude: longitude, type: .circuit))
                }
                
                for item in self.circuits {
                    print(item.circuit_id)
                    print(item.title)
                    print(item.latitude)
                    print(item.longitude)
                }
                //self.createCircuitsAnnotations(locations: self.circuits)
                self.createPlacesAnnotations(locations: self.places)
               
               }catch{
                   print(error)
               }
           }
           
       }.resume()
        
            
        }
    
    
    func getCyclists(){
    
        //get
      
       guard let url = URL(string: BR+"/cyclists") else {
       return
       }
       let session = URLSession.shared
       session.dataTask(with: url)  { ( data , response ,error) in
           if let response = response {
               print(response)
           }
           
           if let data = data {
               print(data)
               do
               {
                   let json = try JSONSerialization.jsonObject(with: data, options: [])as! [[String:Any]]
                self.cyclists.removeAll()
                
                for item in json {
                    let id = item["cyclist_id"] as! Int
                    let title = item["title"] as! String
                    let latitude = item["latitude"] as! Double
                    let longitude = item["longitude"] as! Double
                    //self.cyclists.append(Cyclist(id: id, title: title, latitude: latitude , longitude: longitude))
                    self.places.append(Place(id: id, title: title, latitude: latitude , longitude: longitude, type: .cyclist))
                }
                
                for item in self.cyclists {
                    print(item.cyclist_id)
                    print(item.title)
                    print(item.latitude)
                    print(item.longitude)
                }
                //self.createCyclistsAnnotations(locations: self.cyclists)
                self.createPlacesAnnotations(locations: self.places)
               }catch{
                   print(error)
               }
           }
           
       }.resume()
        
            
        }
    
    
    

    
}

