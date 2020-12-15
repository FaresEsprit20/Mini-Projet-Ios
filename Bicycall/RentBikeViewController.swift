//
//  RentBikeViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 14/12/2020.
//

import UIKit
import CoreData

class RentBikeViewController: UIViewController {


    //vars

    var bike: Int?
    var price: String?
    var totalprice: String?
   
    var u = ConnectedUser()
    
    
    //widgets
    
    @IBOutlet weak var txtHours: UITextField!
    
    @IBOutlet weak var txtAdresselocation: UITextField!
    
    @IBOutlet weak var txtDatelocation: UITextField!
    //actions
    
    @IBAction func btnRentBike(_ sender: Any) {
        
        //post
    
        guard let url = URL(string: "http://localhost:3000/location/add") else {
        return
        }
        
        let r = RentX(id: 0 , date: txtDatelocation.text! , adresse: txtAdresselocation.text!, user:self.u.user_id! , bike: bike! ,  hours: txtHours.text!, totalprice: String(Int(txtHours.text!)! * Int(self.price!)! ))
        r.location_id = 0
        r.adresselocation = txtAdresselocation.text!
        r.datelocation = txtDatelocation.text!
        r.hours = txtHours.text!
        r.totalprice = String(Int(txtHours.text!)! * Int(self.price!)! )
        r.bike_id = bike!
        r.user_id = self.u.user_id!
        
        
        
        let bodyparameters = ["adresselocation": r.adresselocation,"datelocation": r.datelocation, "hours": r.hours,"totalprice": r.totalprice, "bike_id": r.bike_id , "user_id": self.u.user_id!] as [String : Any]
        
        
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyparameters, options: []) else{
            return
            }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data,response,error) in
            if let response = response {
                print(response)
            }
            
          if let data = data , let dataString = String(data: data, encoding: String.Encoding.utf8){
               
                    print(data)
                    
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "Rent Added Successfully , visit one of our shops and take your bike", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
                          
                
            }
            
        }.resume()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DisplayConnectedUser()
        
        
        
    }
    

    
    func DisplayConnectedUser() {
            
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //represente l'ORM
                let persistentContainer = appDelegate.persistentContainer
                
                let managedContext = persistentContainer.viewContext     //retourne NSManagedObject toujours
                
                //la requete retourne un NSManagedObject
                let request = NSFetchRequest<NSManagedObject>(entityName :   "Users")
                
                //execution de la requete
                do {
                
                    let result = try  managedContext.fetch(request)
                for item in result {
                    print(item.value(forKey: "user_id") as! Int )
                    print(item.value(forKey: "email")  as! String)
                    self.u.user_id  = (item.value(forKey: "user_id")  as! Int)
                    self.u.email = (item.value(forKey: "email")  as! String)
                    self.u.password = (item.value(forKey: "password")  as! String)
                    self.u.name = (item.value(forKey: "name")  as! String)
                    self.u.lastname = (item.value(forKey: "lastname")  as! String)
                    self.u.phone = (item.value(forKey: "phone")  as! String)
                   
                    print(self.u.user_id!)
                    print(self.u.email!)
                    print(self.u.password!)
                    print(self.u.name!)
                    print(self.u.lastname!)
                    print(self.u.phone!)
                  
                }
                
                   }
                   catch {
                   print("NO DATA FOUND , Error")
                   }

        }
    
    
  
}
