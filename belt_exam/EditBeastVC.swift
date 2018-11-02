//
//  EditBeastVC.swift
//  belt_exam
//
//  Created by Kim Vy Vo on 9/21/18.
//  Copyright © 2018 Kim Vy Vo. All rights reserved.
//

import UIKit

class EditBeastVC: UIViewController {

    var delegate: EditBeastDelegate?
    var name: String = ""
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.editBeast(by: self, with: nameTextField.text!, for: indexPath! as IndexPath)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

protocol EditBeastDelegate {
    func editBeast(by controller: EditBeastVC, with name: String, for indexPath: IndexPath)
}
