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
    var chat: ChatCredentials?
    var reciverId: String?
    private var messageList: [String] = []
    private var senderId: String?
    private var viewModel: ChatMessageViewModel = ChatMessageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChatMessageViewModel()
        messageListView.delegate = self
        messageListView.dataSource = self
        configure()
    }

    func configure(){
        viewModel.onMessageUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.messageListView.reloadData()
                self?.scrollToBottom()
            }
        }

        viewModel.onShowError = { error in
            print("Hata: \(error.localizedDescription)")
        }

        viewModel.fetchUserId = { [weak self] result in
            self?.senderId = result
        }

        if let chat = chat {
            viewModel.startObservingMessages(chat: chat)
        }
        viewModel.onNewChat = { [weak self] newChat in
            self?.chat = newChat
            self?.viewModel.startObservingMessages(chat: newChat)
        }
        viewModel.fetchUserSelfId()
    }

    @IBAction func sendButtonPress(_ sender: CustomButton) {
        guard let text = inputMessageView.text, !text.isEmpty else { return }
        guard let receiverID = reciverId else { return }
        viewModel.sendMessage(text: text, to: receiverID, chat: chat)
        inputMessageView.text = ""
    }
    
    
    private func scrollToBottom() {
        guard viewModel.messages.count > 0 else { return }
        let indexPath = IndexPath(row: viewModel.messages.count - 1, section: 0)
        messageListView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}


extension ChatMessageViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        let message = viewModel.messages[indexPath.row]
        guard let uid = senderId else {return cell}
        cell.cellConfigure(message: message, selfId: uid)
        return cell
    }
    
    
}
