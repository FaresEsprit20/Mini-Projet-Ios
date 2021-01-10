//
//  AddNewTravelViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 9/1/2021.
//

import UIKit
import DatePicker


class AddNewTravelViewController: UIViewController {

    //MARK: - UI Elements
  
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var DateTextField: UITextField!

    @IBOutlet weak var saveBtn: UIButton!
    let helper = HelperClass()
    var coverImage = UIImage()
    
    @IBOutlet weak var selectDateBtn: UIButton!

    //MARK: - View Setup Functions
    override func viewDidLoad() {
      
        super.viewDidLoad()
    }
    
  
    

  
    
    
 
    
    @IBAction func selectDateBtnAction(_ sender: Any) {
        let datePicker = DatePicker()
        datePicker.setup { (selected, date) in
            if selected, let selectedDate = date {
                self.selectDateBtn.setTitle(self.getSelectedDate(date: selectedDate as NSDate), for: UIControl.State.normal)
            } else {
                print("cancelled")
            }
        }
        datePicker.display(in: self)
    }
    
   
    
 
    
 
    
    //MARK: - API Requests
  
}



extension AddNewTravelViewController :UITextFieldDelegate{

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func getSelectedDate(date : NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date as Date)
        let selectedDate = formatter.date(from: dateString)
        formatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = formatter.string(from: selectedDate!)
        print(formattedDate)
        return formattedDate
    }
    
}
