//
//  AuthService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

import FirebaseAuth

final class AuthService{
    //MARK: - Login
    func login(authCredentials: AuthCredentials,completion: @escaping(Result<Bool,Error>) -> Void){
        
        Auth.auth().signIn(withEmail: authCredentials.email.lowercased(), password: authCredentials.password ) { result, error in
            if let error = error{
                completion(.failure(AuthError(from: error)))
            }else{
                completion(.success(true))
            }
            
        }
    }
   
    //MARK: - Register
    func register(authCredentials: AuthCredentials,completion: @escaping(Result<String,Error>) -> Void){
        Auth.auth().createUser(withEmail: authCredentials.email.lowercased(), password: authCredentials.password ) { result, error in
            if let error = error {
                completion(.failure(AuthError(from: error)))
                      return
                  }
                  guard let uid = result?.user.uid else {
                      completion(.failure(AppError.auth(.userNotFound)))
                      return
                  }
            completion(.success(uid))
        }
    }
    
    //MARK: - Delete
    func delete(completion: @escaping(Result<Bool,Error>) -> Void){
        Auth.auth().currentUser?.delete {error in
            if let error = error{
                completion(.failure(AuthError(from: error)))
            }else{
                completion(.success(true))
            }

        }
    }
    //MARK: - Sign Out
    func signOut(completion: @escaping(Result<Bool,Error>) -> Void){
        do{
           try Auth.auth().signOut()
            completion(.success(true))
        }catch{
            completion(.failure(AuthError(from: error)))
        }
    }
    
    //MARK: - Fetch User ID
    func fetchUserId(completion: @escaping(Result<String,Error>) -> Void){
            guard let userId = Auth.auth().currentUser?.uid else {completion(.failure(AuthError.userNotFound)); return}
            completion(.success(userId))
           }
    
   
    
//MARK: - OTP Service
    
    func sendOtpVerify(phone: String, completion: @escaping (Result<String, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil,multiFactorSession: nil) { verificationID, error in
            if let error = error {
                completion(.failure(AuthError(from: error)))
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
                completion(.failure(AuthError(from: error)))
            } else if authResult != nil {
                completion(.success(true))
            }
        }
    }
    
    func verifyMailAdress(_ email: String, completion: @escaping (Result<Bool,Error>) -> Void){
        let actionSettings: ActionCodeSettings = ActionCodeSettings()
        actionSettings.iOSBundleID = Bundle.main.bundleIdentifier!
        actionSettings.url = URL(string:"https://pigeon-d7730.web.app/verify")
        actionSettings.handleCodeInApp = true
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionSettings) { error in
            if let error = error{
                completion(.failure(AuthError(from: error)))
            }else{
                UserDefaults.standard.set(email, forKey: "EmailForSignIn")
                completion(.success(true))
                
            }
        }
    }
    
    func handleEmailLinkSignIn(with link: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "EmailForSignIn") else {
            completion(.failure(AuthError.userNotFound))
            return
        }

        Auth.auth().signIn(withEmail: email, link: link) { authResult, error in
            if let error = error {
                completion(.failure(AuthError(from: error)))
            } else {
                completion(.success(true))
            }
        }
    }

    func isValidEmailSignInLink(_ link: String) -> Bool {
        return Auth.auth().isSignIn(withEmailLink: link)
    }

}
