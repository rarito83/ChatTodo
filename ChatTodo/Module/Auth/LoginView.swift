//
//  LoginView.swift
//  ChatTodo
//
//  Created by Rarito on 05/09/23.
//

import SwiftUI

struct LoginView: View {
  
  @EnvironmentObject var viewModel: AuthViewModel
  @State private var email = ""
  @State private var password = ""
  
    var body: some View {
      NavigationStack {
        VStack {
          Image("swiftui")
            .opacity(0.3)
            .scaledToFit()
            .padding(.vertical, 60)
            
          InputTextFieldView(text: $email, title: "Email :", placeholder: "andra@gmail.com")
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding(.bottom)
          
          InputTextFieldView(text: $password, title: "Password :", placeholder: "123456", isSecureField: true)
          
          Spacer()
          
          Button {
            Task {
              try await viewModel.loginAcc(withEmail: email, password: password)
            }
            print("User Login with exist credentials \(email) | \(password)")
          } label: {
            VStack {
              Text("LOGIN")
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
          
          NavigationLink {
            RegisterView()
                .navigationBarBackButtonHidden(true)
          } label: {
              HStack {
                Text("Don't have an account?")
                  .foregroundColor(.gray)
                  .padding(2)
                Text("Sign Up")
                  .foregroundColor(.blue)
                  .underline(color: .blue)
                  
              }
          }
        }
        .padding()
      }
    }
}

extension LoginView: AuthValidationFormProtocol {
  
  var formValidate: Bool {
    return !email.isEmpty && !password.isEmpty
    && email.contains("@")
    && password.count > 5
  }
  
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
      LoginView()
    }
}
