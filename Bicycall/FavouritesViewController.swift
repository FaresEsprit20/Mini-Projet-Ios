//
//  FavouritesViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 14/12/2020.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //vars
    
    var favourites =  [Favourite]()
    var BR = BaseUrl.baseUrl
    
    //widgets
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.DisplayFavourites()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        let imageView = contentView?.viewWithTag(2) as! UIImageView
     
        DispatchQueue.main.async {
            label.text = self.favourites[indexPath.row].model
            let url = URL(string: self.BR+"/"+self.favourites[indexPath.row].image)
            imageView.kf.setImage(with: url)
        }
            
        return cell!
    }
  
    
    //passage de parametres entre les controleurs
 
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rent = self.favourites[indexPath.row]
            performSegue(withIdentifier: "mFavDetails" , sender: rent) //passage de variable locale)
            
        }
        
        /* prepare est pour passer les parametres  */
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "mFavDetails" {
        
            let fav = sender as! Favourite
            let destination = segue.destination as! FavDetailsViewController
                destination.id = fav.bike_id
                destination.model = fav.model
                destination.type = fav.type
                destination.mprice = fav.price
                destination.image = fav.image
        
        }}
    
    
    func DisplayFavourites() {
            
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //represente l'ORM
                let persistentContainer = appDelegate.persistentContainer
                
                let managedContext = persistentContainer.viewContext     //retourne NSManagedObject toujours
                
                //la requete retourne un NSManagedObject
                let request = NSFetchRequest<NSManagedObject>(entityName :   "Favourites")
                
                //execution de la requete
                do {
                
                    let result = try  managedContext.fetch(request)
                for item in result {
                   
                    self.favourites.append(Favourite(bike_id: (item.value(forKey: "id")  as! Int), model: (item.value(forKey: "model")  as! String) , type: (item.value(forKey: "type")  as! String), price: (item.value(forKey: "price")  as! String), image: (item.value(forKey: "image")  as! String)))
                }
                   }
                   catch {
                   print("NO DATA FOUND , Error")
                   }

        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("deleting ............")
            deleteItem(index: favourites[indexPath.row].bike_id)
            self.tableView.reloadData()
        }
    }

    func deleteItem(index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        //la requete retourne un NSManagedObject
        let request = NSFetchRequest<NSManagedObject>(entityName :   "Favourites")
        let predicate = NSPredicate(format: "id = %d"  , index )
        request.predicate = predicate
        
        do{
        let result = try managedContext.fetch(request)
        if result.count > 0 {
         let obj = result[0] // NSManagedObject
         managedContext.delete(obj)
         print("Deleted Successfully")
            let alert = UIAlertController(title: "Success", message: "Favourite Deleted Successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        }
        catch {
        print("fetching error")
        }
        
    }
    
    
    
    
}
