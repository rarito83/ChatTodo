//
//  AuthViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthValidationFormProtocol {
  var formValidate: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var userAccount: User?
  
  init() {
    self.userSession = Auth.auth().currentUser
    
    Task {
      await fetchAcc()
    }
  }
  
  func loginAcc(withEmail email: String, password: String) async throws {
    print("User Sign In..")
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchAcc()
    } catch {
      print("DEBUG: Failed user logged in with error \(error.localizedDescription)")
    }
  }
  
  func registerAcc(withEmail email: String, fullName: String, password: String) async throws {
    print("User Sign Up..")
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      let user = User(id: result.user.uid, fullName: fullName, email: email)
      let encodeUser = try Firestore.Encoder().encode(user)
      try await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
      await fetchAcc()
    } catch {
      print("Failed create account \(error.localizedDescription)")
    }
  }
  
  func fetchAcc() async {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let snapshot = try? await Firestore.firestore().collection("users")
      .document(uid).getDocument() else { return }
    
    self.userAccount = try? snapshot.data(as: User.self)
    print("DEBUG: Current user is \(String(describing: self.userAccount))")
  }
  
  func logoutAcc() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      self.userAccount = nil
    } catch {
      print("DEBUG: Error message \(error.localizedDescription)")
    }
  } 
}
