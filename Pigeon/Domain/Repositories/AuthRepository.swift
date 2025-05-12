//
//  AuthRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

protocol AuthRepository{
    func login(authCredentials: AuthCredentials,completion: @escaping(Result<Bool,Error>) -> Void)
    func register(authCredentials: AuthCredentials,completion: @escaping(Result<Bool,Error>) -> Void)
}
