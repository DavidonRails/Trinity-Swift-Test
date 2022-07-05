//
//  ContactModel.swift
//  Trinity
//
//  Created by Admin on 2022/7/5.
//

import Foundation

class ContactModel: NSObject {
    
    var id = ""
    var firstName = ""
    var lastName = ""
    var email = ""
    var phone = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                 { id = val }
        if let val = dict["firstName"] as? String          { firstName = val }
        if let val = dict["lastName"] as? String           { lastName = val }
        if let val = dict["email"] as? String              { email = val }
        if let val = dict["phone"] as? String              { phone = val }
    }
}
