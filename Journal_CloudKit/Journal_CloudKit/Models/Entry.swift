//
//  Entry.swift
//  Journal_CloudKit
//
//  Created by AlphaDVLPR on 10/14/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import Foundation
import CloudKit

//Keys
struct EntryCodingKeys {
    static let kEntryType = "Entry"
    fileprivate static let kTitle = "title"
    fileprivate static let kBodyText = "bodyText"
    fileprivate static let kTimestamp = "timestamp"
}

//Entry Class
class Entry {
    
    var title: String
    var bodyText: String
    var timestamp: Date
    
    init(title: String, bodyText: String, timestamp: Date = Date()) {
        
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
    }
}

//This is to create CKRecords
extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryCodingKeys.kEntryType)
        self.setValuesForKeys([
            EntryCodingKeys.kTitle : entry.title,
            EntryCodingKeys.kBodyText : entry.bodyText,
            EntryCodingKeys.kTimestamp : entry.timestamp
        ])
    }
}

//This extension is to turn a CKRecord back into a model object
extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryCodingKeys.kTitle] as? String else {return nil}
        guard let bodyText = ckRecord[EntryCodingKeys.kBodyText] as? String else {return nil}
        guard let timestamp = ckRecord[EntryCodingKeys.kTimestamp] as? Date else {return nil}
        
        self.init(title: title, bodyText: bodyText, timestamp: timestamp)
    }
}
