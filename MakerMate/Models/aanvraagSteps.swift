//
//  aanvraagSteps.swift
//  MakerMate
//
//  Created by Jens Van Steen on 02/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation

class aanvraagSteps {
    
    private(set) static var sharedInstance = aanvraagSteps()
    
    private(set) var name: String?
    private(set) var firstName: String?
    private(set) var email: String?
    private(set) var phoneNumber: Int?
    private(set) var adress: String?
    private(set) var city: String?
    private(set) var province: String?
    private(set) var zip: Int?
    private(set) var wish: String?
    private(set) var description: String?
    private(set) var targetGroup: String?
    
    

    func setStep1(name: String, firstName: String, email: String, phoneNumber: Int) {
        self.name = name
        self.firstName = firstName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    
    func setStep2(adress: String, city: String, province: String, zip: Int) {
        self.adress = adress
        self.city = city
        self.province = province
        self.zip = zip
    }
    
    
    func setStep3(wish: String) {
        self.wish = wish
    }
    
    func setStep4(description: String) {
        self.description = description
    }
    
    func setStep5(targetGroup: String) {
        self.targetGroup = targetGroup
    }
    
    func pushToFirebase() {
        print("class with properties \(name!) \(firstName!) \(email!) \(phoneNumber!) \(adress!) \(city!) \(province!) \(zip!) \(wish!) \(description!) \(targetGroup!)")
        
        clearInstance()
    }
    
    private func clearInstance() {
        name = nil
        firstName = nil
        email = nil
        phoneNumber = nil
        adress = nil
        city = nil
        province = nil
        zip = nil
        wish = nil
        description = nil
        targetGroup = nil
    }
    
    
}



