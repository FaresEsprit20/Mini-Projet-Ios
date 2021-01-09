//
//  MailViewController.swift
//  Bicycall
//
//  Created by Jamil Joo on 8/1/2021.
//

import UIKit
import MessageUI

class MailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    

    
    
    @IBAction func emailButtonTapped(_ sender: SAButton) {
        
        showMailComposer()
    }
    
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //Show alert informing the user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["Joo.jamil1@esprit.tn"])
        composer.setSubject("HELP!")
        composer.setMessageBody("I love your app, but... help!", isHTML: false)
        
        present(composer, animated: true)
    }
}


extension ViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        @unknown default:
            break
        }
        
        controller.dismiss(animated: true)
    }



}
