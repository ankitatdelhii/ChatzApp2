//
//  CollectionReference.swift
//  ChatzApp2
//
//  Created by Ankit Saxena on 06/10/19.
//  Copyright © 2019 Ankit Saxena. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
