//
//  signupVCViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 2/12/2020.
//

import UIKit

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
    
    
    @IBAction func btnSignup(_ sender: Any) {
        performSegue(withIdentifier: "msignuplogin", sender: "nil")
        
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
