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
            guard let uid = userCredentials.id else {
                completion(.failure(FirestoreError.invalidArgument))
                return
            }
            try db.collection(collectionName).document(uid).setData(from: userCredentials) { error in
                if let error = error {
                    completion(.failure(FirestoreError(from: error)))
                } else {
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(FirestoreError(from: error)))
        }
    }
    
    func userFetch(uid: String, completion: @escaping(Result<UserCredentials, Error>) -> Void) {
        let docRef = db.collection(collectionName).document(uid)
        docRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(FirestoreError(from: error)))
                return
            }
            guard let snapshot = snapshot, snapshot.exists else {
                completion(.failure(FirestoreError.notFound))
                return
            }
            do {
                let user = try snapshot.data(as: UserCredentials.self)
                completion(.success(user))
            } catch {
                completion(.failure(FirestoreError(from: error)))
            }
        }
    }
    
    func userDeleted(uid: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        db.collection(collectionName).document(uid).delete { error in
            if let error = error {
                completion(.failure(FirestoreError(from: error)))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func userUpdate(userCredentials: UserCredentials, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let uid = userCredentials.id else {
            completion(.failure(FirestoreError.invalidArgument))
            return
        }
        let docRef = db.collection(collectionName).document(uid)
        
        docRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(FirestoreError(from: error)))
                return
            }
            if snapshot?.exists == true {
                do {
                    try docRef.setData(from: userCredentials) { error in
                        if let error = error {
                            completion(.failure(FirestoreError(from: error)))
                        } else {
                            completion(.success(true))
                        }
                    }
                } catch {
                    completion(.failure(FirestoreError(from: error)))
                }
            } else {
                completion(.failure(FirestoreError.notFound))
            }
        }
    }
    
    func userSearch(mail: String, completion: @escaping(Result<[UserCredentials], Error>) -> Void) {
        let mailToSearch = mail.lowercased()
        
        db.collection(collectionName)
            .whereField("email", isEqualTo: mailToSearch)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(FirestoreError(from: error)))
                    return
                }

                guard let snapshot = snapshot else {
                    completion(.failure(FirestoreError.notFound))
                    return
                }

                let users: [UserCredentials] = snapshot.documents.compactMap { doc in
                    try? doc.data(as: UserCredentials.self)
                }

                completion(.success(users))
            }
    }
}
