//
//  BikelistViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 12/12/2020.
//

import UIKit
import Kingfisher

class BikelistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
//widgets
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    var bikes =  [Bike]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCellBike")
        let contentView = cell?.contentView
        let imageView = contentView?.viewWithTag(1) as! UIImageView
        let label = contentView?.viewWithTag(2) as! UILabel
        DispatchQueue.main.async {
            
            label.text = self.bikes[indexPath.row].model
            let url = URL(string: "http://localhost:3000/"+self.bikes[indexPath.row].image)
            imageView.kf.setImage(with: url)
       
        }
       
        return cell!
    }
   
    

    //passage de parametres entre les controleurs
        //cell OnclickListener
        
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let bike = self.bikes[indexPath.row]
            performSegue(withIdentifier: "mBikeDetails" , sender: bike) //passage de variable locale)
            
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "mBikeDetails" {
        
        let bike = sender as! Bike
        let destination = segue.destination as! BikeDetailsViewController
            destination.id = bike.bike_id
            destination.model = bike.model
            destination.type = bike.type
            destination.mprice = bike.price
            destination.image = bike.image
            
        
        }}
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //get
      
       guard let url = URL(string: "http://localhost:3000/bikes") else {
       return
       }
       let session = URLSession.shared
       session.dataTask(with: url)  { [weak self] ( data , response ,error) in
           if let response = response {
               print(response)
           }
           
           if let data = data {
               print(data)
               do
               {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                self!.bikes.removeAll()
                
                for item in json {
                    let id = item["bike_id"] as! Int
                    let model = item["model"] as! String
                    let type = item["type"] as! String
                    let price = item["price"] as! String
                    let image = item["image"] as! String
                    self!.bikes.append(Bike(id: id,model: model,type: type,price: price,image: image))
                }
                for item in self!.bikes {
                    print(item.image)
                    print("http://localhost:3000/"+item.image)
                    
                }
                print(self!.bikes)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
               }catch{
                   print(error)
               }
            
           }
           
       }.resume()
       
        
        // Do any additional setup after loading the view.
    }
    


}
