//
//  ViewController.swift
//  Tut_phoneNumber
//
//  Created by ruroot on 9/12/18.
//  Copyright © 2018 Eray Alparslan. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactViewControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let name  = nameLabel.text!
        let phone = phoneLabel.text!
        let mail  = mailLabel.text!
        
        saveContact(contactName: name, contactPhone: phone, contactMail: mail)
    }
    
    func saveContact(contactName name: String, contactPhone phone: String, contactMail mail: String) {
        
        //CNMutableContact instance i yarat
        let newContact = CNMutableContact()
        
        //E-posta adresini belirtelim
        let homeEmail = CNLabeledValue(label:"E-mail:", value: "\(mail)" as NSString)
        
        //E-posta adresini contact bilgisine kayıt edelim.
        //İstersek başka e-mail adresleri de ekleyelim ',' ile ayırabiliriz
        newContact.emailAddresses = [homeEmail]
        newContact.phoneNumbers = [CNLabeledValue(
            label: "Phone Number:",
            value:CNPhoneNumber(stringValue:"\(phone.digits)"))]
        
        //Kişinin profil resmini belirlemek isterseniz aşağıdaki kodu kullanabilirsiniz
        //newContact.imageData = UIImagePNGRepresentation(UIImage(named: "pictureName")!)
        
        //İsim bilgisini kaydedelim
        newContact.givenName = name
        newContact.familyName = "iOS Notları"
        
        //Present etmek üzere ContactViewController oluşturalım ve bilgileri bunun içine gönderelim
        let contactVC = CNContactViewController(forUnknownContact: newContact)
        contactVC.contactStore = CNContactStore()
        
        contactVC.delegate = self
        contactVC.allowsActions = false
        
        //Present edelim ve uygulamadan cihaza geçiş yapalım
        let navigationController = UINavigationController(rootViewController: contactVC)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    //Kaydettikten sonra uygulamaya geri dön
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

