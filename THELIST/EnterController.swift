//
//  StartupController.swift
//  THELIST
//
//  Created by Nicolas Sedano on 3/7/23.
// Credit: IOS Academy

import UIKit

class EnterController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var f: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        f.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveList))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveList()
        return true
    }
    
    @objc func saveList() {
        guard let text = f.text, !text.isEmpty else {
            return 
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        let count2 = count + 1
        UserDefaults().set(count2, forKey: "count" )
        UserDefaults().set(count2, forKey: "list_\(count2)")
        
        update?()
        navigationController?.popViewController(animated: true)
    }
}
