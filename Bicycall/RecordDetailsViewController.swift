//
//  RecordDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import UIKit

class RecordDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        lbAddress.text = address!
        lbTime.text = time!
        lbDistance.text = distance!
        lbDate.text = date_record!
        
    }
    
//vars
    var record_id: Int?
    var distance: String?
    var time: String?
    var address: String?
    var date_record: String?
    var user_id:String?
    var BR = BaseUrl.baseUrl
    
//widgets
    
    @IBOutlet weak var lbAddress: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var lbDistance: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    
 //Actions
    
    @IBAction func btnDelete(_ sender: Any) {
        
        guard let url = URL(string: BR+"/records/delete") else {
        return
        }
        
        let bodyparameters = ["record_id": self.record_id! ]
       
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
                   
                            let alert = UIAlertController(title: "Success", message: "Record Deleted Successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            
                    }
                }
                
            }
            
        }.resume()
    }
    

}
