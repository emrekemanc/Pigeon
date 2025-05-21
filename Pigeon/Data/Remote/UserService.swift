//
//  UserService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import FirebaseFirestore

class UserService {
    
    private let db = Firestore.firestore()
    private let collectionName = "Users"
    
    func userCreate(userCredentials: UserCredentials, completion: @escaping(Result<Bool, Error>) -> Void) {
        do {
            let userToSave = userCredentials
            guard let uid = userToSave.id else {
                       completion(.failure(UserError.invalidUserId))
                       return
                   }
            try db.collection(collectionName).document(uid).setData(from: userToSave) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func userFetch(uid: String, completion: @escaping(Result<UserCredentials, Error>) -> Void) {
        let docRef = db.collection(collectionName).document(uid)
        docRef.getDocument{ snapshot, error in
            if let error = error {
                completion(.failure(error))
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
                completion(.failure(error))
            }
        }
    }
    
    func userDeleted(uid: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        db.collection(collectionName).document(uid).delete { error in
            if let error = error {
                completion(.failure(error))
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
        let docRef = db.collection(collectionName).document(uid)
        
        docRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if snapshot?.exists == true {
                do {
                    try docRef.setData(from: userCredentials) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(true))
                        }
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(UserError.userNotFound))
            }
        }
    }
    
    func userSearch(mail: String, completion: @escaping(Result<[UserCredentials], Error>) -> Void) {
        let mailToSearch = mail.lowercased()
        
        db.collection(collectionName)
            .whereField("email", isEqualTo: mailToSearch)
            .getDocuments { snapshot, error in
                print("Searching for: \(mailToSearch)")
                
                if let error = error {
                    print("Firestore error: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                guard let snapshot = snapshot else {
                    print("No snapshot returned")
                    completion(.failure(UserError.userNotFound))
                    return
                }

                let docs = snapshot.documents.map { $0.data() }
                print("Found documents: \(docs)")
                
                let users: [UserCredentials] = snapshot.documents.compactMap { doc in
                    try? doc.data(as: UserCredentials.self)
                }

                print("Decoded users: \(users)")
                completion(.success(users))
            }
    }
}
