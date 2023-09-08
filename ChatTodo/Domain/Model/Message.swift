//
//  Message.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
  @DocumentID var idMsg: String?
  let fromId: String
  let told: String
  let messageText: String
  let timestamp: Timestamp
  
  var user: User?
  
  var id: String {
    return idMsg ?? NSUUID().uuidString
  }
  
  var chatPartnerId: String {
    return fromId == Auth.auth().currentUser?.uid ? told : fromId
  }
  
  var isFromCurrentUser: Bool {
    return fromId == Auth.auth().currentUser?.uid
  }
}
