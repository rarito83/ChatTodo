//
//  LoginViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation

protocol LoginValidationFormProtocol {
  var formValidate: Bool { get }
}

class LoginViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  
  func login() async throws {
    try await AuthenticationService.shared.loginAcc(withEmail: email, password: password)
    print("DEBUG: User Login with exist credentials \(email) | \(password)")
  }
}
