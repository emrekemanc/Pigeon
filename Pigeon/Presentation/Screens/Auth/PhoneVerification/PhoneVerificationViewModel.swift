//
//  PhoneVerificationViewModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 1.06.2025.
//

import Foundation

class PhoneVerificationViewModel{
    private let otpUseCase: OtpUseCase = OtpUseCase(repository: AuthRepositoryImpl())
    var showError: ((Error) -> Void)?
    var sendCode: ((String) ->Void)?
    var verifySuccess: (() -> Void)?
    
    func sendVerifyCode(phone: String){
        otpUseCase.sendCode(phone: phone) { [weak self]result in
            switch result {
            case .success(let response):
                self?.sendCode?(response)
            case .failure(let error):
                self?.showError?(error)
            }
        }
    }
    func verifyMail(_ email: String){
        otpUseCase.verifyMailAdress(email) {[weak self] result in
            switch result{
            case .success(let request):
                print(result)
            case .failure(let error):
                self?.showError?(error)
            }
        }
    }
    
    func verifyCode(code: String,verificationID: String){
        otpUseCase.verify(verificationID: verificationID, code: code) {[weak self] result in
            switch result{
            case .success(let bool):
                if bool == true {
                    self?.verifySuccess?()
                }
            case .failure(let error):
                self?.showError?(error)
            }
        }
    }
    
}
