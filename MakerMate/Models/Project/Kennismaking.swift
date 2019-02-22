//
//  Aanvraag.swift
//  MakerMate
//
//  Created by Jens Van Steen on 09/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import Foundation
import Firebase


class Kennismaking {
    
    private(set) var mobiliteitsklasse: Int!
    
    
    private init(mobiliteitsklasse: Int) {
        self.mobiliteitsklasse = mobiliteitsklasse
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> Kennismaking {
        var kennismaking: Kennismaking?
        
        guard let snap = snapshot else {return kennismaking!}
        for document in snap.documents {
            let data = document.data()
            let id = document.documentID
            print(data)
            let mobiliteitsklasse = data["mobiliteitsKlasse"] as! Int
            let deKennismaking = Kennismaking(mobiliteitsklasse: mobiliteitsklasse)
            kennismaking  = deKennismaking
        }
        
        return kennismaking!
    }
}
