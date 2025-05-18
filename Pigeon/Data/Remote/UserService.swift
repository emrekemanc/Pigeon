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
        var updatedUser = userCredentials
        updatedUser.updated_at = Date()
        
        do {
            try db.collection(collectionName).document(uid).setData(from: updatedUser) { error in
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
    
    func userSearch(mail: String, completion: @escaping(Result<[UserCredentials], Error>) -> Void) {
        db.collection(collectionName)
            .whereField("mail", isEqualTo: mail.lowercased())
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("❌ Firestore error:", error.localizedDescription)
                    completion(.failure(error))
                    return
                }

                guard let snapshot = snapshot else {
                    print("❌ Snapshot nil ama error da nil – bu anormal bir durum.")
                    completion(.failure(UserError.userNotFound)) // örnek özel hata
                    return
                }

                let users: [UserCredentials] = snapshot.documents.compactMap { doc in
                    try? doc.data(as: UserCredentials.self)
                }

                print("✅ Bulunan kullanıcı sayısı: \(users.count)")
                completion(.success(users))
            }
    }
}
