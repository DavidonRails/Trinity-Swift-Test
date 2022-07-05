//
//  ContactDetailViewController.swift
//  Trinity
//
//  Created by Admin on 2022/7/5.
//

import UIKit

protocol ContactActionDelegate {
    func savedContact(contact: ContactModel, isNew: Bool)
}

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var fNameCon: UIView!
    @IBOutlet weak var txtFname: UITextField!
    
    @IBOutlet weak var lNameCon: UIView!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var emailCon: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var phoneCon: UIView!
    @IBOutlet weak var txtPhone: UITextField!
    
    var delegate: ContactActionDelegate?
    
    
    var contact: ContactModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        
        fNameCon.layer.borderColor = UIColor.lightGray.cgColor
        lNameCon.layer.borderColor = UIColor.lightGray.cgColor
        emailCon.layer.borderColor = UIColor.lightGray.cgColor
        phoneCon.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFname.delegate = self
        txtLastName.delegate = self
        txtPhone.delegate = self
        txtEmail.delegate = self
        
        txtFname.text = contact.firstName
        txtLastName.text = contact.lastName
        txtEmail.text = contact.email
        txtPhone.text = contact.phone
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSave(_ sender: Any) {
        
        let fname = txtFname.text ?? ""
        let lname = txtLastName.text ?? ""
        let email = txtEmail.text ?? ""
        let phone = txtPhone.text ?? ""
        
        if fname.count == 0 {
            showAlert(title: "Warning", msg: "Please enter first name.")
            return
        }
        
        if lname.count == 0 {
            showAlert(title: "Warning", msg: "Please enter last name.")
            return
        }
        
        if contact.id.count == 0 {
            let ct = ContactModel()
            ct.id = UUID().uuidString
            ct.firstName = fname
            ct.lastName = lname
            ct.email = email
            ct.phone = phone
            
            dismiss(animated: true, completion: {
                self.delegate?.savedContact(contact: ct, isNew: true)
            })
        } else {
            contact.firstName = fname
            contact.lastName = lname
            contact.email = email
            contact.phone = phone
            dismiss(animated: true, completion: {
                self.delegate?.savedContact(contact: self.contact, isNew: false)
            })
        }
    }
}

extension ContactDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 100 {
            txtLastName.becomeFirstResponder()
        } else if textField.tag == 200 {
            txtEmail.becomeFirstResponder()
        } else if textField.tag == 300 {
            txtPhone.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
