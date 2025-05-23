//
//  SettingsViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import UIKit

class SettingsViewController: UIViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    private let viewModel: SettingsViewModel = SettingsViewModel()
    var onSignOut: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsConfiguration()
        viewModel.fetchUser()
        
    }
    func settingsConfiguration(){
        viewModel.onSuccess = {[weak self] success in
            print("çıkıldı")
            self?.onSignOut?()
        }
        viewModel.onError = { error in
            print(error.localizedDescription)
        }
        viewModel.onfetchUser = {[weak self] user in
            self?.nameLabel.text = "Full Name: \(user.fullname)"
            self?.mailLabel.text = "Mail: \(user.email)"
            self?.createdLabel.text = "Created at: \(self?.formatTimestamp(user.created_at) ?? "00/00/0000")"
            
        }
        
    }
    private func formatTimestamp(_ timestamp: Date?) -> String {
        guard let timestamp = timestamp else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter.string(from: timestamp)
    }
    @IBAction func signOutPress(_ sender: UIButton) {
        viewModel.signOut()
    }
}
