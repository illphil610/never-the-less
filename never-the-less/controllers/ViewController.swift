//
//  ViewController.swift
//  never-the-less
//
//  Created by Philip on 4/30/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = UIView()
        mainView.backgroundColor = UIColor.cyan
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let collectionView = UITableView()
        collectionView.backgroundColor = UIColor.black
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
        }
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        // Add a second document with a generated ID.
        ref = db.collection("users").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
