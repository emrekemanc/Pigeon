//
//  ChatMessageCell.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import UIKit

class ChatMessageCell: UITableViewCell{
    
    @IBOutlet weak var user2ImageView: UILabel!
    @IBOutlet weak var user1ImageView: UILabel!
    @IBOutlet weak var user2MessageView: UILabel!
    @IBOutlet weak var user1MessageView: UILabel!
    
    func cellConfigure(message: Message, selfId: String){
        if selfId == message.sender_id{
            user2ImageView.isHidden = true
            user2MessageView.isHidden = true
            user1MessageView.text = message.text
        }else {
            user1ImageView.isHidden = true
            user1MessageView.isHidden = true
            user2MessageView.text = message.text
        }
        
    }
}
