//
//  ProfileView.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
  
  @StateObject var viewModel = ProfileViewModel()
  let user: User
  @Environment(\.dismiss) var dismiss

  var body: some View {
      List {
        Section {
          HStack {
            PhotosPicker(selection: $viewModel.selectImage) {
              if let photos = viewModel.profileImage {
                photos
                  .resizable()
                  .scaledToFill()
                  .frame(width: 50, height: 50)
                  .clipShape(Circle())
              } else {
                CircularImageView(user: user, size: .large)
              }
            }

            VStack(alignment: .leading, spacing: 8) {
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
            dismiss()
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
            AuthenticationService.shared.logoutAcc()
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

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(user: User.DEFAULT)
  }
}
