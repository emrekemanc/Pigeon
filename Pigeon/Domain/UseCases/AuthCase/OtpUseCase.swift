//
//  OtpUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.06.2025.
//

class OtpUseCase {
    let repository: AuthRepository
    init(repository: AuthRepository) {
        self.repository = repository
    }

    func verify(verificationID: String, code: String, completion: @escaping (Result<Bool, Error>) -> Void){
        repository.verifyOtpCode(verificationID: verificationID, code: code, completion: completion)
    }
    func sendCode(phone: String, completion: @escaping (Result<String, Error>) -> Void){
        repository.sendOtpVerify(phone: phone, completion: completion)
        
    }
}
