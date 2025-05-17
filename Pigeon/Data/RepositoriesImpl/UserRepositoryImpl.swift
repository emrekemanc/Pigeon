//
//  UserRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

class UserRepositoryImpl: UserRepository{
    private var userService: UserService = UserService()
    func userCreate(userCredentials: UserCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        userService.userCreate(userCredentials: userCredentials, completion: completion)
    }
    
    func userFetch(uid: String, completion: @escaping (Result<UserCredentials, any Error>) -> Void) {
        userService.userFetch(uid: uid, completion: completion)
    }
    
    func userDeleted(uid: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        userService.userDeleted(uid: uid, completion: completion)
    }
    
    func userUpdate(userCredentials: UserCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        userService.userUpdate(userCredentials: userCredentials, completion: completion)
    }
    
    func userSearch(uid: String, completion: @escaping (Result<[UserCredentials], any Error>) -> Void) {
        userService.userSearch(uid: uid, completion: completion)
    }
    
    
}
