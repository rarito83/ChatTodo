//
//  RegisterView.swift
//  ChatTodo
//
//  Created by Rarito on 05/09/23.
//

import SwiftUI

struct RegisterView: View {

  @EnvironmentObject var viewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
  
    var body: some View {
      NavigationStack {
        VStack {
          Image("swiftui")
            .opacity(0.3)
            .scaledToFit()
            .padding(.vertical, 40)
 
          InputTextFieldView(text: $email, title: "Email :", placeholder: "andra@gmail.com")
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding(.bottom)
    
          InputTextFieldView(text: $fullName, title: "Full Name :", placeholder: "Andra")
            .padding(.bottom)
          
          InputTextFieldView(text: $password, title: "Password :", placeholder: "123456", isSecureField: true)
          
          Spacer()
          
          Button {
            Task {
              try await viewModel.registerAcc(withEmail: email, fullName: fullName, password: password)
            }
            print("User Register with credentials \(email) | \(password)")
          } label: {
            VStack {
              Text("REGISTER")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding()
            }
          }
          .frame(height: 50)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .disabled(!formValidate)
          .opacity(formValidate ? 1.0 : 0.5)
          .cornerRadius(10)
          
          Spacer()
          
          Button {
            dismiss()
          } label: {
              HStack {
                Text("Have an account?")
                  .foregroundColor(.gray)
                  .padding(2)
                Text("Sign In")
                  .foregroundColor(.blue)
                  .underline(color: .blue)
                  
              }
          }
        }
        .padding()
      }
    }
}

extension RegisterView: AuthValidationFormProtocol {
  
  var formValidate: Bool {
    return !email.isEmpty && !fullName.isEmpty && !password.isEmpty
    && email.contains("@") && fullName.count > 1
    && password.count > 5
  }
  
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
      RegisterView()
    }
}
