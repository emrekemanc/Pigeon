//
//  ChatMessage.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import UIKit

class ChatMessageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageInput: CustomTextView!
    var receiverID: String?
    var chat: ChatCredentials?
    var currentUserID: String?
    private var messages: [MessageCredentials] = []

    private lazy var viewModel = ChatMessageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        guard let receiverID = receiverID else {
            print("Receiver ID is nil. Cannot proceed.")
            return
        }
        viewModel.fetchCurentUserId()
        viewModel.receiverUser(receiver_id: receiverID)
        if let chat = chat {
            viewModel.fetchAllMessages(chat: chat)
            viewModel.observeMessage(chat: chat)
        }
    }

    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
    }

    private func bindViewModel() {
        viewModel.receiverFetched = { [weak self] user in
            DispatchQueue.main.async {
                self?.title = user.fullname
            }
        }
        viewModel.fetchUserId = {[weak self] uid in
            DispatchQueue.main.async{
                self?.currentUserID = uid
            }
        }

        viewModel.fetchedChat = { [weak self] messages in
            DispatchQueue.main.async {
                self?.messages = messages.sorted(by: { $0.created_at < $1.created_at })
                self?.tableView.reloadData()
                self?.scrollToBottom()
            }
        }

        viewModel.onNewMessageUpdate = { [weak self] message in
            DispatchQueue.main.async {
                self?.messages.append(message)
                self?.tableView.insertRows(at: [IndexPath(row: (self?.messages.count ?? 1) - 1, section: 0)], with: .bottom)
                self?.scrollToBottom()
            }
        }

        viewModel.onShowError = { error in
            print("Error received from ViewModel: \(error.localizedDescription)")
        }

        viewModel.onNewChat = { [weak self] newChat in
            self?.chat = newChat
            self?.viewModel.observeMessage(chat: newChat)
        }
        
    }

    private func scrollToBottom() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    @IBAction func sendMessageTapped(_ sender: CustomButton) {
        guard let text = messageInput.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Message input is empty.")
            return
        }
        guard let receiverID = receiverID else {
            print("Receiver ID is nil when trying to send a message.")
            return
        }
        guard let currentUserID = currentUserID else {
            print("Current user ID is nil when trying to send a message.")
            return
        }
        let message = MessageCredentials(
            id: UUID().uuidString,
            chat_id: chat?.id ?? "",
            sender_id: currentUserID,
            receiver_id: receiverID,
            text: text,
            created_at: Date(),
            is_read: false
        )

        viewModel.sendMessages(message: message, chat: chat)
        messageInput.text = ""
    }
}

extension ChatMessageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        guard let currentUserID = currentUserID else {
            print("Current user ID is nil during cell configuration.")
            return cell
        }
        cell.cellConfigure(message: msg, selfId: currentUserID)
        return cell
    }
}
