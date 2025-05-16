//
//  UserService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import FirebaseFirestore

class UserService {
    
    private let db = Firestore.firestore()
    private let collectionName = "users"
    
    func userCreate(userCredentials: UserCredentials, completion: @escaping(Result<Bool, Error>) -> Void) {
        do {
            var userToSave = userCredentials
            if userToSave.id == nil {
                userToSave.id = UUID().uuidString
            }
            userToSave.created_at = Date()
            userToSave.updated_at = Date()
            
            try db.collection(collectionName).document(userToSave.id!).setData(from: userToSave) { error in
                if let error = error {
                    completion(.failure(UserError.firestoreError(error)))
                } else {
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(UserError.unknownError))
        }
    }
    
    func userFetch(uid: String, completion: @escaping(Result<UserCredentials, Error>) -> Void) {
        let docRef = db.collection(collectionName).document(uid)
        docRef.getDocument{ snapshot, error in
            if let error = error {
                completion(.failure(UserError.firestoreError(error)))
                return
            }
            guard let snapshot = snapshot, snapshot.exists else {
                completion(.failure(UserError.userNotFound))
                return
            }
            do {
                 let user = try snapshot.data(as: UserCredentials.self)
                    completion(.success(user))
                
            } catch {
                completion(.failure(UserError.decodingError))
            }
        }
    }
    
    func userDeleted(uid: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        db.collection(collectionName).document(uid).delete { error in
            if let error = error {
                completion(.failure(UserError.firestoreError(error)))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func userUpdate(userCredentials: UserCredentials, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let uid = userCredentials.id else {
            completion(.failure(UserError.invalidUserId))
            return
        }
        var updatedUser = userCredentials
        updatedUser.updated_at = Date()
        
        do {
            try db.collection(collectionName).document(uid).setData(from: updatedUser) { error in
                if let error = error {
                    completion(.failure(UserError.firestoreError(error)))
                } else {
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(UserError.unknownError))
        }
    }
    
    
    func userSearch(uid: String, completion: @escaping(Result<[UserCredentials], Error>) -> Void) {
        db.collection(collectionName)
            .whereField("mail", isEqualTo: uid)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(UserError.firestoreError(error)))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let users: [UserCredentials] = documents.compactMap { doc in
                    try? doc.data(as: UserCredentials.self)
                }
                completion(.success(users))
            }
    }
}
