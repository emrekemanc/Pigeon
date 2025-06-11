//
//  AuthService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

import FirebaseAuth

final class AuthService{
    func login(authCredentials: AuthCredentials,completion: @escaping(Result<Bool,Error>) -> Void){
        
        Auth.auth().signIn(withEmail: authCredentials.email.lowercased(), password: authCredentials.password ) { result, error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(true))
            }
            
        }
    }
   
    
    func register(authCredentials: AuthCredentials,completion: @escaping(Result<String,Error>) -> Void){
        Auth.auth().createUser(withEmail: authCredentials.email.lowercased(), password: authCredentials.password ) { result, error in
            if let error = error {
                completion(.failure(error))
                      return
                  }
                  guard let uid = result?.user.uid else {
                      completion(.failure(AppError.auth(.userNotFound)))
                      return
                  }
            completion(.success(uid))
        }
    }
    
    func delete(completion: @escaping(Result<Bool,Error>) -> Void){
        Auth.auth().currentUser?.delete {error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(true))
            }

        }
    }
    
    func signOut(completion: @escaping(Result<Bool,Error>) -> Void){
        do{
           try Auth.auth().signOut()
            completion(.success(true))
        }catch{
            completion(.failure(error))
        }
    }
    
    func fetchUserId(completion: @escaping(Result<String,Error>) -> Void){
            guard let userId = Auth.auth().currentUser?.uid else {completion(.failure(AuthError.userNotFound)); return}
            completion(.success(userId))
           }
    
//MARK: - OTP Service
    
    func sendOtpVerify(phone: String, completion: @escaping (Result<String, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil,multiFactorSession: nil) { verificationID, error in
            if let error = error {
                completion(.failure(error))
            } else if let verificationID = verificationID {
                completion(.success(verificationID))
            }else{
                completion(.failure(AuthError.unknown))
            }
        }
    }
    
    func verifyOtpCode(verificationID: String, code: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: code
        )
        
        Auth.auth().currentUser?.link(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(true))
            }
        }
    }

}
