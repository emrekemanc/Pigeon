//
//  ChatAddViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

import UIKit

class ChatAddViewController: UITableViewController{
    @IBOutlet weak var searchBar: UISearchBar!
    private var users: [UserCredentials] = []
    private let viewModel: ChatAddViewModel = ChatAddViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        chatAddConfiguration()
    }
    func chatAddConfiguration(){
        viewModel.onSuccess = {result in
            self.users = result
            self.tableView.reloadData()
            print("suusss")
        
        }
        viewModel.onError = {error in
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAddCell", for: indexPath) as? ChatAddCell else { return UITableViewCell()}
        let user = users[indexPath.row]
        cell.cellConfigure(user: user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
}
extension ChatAddViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text, search.isNotEmpty else{return}
        viewModel.searchUser(mail: search)
    }
}
