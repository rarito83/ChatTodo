//
//  AuthenticationService.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthenticationService {
  
  @Published var userSession: FirebaseAuth.User?
  
  static let shared = AuthenticationService()
  
  init() {
    self.userSession = Auth.auth().currentUser
    print("DEBUG: User Session ID is \(userSession?.uid ?? "")")
    loadCurrentUser()
  }
  
  @MainActor
  func registerAcc(withEmail email: String, fullName: String, password: String) async throws {
    print("User Sign Up..")
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      try await self.uploadUserData(email: email, fullName: fullName, id: result.user.uid)
      loadCurrentUser()
    } catch {
      print("DEBUG: Failed create account \(error.localizedDescription)")
    }
  }
  
  @MainActor
  func loginAcc(withEmail email: String, password: String) async throws {
    print("User Sign In..")
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      loadCurrentUser()
    } catch {
      print("DEBUG: Failed user logged in with error \(error.localizedDescription)")
    }
  }
  
  func logoutAcc() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      UserService.shared.currentUser = nil
    } catch {
      print("DEBUG: Error message \(error.localizedDescription)")
    }
  }
  
  private func uploadUserData(email: String, fullName: String, id: String) async throws {
    let user = User(fullName: fullName, email: email, photoProfileUrl: nil)
    guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
    try await Firestore.firestore().collection("users").document(id).setData(encodeUser)
  }
  
  private func loadCurrentUser() {
    Task { try await UserService.shared.getCurrentUser() }
  }
}
