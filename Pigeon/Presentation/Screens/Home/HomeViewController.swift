//
//  MainViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//


import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    public var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.handleLogout()
        }
    }

    private func handleLogout() {
        do {
            try Auth.auth().signOut()
            onLogout?()
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}
