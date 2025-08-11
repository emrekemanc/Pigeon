//
//  VerifyViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 11.08.2025.
//

import UIKit

class VerifyViewController: UIViewController{
    var verifySuccess: (() -> Void)?

    override func viewDidLoad() {
        
    }
    
    
    @IBAction func backPresButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
