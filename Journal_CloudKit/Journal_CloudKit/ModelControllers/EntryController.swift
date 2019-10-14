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
    let privateCloudKitDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Create

    //Save------
    func saveEntry(title:String, bodyText: String, completion: @escaping (_ success: Bool) -> Void) {
        
        //Nested
        let newEntry = Entry(title: title, bodyText: bodyText)
        let entryRecord = CKRecord(entry: newEntry)
        
        privateCloudKitDatabase.save(entryRecord) { (record, error) in
            //Handle the error
            if let error = error {
                print("There was an error saving the entry \(error)")
                completion(false)
                return
            }
            
            guard let record = record,
                let savedEntry = Entry(ckRecord: record) else {completion(false); return}
            
            self.entries.append(savedEntry)
            print("Save of entry was successful")
            completion(true)
        }
    }
    
    //Update------
    func updateEntry(entry: Entry, title: String, bodyText: String, completion: @escaping (_ success: Bool) -> Void) {
        entry.title = title
        entry.bodyText = bodyText
        
        //Input mikes code
    }
    
    //Fetch------
    func fetchEntry(completion: @escaping (_ success: Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let entryQuery = CKQuery(recordType: EntryCodingKeys.kEntryType, predicate: predicate)
        
        privateCloudKitDatabase.perform(entryQuery, inZoneWith: nil) { (foundRecord, error) in
            
            //handle the error
            if let error = error {
                print("There was an error performing the fetch for Entry \(error)")
                completion(false)
                return
            }
            
            guard let record = foundRecord else {completion(false); return}
            let entry = record.compactMap( {Entry(ckRecord: $0)})
            
            self.entries = entry
            print("Fetch entry success")
            completion(true)
        }
    }
}
