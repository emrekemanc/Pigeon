//
//  LoginViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import UIKit

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel = LoginViewModel()
    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginConfiguration()
        viewModel.login(with: AuthCredentials(email: "emrekemanci@gmail.com", password: "Emre.emre23"))
    }

    func loginConfiguration() {
        viewModel.onSuccess = { [weak self] success in
            print(success)
            self?.onLoginSuccess?()
        }

        viewModel.onError = { error in
            print(error.localizedDescription)
        }
    }
}
