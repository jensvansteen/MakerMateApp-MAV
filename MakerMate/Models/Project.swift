//
//  Project.swift
//  MakerMate
//
//  Created by Jens Van Steen on 03/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation


struct Project {
    
    var name: String?
    var firstName: String?
    var email: String?
    var phoneNumber: Int?
    var adress: String?
    var city: String?
    var province: String?
    var zip: Int?
    var wish: String?
    var description: String?
    var targetGroup: String?
    
    init(name: String, firstName: String, email: String, phoneNumber: Int, adress: String, city: String, province: String, zip: Int, wish: String, description: String, targetGroup: String) {
        self.name = name
        self.firstName = firstName
        self.email = email
        self.phoneNumber = phoneNumber
        self.adress = adress
        self.city = city
        self.province = province
        self.zip = zip
        self.wish = wish
        self.description = description
        self.targetGroup = targetGroup
    }
}
