//
//  AuthService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

import FirebaseAuth

final class AuthService{
    func login(authCredentials: AuthCredentials,completion: @escaping(Result<Bool,Error>) -> Void){
        
        Auth.auth().signIn(withEmail: authCredentials.email, password: authCredentials.password ) { result, error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(true))
            }
            
        }
    }
    func register(authCredentials: AuthCredentials,completion: @escaping(Result<Bool,Error>) -> Void){
        Auth.auth().createUser(withEmail: authCredentials.email, password: authCredentials.password ) { result, error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(true))
            }
        }
    }
}
