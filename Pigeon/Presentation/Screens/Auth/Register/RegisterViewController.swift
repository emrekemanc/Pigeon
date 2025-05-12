//
//  RegisterViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import UIKit

class RegisterViewController: UIViewController{
    private let viewModel: RegisterViewModel = RegisterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerConfiguration()
        viewModel.register(with: AuthCredentials(email: "emrekemanci@gmail.com", password: "Emre.emre23"))
    }
    
    func registerConfiguration(){
        viewModel.onSuccess = { success in
            print(success)
            
        }
        viewModel.onError = {error in
            print(error.localizedDescription)
            
        }
    }
}
