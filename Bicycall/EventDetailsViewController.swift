//
//  EventDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/1/2021.
//

import UIKit

class EventDetailsViewController: UIViewController {

//vars
    
    var event_id: Int?
    var event_title: String?
    var adresse_evt: String?
    var date_evt: String?
    var time_evt: String?
    var user: Int?
    var BR = BaseUrl.baseUrl

    //widgets
    
    @IBOutlet weak var txtTitle: UILabel!
    
    @IBOutlet weak var txtAdress: UILabel!
    
    @IBOutlet weak var txtDate: UILabel!
    
    @IBOutlet weak var txtTime: UILabel!
    
    //Actions
    
    @IBOutlet weak var btnParticipate: UIButton!
    
    
    @IBOutlet weak var btnParticipants: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    

}
