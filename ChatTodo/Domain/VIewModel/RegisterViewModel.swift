//
//  RegisterViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation

protocol RegisterValidationFormProtocol {
  var formValidate: Bool { get }
}

class RegisterViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var fullName = ""
  @Published var password = ""
  
  func register() async throws {
    try await AuthenticationService.shared.registerAcc(withEmail: email, fullName: fullName, password: password)
    print("DEBUG: User Register \(email) | \(fullName) | \(password)")
  }
}
