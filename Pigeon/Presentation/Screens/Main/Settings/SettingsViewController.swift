//
//  SettingsViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import UIKit

class SettingsViewController: UIViewController{
    private let viewModel: SettingsViewModel = SettingsViewModel()
    var onSignOut: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsConfiguration()
    }
    func settingsConfiguration(){
        viewModel.onSuccess = { success in
            print("çıkıldı")
            self.onSignOut?()
        }
        viewModel.onError = { error in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func signOutPress(_ sender: UIButton) {
        viewModel.signOut()
    }
}
