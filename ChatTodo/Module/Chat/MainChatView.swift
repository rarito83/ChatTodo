//
//  MainChatView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct MainChatView: View {
  
  @StateObject var viewModel = MainChatViewModel()
  @State var newMessageView = false
  @State private var selectedUser: User?
  @State private var showChat = false
  
  private var user: User? {
    return viewModel.currentUser
  }
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          messagesView
        }
      }
      .onChange(of: selectedUser, perform: { newValue in
        showChat = newValue != nil
      })
      .navigationDestination(for: User.self, destination: { user in
        ProfileView(user: user)
      })
      .navigationDestination(isPresented: $showChat, destination: {
        if let user = selectedUser {
          ChatView(user: user)
        }
      })
      .fullScreenCover(isPresented: $newMessageView, content: {
        NewMessageView(selectUser: $selectedUser)
      })
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          NavigationLink(value: user) {
            CircularImageView(user: user, size: .small)
            
            HStack {
              Circle()
                .foregroundColor(.green)
                .frame(width: 10, height: 10)
              Text("online")
                .font(.system(size: 14))
                .foregroundColor(Color(.lightGray))
            }
          }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            newMessageView.toggle()
            selectedUser = nil
          } label: {
            Image(systemName: "square.and.pencil.circle.fill")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundStyle(.black, Color(.systemGray3))
          }
          
        }
      }
    }
  }
}

extension MainChatView {
  
  private var messagesView: some View {
    ScrollView {
      ForEach(viewModel.recentMessages) { message in
        VStack {
          HStack(spacing: 24) {
            ZStack(alignment: .bottomTrailing) {
              Image(message.user?.photoProfileUrl ?? "person.circle.fill")
                .resizable()
                .frame(width: 46, height: 46)
                .foregroundColor(.gray)
              
              Circle()
                .fill(.white)
                .frame(width: 18, height: 18)
              Circle()
                .fill(.green)
                .frame(width: 16, height: 16)
            }
            
            VStack(alignment: .leading) {
              Text(message.user?.fullName ?? "MyName")
                .font(.system(size: 16, weight: .bold))
              Text("Message sent to user")
                .font(.system(size: 14))
                .foregroundColor(Color(.lightGray))
            }
            Spacer()
            
            Text("22d")
              .font(.system(size: 14, weight: .semibold))
          }
          Divider()
            .padding(.vertical, 12)
        }
        .padding(.horizontal)
      }
    }
    .padding(.bottom, 50)
  }
}

struct MainChatView_Previews: PreviewProvider {
  static var previews: some View {
    MainChatView()
  }
}
