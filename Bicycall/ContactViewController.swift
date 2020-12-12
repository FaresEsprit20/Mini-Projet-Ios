//
//  ContactViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/12/2020.
//

import MessageUI
import UIKit


class ContactViewController: UIViewController ,MFMailComposeViewControllerDelegate{

    
    //widgets
    
    @IBAction func btnCall(_ sender: Any) {
        
        let url:NSURL = URL(string: "TEL://0123456789")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    

    @IBAction func btnMessage(_ sender: Any) {
        
        if (MFMessageComposeViewController.canSendText()) {
        let controller = MFMessageComposeViewController()
        controller.body = ""
        controller.recipients = ["1234567890"] //Here goes whom you wants to send the message
        controller.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
        self.present(controller, animated: true, completion: nil)
        }
        //This is just for testing purpose as when you run in the simulator, you cannot send the message.
        else{
        print("Cannot send the message")
        }
        func messageComposeViewController(controller:
        MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //Displaying the message screen with animation.
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnMail(_ sender: Any) {
       
        // Modify following variables with your text / recipient
                    let recipientEmail = "faresbenslama95@gmail.com"
                    let subject = "Multi client email support"
                    let body = "This code supports sending email via multiple different email apps on iOS! :)"
                    
                    // Show default mail composer
                    if MFMailComposeViewController.canSendMail() {
                        let mail = MFMailComposeViewController()
                        mail.mailComposeDelegate = self
                        mail.setToRecipients([recipientEmail])
                        mail.setSubject(subject)
                        mail.setMessageBody(body, isHTML: false)
                        
                        present(mail, animated: true)
                    
                    // Show third party email composer if default Mail app is not present
                    } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                        UIApplication.shared.open(emailUrl)
                    }
                }
                
                private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
                    let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    
                    let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
                    let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
                    let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
                    let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
                    let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
                    
                    if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
                        return gmailUrl
                    } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
                        return outlookUrl
                    } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
                        return yahooMail
                    } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
                        return sparkUrl
                    }
                    
                    return defaultUrl
        
        
        }
        
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                controller.dismiss(animated: true)
            }
        
    
    
          
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

  

}
