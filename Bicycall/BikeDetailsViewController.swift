//
//  BikeDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit

class BikeDetailsViewController: UIViewController {

    //vars

    var model: String?
    var type: String?
    var mprice: String?
    var image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbmodel.text = model!
        lbtype.text = type!
        Price.text = mprice!
        bikeimage.image = UIImage(named: image!)
        
    }
    
    //widgets
    
    @IBOutlet weak var bikeimage: UIImageView!
    
    @IBOutlet weak var lbmodel: UILabel!
    
    @IBOutlet weak var lbtype: UILabel!
    
    
    @IBOutlet weak var Price: UILabel!
    
    
    //actions
    
    @IBAction func btnRent(_ sender: Any) {
        
    }
    
    
    @IBAction func btnFac(_ sender: Any) {
        
    }
    
    

}
