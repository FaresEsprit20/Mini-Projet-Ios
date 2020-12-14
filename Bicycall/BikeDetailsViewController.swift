//
//  BikeDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import UIKit
import CoreData

class BikeDetailsViewController: UIViewController {

    //vars
    var id: Int?
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
        let url = URL(string: "http://localhost:3000/"+image!)
    
        bikeimage.kf.setImage(with: url)
        
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
        if checkFavourite() == false {
            self.saveBike()
        }else {
            let alert = UIAlertController(title: "Failure", message: "Already in Favourites", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    
    func saveBike() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Favourites" ,  in: managedContext)
        let object = NSManagedObject(entity: entityDescription! , insertInto: managedContext )
        object.setValue(id!  ,  forKey: "id"  )
        object.setValue(model!  ,  forKey: "model"  )
        object.setValue(type!  ,  forKey: "type"  )
        object.setValue(mprice!  ,  forKey: "price"  )
        object.setValue(image!  ,  forKey: "image"  )
        
                  do {
                  
                 try managedContext.save()
                   print("INSERT SUCCESSFULLY")
                    let alert = UIAlertController(title: "Success", message: "Added to Favourites", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                print(id!)
                   }
                   catch  {
                   print("INSERT ERROR")
                   }
        
    }
    
    
    //check if a movie exists in favourite before inserting it to favourites
        func checkFavourite() -> Bool {
        
        var movieExist = false
        
        //premiere etape : appeler appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        //represente l'ORM
        let persistentContainer = appDelegate.persistentContainer
        
        let managedContext = persistentContainer.viewContext     //retourne NSManagedObject toujours
        
        //la requete retourne un NSManagedObject
        let request = NSFetchRequest<NSManagedObject>(entityName :   "Favourites")
        //where dans ios est predicate
            let predicate = NSPredicate(format: "id = %d"  , id! )
        request.predicate = predicate
        
        do {
         let result = try  managedContext.fetch(request)
        
        if  result.count > 0  {
        movieExist = true
        }
        
         }
           catch {
           print("NO DATA FOUND , Error")
           }
              return movieExist
        }
    
    

}
