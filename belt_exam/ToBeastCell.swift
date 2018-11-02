//
//  ToBeastCell.swift
//  belt_exam
//
//  Created by Kim Vy Vo on 9/21/18.
//  Copyright © 2018 Kim Vy Vo. All rights reserved.
//

import UIKit

class ToBeastCell: UITableViewCell {
    
    var delegate: BeastedDelegate?
    var indexPath: IndexPath?
    var date: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        
        let unformattedDate = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEE MMM dd"
        if let formattedDate = dateFormatterGet.date(from: "\(unformattedDate)"){
            date = dateFormatterPrint.string(from: formattedDate)
        } else {
            date = "N/A"
            print("error with date")
        }
        
        delegate?.beastThatCell(by: self, with: date!, at: indexPath!)
    }
    
}

protocol BeastedDelegate {
    func beastThatCell(by controller: ToBeastCell, with date: String, at indexPath: IndexPath)
}
