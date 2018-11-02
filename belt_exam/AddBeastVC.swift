//
//  AddBeastVC.swift
//  belt_exam
//
//  Created by Kim Vy Vo on 9/21/18.
//  Copyright © 2018 Kim Vy Vo. All rights reserved.
//

import UIKit

class AddBeastVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
