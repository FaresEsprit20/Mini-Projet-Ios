//
//  EventDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/1/2021.
//

import UIKit
import CoreData

class EventDetailsViewController: UIViewController {

//vars
    
    var event_id: Int?
    var event_title: String?
    var adresse_evt: String?
    var date_evt: String?
    var time_evt: String?
    var user: Int?
    var BR = BaseUrl.baseUrl
    var u = ConnectedUser()

    
//widgets
    
    @IBOutlet weak var txtTitle: UILabel!
    
    @IBOutlet weak var txtAdress: UILabel!
    
    @IBOutlet weak var txtDate: UILabel!
    
    @IBOutlet weak var txtTime: UILabel!
    
    //Actions
    
    @IBAction func btnParticipate(_ sender: Any) {
        
        
    }
    
    @IBAction func btnParticipants(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DisplayConnectedUser()
        
        txtTitle.text = event_title!
        txtAdress.text = adresse_evt!
        txtDate.text = date_evt!
        txtTime.text = time_evt!
        
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
