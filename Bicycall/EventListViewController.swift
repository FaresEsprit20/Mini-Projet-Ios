//
//  EventListViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/1/2021.
//

import UIKit
import CoreData

class EventListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    //vars
    
    var events =  [Event]()
    var BR = BaseUrl.baseUrl
    var u = ConnectedUser()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mEvent")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        let image = contentView?.viewWithTag(2) as! UIImageView
        
        DispatchQueue.main.async {
            label.text = self.events[indexPath.row].event_title
            image.image = UIImage(named: "event-1")
        
        }
        return cell!
    }
    
    //passage de parametres entre les controleurs
        //cell OnclickListener
        
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let bike = self.events[indexPath.row]
            performSegue(withIdentifier: "EventDetails" , sender: bike) //passage de variable locale)
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "EventDetails" {
        let bike = sender as! Event
        let destination = segue.destination as! EventDetailsViewController
            destination.event_id = bike.event_id
            destination.event_title = bike.event_title
            destination.adresse_evt = bike.adresse_evt
            destination.date_evt = bike.date_evt
            destination.time_evt = bike.time_evt
            destination.user = bike.user
          }
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.DisplayConnectedUser()

        //get
      
       guard let url = URL(string: BR+"/events/all") else {
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
                self.events.removeAll()
                print(json)
                for item in json {
                    let id = item["event_id"] as! Int
                    let title = item["event_title"] as! String
                    let adresse = item["adresse_evt"] as! String
                    let date = item["date_evt"] as! String
                    let time = item["time_evt"] as! String
                    let user  = item["user"] as! Int
                    
                    self.events.append(Event(id: id ,event_title: title ,adress_evt: adresse ,date_evt: date ,time_evt: time, user: user))
                    if(id == 0 ){
                        self.events.removeAll()
                    }
                }
                
                for item in self.events {
                    print(item.event_id)
                    print(item.event_title)
                    print(item.adresse_evt)
                    print(item.date_evt)
                }
             
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
               }catch{
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
    
    
}
