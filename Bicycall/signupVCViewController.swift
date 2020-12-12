//
//  signupVCViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 2/12/2020.
//

import UIKit
import CoreData

class signupVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //widgets
    var name: String?
    
  
    @IBOutlet weak var txtLastname: UITextField!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    

    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtPasswordrepeat: UITextField!
    
    
    @IBOutlet weak var txtPhone: UITextField!
    
    //Actions
    
    
    
    @IBAction func register(_ sender: Any) {

        
        print("hello")
          if(txtPassword.text != txtPasswordrepeat.text) {
              
              let alert = UIAlertController(title: "Register Failed", message: "Passwords Mismatch", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true)
            print("passwords mismatch")
              
          }else {
          
          //post
      
          guard let url = URL(string: "http://localhost:3000/register/") else {
          return
          }
          
          let bodyparameters = ["name": txtName.text,"lastname": txtLastname.text, "phone": txtPhone.text,"email": txtEmail.text, "password": txtPassword.text]
         
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
                          
                          
                        let string = dataString as! String
                        print(string)
                        if(string.elementsEqual("EXIST") == true  ){
                             
                              let alert = UIAlertController(title: "Register Failed", message: "User Already Exist", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                              self.present(alert, animated: true)
                            
                              
                          }else if(string.elementsEqual("OK") == true){
                          
                              let alert = UIAlertController(title: "Register Successful", message: "User Registred", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                              self.present(alert, animated: true)
                              
                          }
                      
                      }
                      
                  
              }
              
          }.resume()
          
          }
        
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    
    
    @IBAction func goToSignIN(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
