//
//  ChatListViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//
import UIKit
class ChatListViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: ChatListViewModel = ChatListViewModel()
    private var chatIds: [String] = []
    private var receivers: [UserCredentials] = []
    private var currentUserId: String?
    var userSelected: ((ChatCredentials?,String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        configure()
        viewModel.startFetch()
    }
    func configure(){
        viewModel.onFetchSuccess = {[weak self] chatList in
            DispatchQueue.main.async {
                self?.chatIds = chatList
                guard let uid = self?.currentUserId else{ return}
                for chat in chatList{
                    self?.viewModel.fetchChatContent(chat_id: chat, current_uid: uid )
                }
            }
            
        }
        viewModel.onError = { error in
            DispatchQueue.main.async {
               print(error)
            }
        }
        viewModel.onFetchChat = {[weak self] chat in
            DispatchQueue.main.async {
                guard let uid = self?.currentUserId else{ return}
                self?.userSelected?(chat, uid)
            }
        }
        viewModel.onCurrentUserId = {[weak self] uid in
            DispatchQueue.main.async {
                self?.currentUserId = uid
            }
        }
        viewModel.onFetchUserContent = {[weak self] receiver in
            DispatchQueue.main.async {
                self?.receivers.append(receiver)
                self?.tableView.reloadData()
            }
        }
    }
}


extension ChatListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as? ChatListCell else {print("cell")
            return UITableViewCell()
        }
        
        let user = receivers[indexPath.row]
        print(user.email)
        cell.usernameLabel.text = user.fullname
        if let first = user.fullname.first {
            cell.initialsLabel.text = String(first).uppercased()
        } else {
            cell.initialsLabel.text = "?"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.chatFetch(chat_id: chatIds[indexPath.row])
    }
    
    
}
