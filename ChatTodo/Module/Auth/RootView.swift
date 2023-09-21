//
//  RootView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct RootView: View {
  
  @StateObject var viewModel = RootViewModel()
  
  var body: some View {
    Group {
      if viewModel.userSession != nil {
        MainChatView()
      } else {
        LoginView()
      }
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
