//
//  ChatService.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import Foundation
import Firebase

struct ChatService {
  
  let chatPartner: User
  
  func sendMessage(_ messageText: String) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    let chatPartnerId = chatPartner.id
    
    let currentUserRef = FirestoreContants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
    let partnerUserRef =
      FirestoreContants.MessagesCollection.document(chatPartnerId).collection(currentUid)
    let recentCurrentUserRef =
      FirestoreContants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
    let recentPartnerRef =
      FirestoreContants.MessagesCollection.document(currentUid).collection("recent-messages")
        .document(currentUid)
    
    let messageId = currentUserRef.documentID
    let message = Message(
      idMsg: messageId,
      fromId: currentUid,
      told: chatPartnerId,
      messageText: messageText,
      timestamp: Timestamp()
    )
    
    guard let messageData = try? Firestore.Encoder().encode(message) else { return }
    
    currentUserRef.setData(messageData)
    partnerUserRef.document(messageId).setData(messageData)
    
    recentCurrentUserRef.setData(messageData)
    recentPartnerRef.setData(messageData)
  }
  
  func observeMessages(completion: @escaping([Message]) -> Void) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    let chatPartnerId = chatPartner.id
    
    let query = FirestoreContants.MessagesCollection
      .document(currentUid)
      .collection(chatPartnerId)
      .order(by: "timestamp", descending: false)
    
    query.addSnapshotListener { snapshot, _ in
      guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
      var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
      
      for (index, message) in messages.enumerated() where message.fromId != currentUid {
        messages[index].user = chatPartner
      }
      
      completion(messages)
    }
  }
}
