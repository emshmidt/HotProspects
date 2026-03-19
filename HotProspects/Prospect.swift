//
//  Prospect.swift
//  HotProspects
//
//  Created by Эмилия Шмидт on 24.09.2024.
//

import SwiftData
import SwiftUI

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded = Date.now
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
