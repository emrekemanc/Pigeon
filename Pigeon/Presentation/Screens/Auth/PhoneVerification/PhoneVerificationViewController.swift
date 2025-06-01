//
//  PhoneVerificationViewController.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 1.06.2025.
//

import UIKit

class PhoneVerificationViewController: UIViewController{
    @IBOutlet weak var otpField1: CustomTextField!
    @IBOutlet weak var otpField2: CustomTextField!
    @IBOutlet weak var otpField3: CustomTextField!
    @IBOutlet weak var otpField4: CustomTextField!
    @IBOutlet weak var otpDeadLine: UILabel!
    @IBOutlet weak var otpVerifideButton: CustomButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func otpVerifideButtonPress(_ sender: CustomButton) {
        
    }
    
    @IBAction func cancelButtonPress(_ sender: UIButton) {
        
    }
    
    @IBAction func otpPress(_ sender: CustomTextField) {
    }
}
