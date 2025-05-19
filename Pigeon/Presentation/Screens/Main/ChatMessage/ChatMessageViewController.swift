//
//  ChatMessage.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import UIKit
class ChatMessageViewController: UIViewController{
    @IBOutlet weak var risiverName: UILabel!
    @IBOutlet weak var messageListView: UITableView!
    @IBOutlet weak var inputMessageView: CustomTextView!
    @IBOutlet weak var sendButton: CustomButton!
    private var messageList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        messageListView.delegate = self
        messageListView.dataSource = self
    }
    @IBAction func sendButtonPress(_ sender: CustomButton) {
    }
}
extension ChatMessageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        cell.cellConfigure(message: messageList[indexPath.row], selfId: <#T##String#>)
    }
    
    
}
