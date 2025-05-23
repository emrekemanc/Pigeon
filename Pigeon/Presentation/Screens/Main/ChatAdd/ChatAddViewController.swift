//
//  ChatAddViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

import UIKit

class ChatAddViewController: UIViewController{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var users: [UserCredentials] = []
    private let viewModel: ChatAddViewModel = ChatAddViewModel()
    var userSelected: ((ChatCredentials?,String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        chatAddConfiguration()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func chatAddConfiguration(){
        viewModel.onSuccess = {result in
            self.users = result
            print(result)
            self.tableView.reloadData()
            print("success")
        }
        viewModel.onError = {error in
            print(error.localizedDescription)
        }
        viewModel.chatCheck = {chat, userId in
            self.userSelected?(chat, userId)
            print(chat ?? "boş")
        }
    }
    
   
    
}
extension ChatAddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAddCell", for: indexPath) as? ChatAddCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.usernameLabel.text = user.fullname
        if let first = user.fullname.first {
            cell.initialsLabel.text = String(first).uppercased()
        } else {
            cell.initialsLabel.text = "?"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user2ID = users[indexPath.row].id else {
            print("user2id alınamadı")
            return
        }
        viewModel.checkChat(user2Id: user2ID)
    }
}
extension ChatAddViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text, search.isNotEmpty else{print("searchbar boş");return}
        viewModel.searchUser(mail: search.lowercased())
    }
}
