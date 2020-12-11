//
//  UpdateViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit

class UpdateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //widgets
    
    
    @IBOutlet weak var txtName: UIView!
    
    
    @IBOutlet weak var txtLastName: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtPasswordRepeat: UITextField!
    
    
    @IBOutlet weak var txtPhone: UITextField!
    
    //actions
    
    
    
    @IBAction func btnUpdate(_ sender: Any) {
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
