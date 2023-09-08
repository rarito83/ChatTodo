//
//  UserService.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {
  
  @Published var currentUser: User?
  
  static let shared = UserService()
  
  @MainActor
  func getCurrentUser() async throws {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let snapshot =  try await Firestore.firestore().collection("users").document(uid).getDocument()
    
    let user = try snapshot.data(as: User.self)
    self.currentUser = user
    print("DEBUG: Current user is \(currentUser)")
  }
  
  static func getAllUsers() async throws -> [User] {
    let snapshot = try await Firestore.firestore().collection("users").getDocuments()
    return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
  }
  
  static func getUsers(withUid uid: String, completion: @escaping(User) -> Void) {
    FirestoreContants.UsersCollection.document(uid).getDocument { snapshot, _ in
      guard let user = try? snapshot?.data(as: User.self) else { return }
      completion(user)
    }
  }
}
