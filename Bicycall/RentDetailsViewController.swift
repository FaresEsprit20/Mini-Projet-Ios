//
//  RentDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit

class RentDetailsViewController: UIViewController {

    
//vars
    var id : Int?
    var datelocation: String?
    var adresse: String?
    var hours: String?
    var totalprice: String?
    var bikemodel: String?
    var biketype: String?
    var priceperhour: String?
    var BR = BaseUrl.baseUrl
    
//widgets
    
    @IBOutlet weak var lbdatelocation: UILabel!
    
    @IBOutlet weak var lbadresse: UILabel!
    @IBOutlet weak var lbhours: UILabel!
    
    @IBOutlet weak var lbtotalprice: UILabel!
    
    @IBOutlet weak var lbbikemodel: UILabel!
    
    @IBOutlet weak var lbbiketype: UILabel!
    
    @IBOutlet weak var lbpriceperhour: UILabel!
    
  
    //actions
    
    @IBAction func btnDelete(_ sender: Any) {
        
        
        guard let url = URL(string: BR+"/locations/delete") else {
        return
        }
        
        let bodyparameters = ["location_id": self.id! ]
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyparameters, options: []) else {
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
                    DispatchQueue.main.async {
                    print(data)
                   
                            let alert = UIAlertController(title: "Success", message: "Rent Deleted Successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                    }
                }
                
            }
            
        }.resume()
        
    }
    
 
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lbdatelocation.text = datelocation!
        lbadresse.text = adresse
        lbhours.text = hours!
        lbtotalprice.text = totalprice!
        lbbikemodel.text = bikemodel!
        lbbiketype.text = biketype!
        lbpriceperhour.text = priceperhour!
        
    }
    

 
    
    
    

}
