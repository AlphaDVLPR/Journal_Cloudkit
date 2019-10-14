//
//  EntryController.swift
//  Journal_CloudKit
//
//  Created by AlphaDVLPR on 10/14/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //Global Variables
    static let shared = EntryController()
    var entries: [Entry] = []
    let publicCloudkitDatabase = CKContainer.default().publicCloudDatabase
    
    //CRUD
    
}
