//
//  ProfileView.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import SwiftUI

struct ProfileView: View {
  
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      if let user = viewModel.userAccount {
        List {
          Section {
            HStack {
              Text(user.initial)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.gray)
                .clipShape(Circle())
              
              VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                  .fontWeight(.semibold)
                
                Text(user.email)
                  .fontWeight(.semibold)
                  .accentColor(.gray)
              }
            }
          }
          
          Section("Features") {
            Button {
              print("To do list")
            } label: {
                HStack {
                  RowSectionView(image: "gear", title: "To Do List")
                  Spacer()
                  Image(systemName: "arrowshape.right")
                    .foregroundColor(.blue)
                }
            }

            Button {
              print("Chat")
            } label: {
                HStack {
                  RowSectionView(image: "gear", title: "Chat")
                  Spacer()
                  Image(systemName: "arrowshape.right")
                    .foregroundColor(.blue)
                }
            }
          }
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundColor(.black)
          
          Section("Setting") {
            Button {
              print("Sign Out")
              viewModel.logoutAcc()
            } label: {
              HStack {
                RowSectionView(image: "gear", title: "Sign Out")
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
                  .foregroundColor(.red)
              }
            }
          }
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundColor(.black)
        }
      }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
