//
//  ChatView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct ChatView: View {
  
  @StateObject var viewModel: ChatViewModel
  let user: User
  
  init(user: User) {
    self.user = user
    self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
  }
  
    var body: some View {
      NavigationStack {
        ScrollView {
          ForEach(viewModel.messages) { msg in
            ChatCellView(message: msg)
          }
        }
        
        Spacer()
        
        ZStack(alignment: .trailing) {
          TextField("Message text", text: $viewModel.messageText)
            .padding(12)
            .padding(.trailing, 60)
            .background(Color(.systemGroupedBackground))
            .clipShape(Capsule())
            .font(.subheadline)
          
          Button {
            viewModel.sendMessage()
            viewModel.messageText = ""
            print("Send message")
          } label: {
            Text("Send")
              .fontWeight(.semibold)
              .foregroundColor(.blue)
          }
          .padding(.horizontal, 8)

        }
        .padding()
        
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
            Text(user.fullName)
              .font(.title2)
              .fontWeight(.semibold)
              .padding(.trailing, 8)
          
            CircularImageView(user: user, size: .small)
              
        }
      }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
      ChatView(user: User.DEFAULT)
    }
}
