//
//  FirebaseManager.swift
//  never-the-less
//
//  Created by Philip on 5/4/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    func getFirestoreInstance() -> Firestore {
        return Firestore.firestore()
    }
    
    func getCollection(for collection: String) -> CollectionReference {
        return getFirestoreInstance().collection(collection)
    }
    
    func getDocuments(for collection: String, completion: @escaping (QuerySnapshot?) -> Void)  {
        getCollection(for: collection).getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot else { completion(nil); return }
            completion(snapshot)
        }
    }
    
}
