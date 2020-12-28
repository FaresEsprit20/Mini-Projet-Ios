//
//  UpdateViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {

    //vars
    
    var u = ConnectedUser()
    var BR = BaseUrl.baseUrl
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("UPDATE PROFILE  ")
        self.DisplayConnectedUser()
        txtName.text = self.u.name!
        txtLastName.text = self.u.lastname!
        txtPassword.text = self.u.password!
        txtPasswordRepeat.text = self.u.password!
        txtPhone.text = self.u.phone!
        
    }
    
    
    //widgets
    
    
   
    @IBOutlet weak var txtName: UITextField!
    
    
    
    @IBOutlet weak var txtLastName: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtPasswordRepeat: UITextField!
    
    
    @IBOutlet weak var txtPhone: UITextField!
    
    //actions
    
    
    
    @IBAction func btnUpdate(_ sender: Any) {
    print("Button Update")
        
        
        
        if ( txtName.text!.isEmpty || txtLastName.text!.isEmpty || txtPhone.text!.isEmpty  || txtPassword.text!.isEmpty || txtPasswordRepeat.text!.isEmpty) {
        
            let alert = UIAlertController(title: "Update Failed", message: "Fields must not be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
              
          } else if((txtPassword.text != txtPasswordRepeat.text) ) {
              let alert = UIAlertController(title: "Update Failed", message: "Passwords Mismatch", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true)
            print("passwords mismatch")
              
          }else if(txtPhone.text!.count != 8  ) {
                
                let alert = UIAlertController(title: "Update Failed", message: "Phone must be 8 numbers", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
          
          }else {
          
          
          //put query
            
          guard let url = URL(string: BR+"/user/update") else {
          return
          }
          
          
            // Create model
            struct UploadData: Codable {
                var name:String
                var lastname: String
                var password: String
                var phone: String
                var email: String
            }
            
            // Add data to the model
            let uploadDataModel = UploadData(name: txtName.text!, lastname: txtLastName.text! , password: txtPassword.text! , phone : txtPhone.text! , email: self.u.email!)
            self.u.name = txtName.text!
                self.u.lastname = txtLastName.text!
                self.u.password = txtPassword.text!
                self.u.phone =    txtPhone.text!
            
            
            // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            
            
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling PUT")
                    print(error!)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                
                
                if let data = data , let dataString = String(data: data, encoding: String.Encoding.utf8){
                     
                          print(data)
                          
                          DispatchQueue.main.async {
                              
                            print(dataString)
                       
                            if(dataString.contains("OK")){
                                self.saveUser()
                                print("User updated successfully")
                                  let alert = UIAlertController(title: "Update Successful", message: "User Updated Successfully", preferredStyle: .alert)
                                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                  self.present(alert, animated: true)
                                  
                              }
                          
                          }
                
                }
            }.resume()
          }
        
    }
    
    func saveUser() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users" ,  in: managedContext)
        let object = NSManagedObject(entity: entityDescription! , insertInto: managedContext )
        object.setValue(self.u.user_id!  ,  forKey: "user_id"  )
        object.setValue(self.u.email!  ,  forKey: "email"  )
        object.setValue(self.u.password!  ,  forKey: "password"  )
        object.setValue(self.u.name!  ,  forKey: "name"  )
        object.setValue(self.u.lastname!  ,  forKey: "lastname"  )
        object.setValue(self.u.phone!  ,  forKey: "phone"  )
        
                  do {
                  
                 try managedContext.save()
                   print("INSERT SUCCESSFULLY")
                    print(self.u.user_id!)
                   }
                   catch  {
                   print("INSERT ERROR")
                   }
        
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
