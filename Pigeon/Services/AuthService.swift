//
//  AuthService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import Foundation
import FirebaseAuth

class AuthService{
    //User Register
    func registerUser(_ registerRequestModel: RegisterRequestModel,_ completion: @escaping(Result<UserModel,Error>) -> Void ){
        Auth.auth().createUser(withEmail: registerRequestModel.mail, password: registerRequestModel.password) { result, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
        }
    }
    
    
    
}


