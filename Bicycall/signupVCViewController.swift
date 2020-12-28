//
//  signupVCViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit
import CoreData

class signupVCViewController: UIViewController {

    var BR = BaseUrl.baseUrl
    
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
        
        if ( txtName.text!.isEmpty || txtLastname.text!.isEmpty || txtPhone.text!.isEmpty || txtEmail.text!.isEmpty || txtPassword.text!.isEmpty || txtPasswordrepeat.text!.isEmpty) {
        
            let alert = UIAlertController(title: "Register Failed", message: "Fields must not be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
              
          } else if((txtPassword.text != txtPasswordrepeat.text) ) {
              
              let alert = UIAlertController(title: "Register Failed", message: "Passwords Mismatch", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true)
            print("passwords mismatch")
              
          }else if(txtPhone.text!.count != 8  ) {
                
                let alert = UIAlertController(title: "Register Failed", message: "Phone must be 8 numbers", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
          
          }else if(self.isValidEmail(txtEmail.text!) == false ) {
                  
                  let alert = UIAlertController(title: "Register Failed", message: "Email is not valid", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                  self.present(alert, animated: true)
          }else {
          
          //post
      
          guard let url = URL(string: BR+"/register/") else {
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
                          
                        
                        print(dataString)
                        if(dataString.contains("EXIST") ){
                             print("User exist already")
                              let alert = UIAlertController(title: "Register Failed", message: "User Already Exist", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                              self.present(alert, animated: true)
                            
                              
                          }else if(dataString.contains("OK")){
                            print("User registred successfully")
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
    

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    
    
    @IBAction func goToSignIN(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
