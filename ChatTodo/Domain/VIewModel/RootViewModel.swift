//
//  RootViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Firebase
import Combine

class RootViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  private var cancellable = Set<AnyCancellable>()
  
  init() {
    self.setupUserSubsribers()
  }
  
  private func setupUserSubsribers() {
    AuthenticationService.shared.$userSession.sink { [weak self] userSessionFromAuth in
      self?.userSession = userSessionFromAuth
    }.store(in: &cancellable)
  }
}
