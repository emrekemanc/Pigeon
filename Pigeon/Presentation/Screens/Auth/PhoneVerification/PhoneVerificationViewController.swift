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
    private let viewModel: PhoneVerificationViewModel = PhoneVerificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelConfigure()
       
    }
    func viewModelConfigure(){
        viewModel.sendCode = { [weak self] response in
            print(response)
        }
        viewModel.verifySuccess = {
            print("success")
        }
        viewModel.showError = {[weak self] error in
            print(error)
        }
    }
    @IBAction func otpVerifideButtonPress(_ sender: CustomButton) {
        viewModel.sendVerifyCode(phone: "+905512100162")
    }
    
    @IBAction func cancelButtonPress(_ sender: UIButton) {
        
    }
    
    @IBAction func otpPress(_ sender: CustomTextField) {
    }
}
