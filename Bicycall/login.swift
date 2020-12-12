//
//  login.swift
//  Bicycall
//
//  Created by Jamil Joo on 2/12/2020.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
        guard let url = URL(string: "http://localhost:3000/login") else {
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
                   
                    self.id = user.user_id
                    self.name = user.name
                    self.lastname = user.lastname
                    self.email = user.email
                    self.password = user.password
                    self.phone = user.phone
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        if(user.user_id != 0){
                            //self.saveUser(user)
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
    
    
    func saveUser() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users" ,  in: managedContext)
             let object = NSManagedObject(entity: entityDescription , insertInto: managedContext )
                  object.setValue(value: id!  ,  forKey: "user_id"  )
                  object.setValue(value: email!  ,  forKey: "email"  )
                  object.setValue(value: password!  ,  forKey: "password"  )
                  object.setValue(value: name!  ,  forKey: "name"  )
                  object.setValue(value: lastname!  ,  forKey: "lastname"  )
                  object.setValue(value: phone!  ,  forKey: "phone"  )
        
                  
                  do {
                  
                 try managedContext.save()
                   print("INSERT SUCCESSFULLY")
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

    
    
}
