//
//  AddRecordViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import UIKit
import CoreData

class AddRecordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.DisplayConnectedUser()
    }

    //vars
    var BR = BaseUrl.baseUrl
    var u = ConnectedUser()
    
    
    //widgets
    
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtDistance: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    
    
    //actions
    @IBAction func btnRecord(_ sender: Any) {
     
        //post
        guard let url = URL(string: BR+"/records/add") else {
        return
        }
        
        let bodyparameters = ["distance": txtDistance.text!,"time": txtTime.text!, "address": txtAddress.text!,"user_id": String(self.u.user_id!), "daterecord": txtDate.text!] as [String : Any]
       
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
                        print("Record Added Successfully")
                         let alert = UIAlertController(title: "Success", message: "Record Added Successfully", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                         self.present(alert, animated: true)
                      print(dataString)
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
