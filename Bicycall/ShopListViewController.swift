//
//  ShopListViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 28/12/2020.
//

import UIKit

class ShopListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: BR+"/shops") else {
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
                 self!.shops.removeAll()
                 
                 for item in json {
                     let id = item["shop_id"] as! Int
                     let title = item["title"] as! String
                     let latitude = item["latitude"] as! Double
                     let longitude = item["longitude"] as! Double
                     
                    self!.shops.append(Shop(id: id, title: title, latitude: latitude, longitude: longitude))
                 }
              
                 DispatchQueue.main.async { [weak self] in
                     self?.tableView.reloadData()
                 }
                }catch{
                    print(error)
                }
             
            }
            
        }.resume()
        
    }
//vars
    
    var shops =  [Shop]()
    var BR = BaseUrl.baseUrl
    
    
    //widgets
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mShopCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
     
        DispatchQueue.main.async {
            label.text = self.shops[indexPath.row].title
            print("heloooooo"+label.text!)
        }
            
        return cell!
    }
  
    
    //passage de parametres entre les controleurs
 
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rent = self.shops[indexPath.row]
            performSegue(withIdentifier: "mBikes" , sender: rent) //passage de variable locale)
            
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "mBikes" {
        
        let rent = sender as! Shop
        let destination = segue.destination as! BikelistViewController
            destination.idShop = rent.shop_id
        }}
    
    
    
}
