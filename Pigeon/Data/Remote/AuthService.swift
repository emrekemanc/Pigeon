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
    func register(authCredentials: AuthCredentials,completion: @escaping(Result<String,Error>) -> Void){
        Auth.auth().createUser(withEmail: authCredentials.email, password: authCredentials.password ) { result, error in
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
}
