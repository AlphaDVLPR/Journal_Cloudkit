//
//  DetailEntryViewController.swift
//  Journal_CloudKit
//
//  Created by AlphaDVLPR on 10/14/19.
//  Copyright © 2019 JesseRae. All rights reserved.
//

import UIKit

class DetailEntryViewController: UIViewController {
    
    //MARK: - Global Variables
    var incomingEntryData: Entry?
    
    //MARK: - Outlets
    @IBOutlet weak var entryTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    //MARK: - Private Functions
    private func updateViews() {
        guard let entry = incomingEntryData else {return}
        DispatchQueue.main.async {
            self.entryTextField.text = entry.title
            self.bodyTextField.text = entry.bodyText
        }
    }
    
    //MARK: - Actions
    @IBAction func clearButtonTapped(_ sender: Any) {
        entryTextField.text = ""
        bodyTextField.text = ""
    }
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        guard let title = entryTextField.text, let bodyText = bodyTextField.text else {return}
            EntryController.shared.saveEntry(title: title, bodyText: bodyText) { (success) in
                if success {
            }
                
                DispatchQueue.main.async {
                    let _ = self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
