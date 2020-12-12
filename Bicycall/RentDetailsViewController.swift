//
//  RentDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit

class RentDetailsViewController: UIViewController {

    
//vars
    
    var datelocation: String?
    var hours: String?
    var totalprice: String?
    var bikemodel: String?
    var biketype: String?
    var priceperhour: String?
    
    
//widgets
    
    @IBOutlet weak var lbdatelocation: UILabel!
    
    @IBOutlet weak var lbhours: UILabel!
    
    @IBOutlet weak var lbtotalprice: UILabel!
    
    @IBOutlet weak var lbbikemodel: UILabel!
    
    @IBOutlet weak var lbbiketype: UILabel!
    
    @IBOutlet weak var lbpriceperhour: UILabel!
    
//actions
    
    @IBAction func btnDelete(_ sender: Any) {
        
    }
    
 
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lbdatelocation.text = datelocation!
        lbhours.text = hours!
        lbtotalprice.text = totalprice!
        lbbikemodel.text = bikemodel!
        lbbiketype.text = biketype!
        lbpriceperhour.text = priceperhour!
        
    }
    

 
    
    
    

}
