//
//  Constants.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import Foundation
import Firebase

struct FirestoreContants {
  
  static let UsersCollection = Firestore.firestore().collection("users")
  static let MessagesCollection = Firestore.firestore().collection("messages")
  
}
