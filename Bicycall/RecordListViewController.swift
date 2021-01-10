//
//  RecordListViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import UIKit
import CoreData

class RecordListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    //vars
    var BR = BaseUrl.baseUrl
    var u = ConnectedUser()
    var records =  [Records]()
    //widgets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mRecordCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        DispatchQueue.main.async {
            label.text = self.records[indexPath.row].daterecord
        }
        return cell!
    }

    //passage de parametres entre les controleurs
        //cell OnclickListener
        
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let bike = self.records[indexPath.row]
            performSegue(withIdentifier: "mRecordDetails" , sender: bike) //passage de variable locale)
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "mRecordDetails" {
        let bike = sender as! Records
        let destination = segue.destination as! RecordDetailsViewController
            destination.record_id = bike.record_id
            destination.distance = bike.distance
            destination.time = bike.time
            destination.address = bike.address
            destination.date_record = bike.daterecord
            destination.user_id = bike.user_id
          }
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleting ......")
            deleteItem(index: records[indexPath.row].record_id)
        }
    }
 
    func deleteItem(index:Int) {
        
        guard let url = URL(string: BR+"/records/delete") else {
        return
        }
        
        let bodyparameters = ["record_id": index ]
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyparameters, options: []) else {
            return
            }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data,response,error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                   // print(json);
                    DispatchQueue.main.async {
                    print(data)
                   
                            let alert = UIAlertController(title: "Success", message: "Record Deleted Successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                    }
                }
                
            }
            
        }.resume()
        
    }
    
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DisplayConnectedUser()
        
        //post
    
        guard let url = URL(string: BR+"/records/get") else {
        return
        }
        
        let bodyparameters = [ "user_id": String(self.u.user_id!) , "name": self.u.name! , "lastname": self.u.lastname! , "email": self.u.email! , "password": self.u.password! , "phone": self.u.phone! ] as [String : Any]
        
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
                    let rt = try JSONDecoder().decode([Record].self, from: data)
                
                        print(rt)
                        
                        for item in rt {
                            let id = item.record_id
                            let adresse = item.address
                            let distance = item.distance
                            let time = item.time
                            let date = item.daterecord
                            let user = item.user_id
                            
                            self!.records.append(Records(id: id, address: adresse, time: time, distance: distance, date: date, user: user))
                        }
                  
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
    
}
