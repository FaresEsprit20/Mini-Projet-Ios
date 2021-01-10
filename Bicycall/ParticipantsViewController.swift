//
//  ParticipantsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/1/2021.
//

import UIKit

class ParticipantsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    //vars
    var event_id:Int?
    var BR = BaseUrl.baseUrl
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var participants =  [Participant]()
    
    
    //widgets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("segue event id"+String(event_id!))
        
        
        //post
    
        guard let url = URL(string: BR+"/participants/alls") else {
        return
        }
        
        let bodyparameters = [ "event_id": event_id!  ] as [String : Any]
        
       print(bodyparameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyparameters, options: []) else{
            print("error in sending data")
            return
            }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] (data,response,error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
   
                print(data)
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])as! [[String:Any]]
                 self?.participants.removeAll()
                 print(json)
                 for item in json {
                     let pid = item["pevent_id"] as! Int
                     let puserid = item["puser_id"] as! Int
                     let user = item["user_id"] as! Int
                     let email = item["email"] as! String
                     let name = item["name"] as! String
                     let lastname = item["lastname"] as! String
                     let password = item["password"] as! String
                     let phone  = item["phone"] as! String
                    
                    self?.participants.append(Participant(puser_id: puserid, pevent_id: pid, userid: user, email: email, password: password, name: name, lastname: lastname, phone: phone))
                 }
                 
                 DispatchQueue.main.async {
                    self!.tableView.reloadData()
                 }
                 
                }catch{
                    print(error)
                }
                
            }
            
        }.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mPart")
        let contentView = cell?.contentView
        let labelEmail = contentView?.viewWithTag(1) as! UILabel
        let labelName = contentView?.viewWithTag(2) as! UILabel
        let labelLastName = contentView?.viewWithTag(3) as! UILabel
        let image = contentView?.viewWithTag(4) as! UIImageView
        
        DispatchQueue.main.async {
            labelEmail.text = self.participants[indexPath.row].email
            labelName.text = self.participants[indexPath.row].name
            labelLastName.text = self.participants[indexPath.row].lastname
            image.image = UIImage(named: "event-1")
        }
        return cell!
    }
    
    
    
    
    
    
    
    
    

}
