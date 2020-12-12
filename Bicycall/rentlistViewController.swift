//
//  rentlistViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 2/12/2020.
//

import UIKit

class rentlistViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    var data = ["1","23"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRent")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        label.text = data[indexPath.row]
        return cell!
    }
  
    
    //passage de parametres entre les controleurs
 
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rent = data[indexPath.row]
            performSegue(withIdentifier: "mRentDetails" , sender: rent) //passage de variable locale)
            
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "mRentDetails" {
        
        let rent = sender as! String
        let destination = segue.destination as! RentDetailsViewController
        destination.datelocation = rent
        destination.hours = rent
        destination.totalprice = rent
        destination.bikemodel = rent
        destination.biketype = rent
        destination.priceperhour = rent
        
        }}
    
    
    

}
