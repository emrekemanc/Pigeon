//
//  ChatAddcCell.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

import UIKit

class ChatAddCell: UITableViewCell{
    @IBOutlet weak var userImageLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    
    
    func cellConfigure(user: UserCredentials){
        let fullname = user.fullname
        if let firstLetter = fullname.first {
            userImageLabel.text = String(firstLetter).uppercased()
        } else {
            userImageLabel.text = "?"
        }
        userMailLabel.text = user.mail
    }
}
