//
//  rentlistViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 12/12/2020.
//

import UIKit
import CoreData

class rentlistViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    //widgets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    var u = ConnectedUser()
    var rents =  [Rent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.DisplayConnectedUser()
        /*DispatchQueue.main.async {
            self.getRents()
        }*/
  
    
        
        //post
    
        guard let url = URL(string: "http://localhost:3000/locations") else {
        return
        }
        
        let bodyparameters = [ "user_id": self.u.user_id! , "name": self.u.name! , "lastname": self.u.lastname! , "email": self.u.email! , "password": self.u.password! , "phone": self.u.phone! ] as [String : Any]
        
       print(bodyparameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyparameters, options: []) else{
            print("error in sending data")
            return
            }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] (data,response,error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                   // print(json);
                    print(data)
                    let rt = try JSONDecoder().decode([Rents].self, from: data)
                
                        print(rt)
                        
                        for item in rt {
                            let id = item.location_id
                            let adresselocation = item.adresselocation
                            let datelocation = item.datelocation
                            let user = item.user_id
                            let bike = item.bike_id
                            let model = item.model
                            let type = item.type
                            let price = item.price
                            let image = item.image
                            let hours = item.hours
                            let totalprice = item.totalprice
                            
                            self!.rents.append(Rent(id: id ,date: datelocation, adresse: adresselocation,user: user, bike: bike,  model: model , type: type , price: price, image: image , hours: hours , totalprice: totalprice))
                        }
                    for item in self!.rents {
                            print(item.location_id)
                            print(item.adresselocation)
                            print(item.datelocation)
                            print(item.user_id)
                            print(item.bike_id)
                            print(item.model)
                            print(item.type)
                            print(item.price)
                            print(item.image)
                            print(item.hours)
                            print(item.totalprice)
                        }
                    
                    print(self!.rents)
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                        
                }catch{
                    print("error in parsing")
                    print(error)
                }
                
            }
            
        }.resume()
        
        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rents.count
    }
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRent")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
     
        DispatchQueue.main.async {
            label.text = self.rents[indexPath.row].model
            print("heloooooo"+label.text!)
        }
            
        return cell!
    }
  
    
    //passage de parametres entre les controleurs
 
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rent = self.rents[indexPath.row]
            performSegue(withIdentifier: "mRentDetails" , sender: rent) //passage de variable locale)
            
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "mRentDetails" {
        
        let rent = sender as! Rent
        let destination = segue.destination as! RentDetailsViewController
            destination.id = rent.location_id
            destination.datelocation = rent.datelocation
            destination.hours = rent.hours
            destination.totalprice = rent.totalprice
            destination.bikemodel = rent.model
            destination.biketype = rent.type
            destination.priceperhour = rent.price
        
        }}
 
    
}
    

