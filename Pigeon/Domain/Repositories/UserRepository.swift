//
//  UserRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

protocol UserRepository{
    func userCreate(userCredentials: UserCredentials, completion: @escaping(Result<Bool,Error>) -> Void)
    func userFetch(uid: String, completion: @escaping(Result<UserCredentials,Error>) -> Void)
    func userDeleted(uid: String, completion: @escaping(Result<Bool,Error>) -> Void)
    func userUpdate(userCredentials: UserCredentials, completion: @escaping(Result<Bool,Error>) -> Void)
    func userSearch(uid: String, completion: @escaping(Result<[UserCredentials],Error>) -> Void)
}
