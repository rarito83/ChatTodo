//
//  ChatTodoApp.swift
//  ChatTodo
//
//  Created by Rarito on 05/09/23.
//

import SwiftUI
import Firebase

@main
struct ChatTodoApp: App {
  
  @StateObject var viewModel = AuthViewModel()
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(viewModel)
    }
  }
}
