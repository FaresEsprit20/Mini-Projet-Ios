//
//  ViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 1/12/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //actions
    
    @IBAction func btnFind(_ sender: Any) {
        
    }
    
    
    @IBAction func btnUpdate(_ sender: Any) {
    }
    
    
    
    @IBAction func btnRent(_ sender: Any) {
        
    }
    
    @IBAction func btnTrack(_ sender: Any) {
    }
    
    @IBAction func btnContact(_ sender: Any) {
        
    }
    
    
    @IBAction func btnLogout(_ sender: Any) {

        performSegue(withIdentifier: "mLogout", sender: nil)
        
    }
    
    
    
    
    
    
}

