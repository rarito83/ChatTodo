//
//  NewMessageView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct NewMessageView: View {
  
  @StateObject private var viewModel = NewMessageViewModel()
  @State private var searchText = ""
  @Binding var selectUser: User?
  @Environment(\.dismiss) var dismiss
  
    var body: some View {
      NavigationStack {
        ScrollView {
          TextField("Search here...", text: $searchText)
            .frame(height: 50)
            .padding(.leading, 12)
            .background(Color(.systemGroupedBackground))
          
          Text("Contact")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
          
          ForEach(viewModel.users) { user in
            VStack {
              HStack {
                CircularImageView(user: user, size: .small)
                
                Text(user.fullName)
                  .font(.subheadline)
                  .fontWeight(.semibold)
                
                Spacer()
              }
              .padding(.leading)
              
              Divider()
                .padding(.leading, 30)
            }
            .onTapGesture {
              selectUser = user
              dismiss()
            }
          }
        }
        .navigationTitle("New Message")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
              dismiss()
            }
            .foregroundColor(.blue)
          }
        }
      }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
      NewMessageView(selectUser: .constant(User.DEFAULT))
    }
}
