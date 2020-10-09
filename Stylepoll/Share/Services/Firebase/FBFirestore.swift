//
//

import SwiftUI

import FirebaseFirestore

struct FBFirestore {
    
    static func retreiveProfile(uid: String, completion: @escaping (Result<Profile, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(SPKeys.CollectionPath.profiles)
            .document(uid)
        getDocument(for: reference) { (result) in
            switch result {
            case .success(let data):
                guard let profile = Profile(documentData: data) else {
                    completion(.failure(SPAuthError.noProfile))
                    return
                }
                completion(.success(profile))
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
    }
    
    static func mergeProfile(_ data: [String: Any], uid: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(SPKeys.CollectionPath.profiles)
            .document(uid)
        reference.setData(data, merge: true) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    // MARK: - fileprivate
    
    fileprivate static func getDocument(for reference: DocumentReference, completion: @escaping (Result<[String : Any], Error>) -> ()) {
        reference.getDocument { (documentSnapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documentSnapshot = documentSnapshot else {
                completion(.failure(SPAuthError.noDocumentSnapshot))
                return
            }
            guard let data = documentSnapshot.data() else {
                completion(.failure(SPAuthError.noSnapshotData))
                return
            }
            completion(.success(data))
        }
    }
}


