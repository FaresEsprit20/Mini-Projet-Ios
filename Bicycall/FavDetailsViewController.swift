//
//  FavDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 14/12/2020.
//

import UIKit
import CoreData

class FavDetailsViewController: UIViewController {

    //vars
    var id: Int?
    var model: String?
    var type: String?
    var mprice: String?
    var image: String?
    var BR = BaseUrl.baseUrl
    
    
    //widgets
    
    
    @IBOutlet weak var favImg: UIImageView!
    
    @IBOutlet weak var txtModel: UILabel!
    
    @IBOutlet weak var txtType: UILabel!
    
    @IBOutlet weak var txtPrice: UILabel!
    
    
    //actions
    
    @IBAction func btnDeleteFav(_ sender: Any) {
        self.deleteItem(index: id!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtModel.text = model!
        txtType.text = type!
        txtPrice.text = mprice!
        let url = URL(string: BR+"/"+image!)
    
        favImg.kf.setImage(with: url)
        
    }
    

    
    
    
    func deleteItem(index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        //la requete retourne un NSManagedObject
        let request = NSFetchRequest<NSManagedObject>(entityName :   "Favourites")
        let predicate = NSPredicate(format: "id = %d"  , id! )
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
