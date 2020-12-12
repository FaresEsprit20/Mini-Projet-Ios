//
//  BikelistViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 2/12/2020.
//

import UIKit
import Alamofire


class BikelistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var data = ["1","23"]
    var users: [User] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCellBike")
        let contentView = cell?.contentView
        let imageView = contentView?.viewWithTag(1) as! UIImageView
        let label = contentView?.viewWithTag(2) as! UILabel
        label.text = data[indexPath.row]
        imageView.image = UIImage (named: data[indexPath.row])
        return cell!
    }
   
    

    //passage de parametres entre les controleurs
        //cell OnclickListener
        
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let bike = data[indexPath.row]
            performSegue(withIdentifier: "mBikeDetails" , sender: bike) //passage de variable locale)
            
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "mBikeDetails" {
        
        let bike = sender as! String
        let destination = segue.destination as! BikeDetailsViewController
        destination.model = bike
        destination.type = bike
        destination.mprice = bike
        destination.image = bike
        
        }}
    
    /*func getData () {
        AF.request("http://192.168.10.1:3000/users",method: .get, encoding: JSONEncoding.default).responseString{ response in ->
            swich(response.re){
                case errSecSuccess(responseString):
                print
                case .assertionFailure(responseString):
            }
        }
    }*/



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
