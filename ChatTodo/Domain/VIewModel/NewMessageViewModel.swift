//
//  NewMessageViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {
  @Published var users = [User]()
  
  init() {
    Task { try await getUsers() }
  }
  
  func getUsers() async throws {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    let users = try await UserService.getAllUsers()
    self.users = users.filter({ $0.id != currentUid })
  }
}
