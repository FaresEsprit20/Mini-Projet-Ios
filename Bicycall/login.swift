//
//  login.swift
//  Bicycall
//
//  Created by Fares Ben Slama  on 9/12/2020.
//

import UIKit
import CoreData

class login: UIViewController {

    var id: Int?
    var name: String?
    var lastname: String?
    var email:String?
    var password:String?
    var phone:String?
    
    var u = ConnectedUser()
    var BR = BaseUrl.baseUrl
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.DeleteAllData()
        // Do any additional setup after loading the view.
    }
    
    //widgets
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    //Actions
    @IBAction func btnLogin(_ sender: Any){

         //get
       /*
        guard let url = URL(string: "http://localhost:3000/bikes") else {
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch{
                    print(error)
                }
            }
            
        }.resume()
        */
        
        //post
    
        guard let url = URL(string: BR+"/login") else {
        return
        }
        
        let bodyparameters = ["email": txtEmail.text, "password": txtPassword.text]
       
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
            
            if let data = data {
                do {
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                   // print(json);
                    print(data)
                    let user = try JSONDecoder().decode(User.self, from: data)
                   
                    DispatchQueue.main.async {
                        
                        self.id = user.user_id
                        self.name = user.name
                        self.lastname = user.lastname
                        self.email = user.email
                        self.password = user.password
                        self.phone = user.phone
                        
                        print(self.id!)
                        print(self.email!)
                        
                        
                        if(user.user_id != 0){
                           
                            self.saveUser()
                            self.DisplayConnectedUser()
                           self.performSegue(withIdentifier: "HomeSegue", sender: "nil")
                            
                        }else{
                        
                            let alert = UIAlertController(title: "Login Failed", message: "Wrong credentials", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                        }
                    
                    }
                    
                }catch{
                    print(error)
                }
                
            }
            
        }.resume()
        
        
    }
    
    
    func DeleteAllData(){

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Users"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }

    

    func saveUser() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users" ,  in: managedContext)
        let object = NSManagedObject(entity: entityDescription! , insertInto: managedContext )
        object.setValue(id!  ,  forKey: "user_id"  )
        object.setValue(email!  ,  forKey: "email"  )
        object.setValue(password!  ,  forKey: "password"  )
        object.setValue(name!  ,  forKey: "name"  )
        object.setValue(lastname!  ,  forKey: "lastname"  )
        object.setValue(phone!  ,  forKey: "phone"  )
        
                  do {
                  
                 try managedContext.save()
                   print("INSERT SUCCESSFULLY")
                print(id!)
                   }
                   catch  {
                   print("INSERT ERROR")
                   }
        
    }
    

    
    
    @IBAction func btnSignup(_ sender: Any) {
        performSegue(withIdentifier: "signupSegue", sender: "nil")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
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
