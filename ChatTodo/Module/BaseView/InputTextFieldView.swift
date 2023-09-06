//
//  InputTextFieldView.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import SwiftUI

struct InputTextFieldView: View {
  
  @Binding var text: String
  let title: String
  let placeholder: String
  var isSecureField: Bool = false
  
    var body: some View {
        VStack(alignment: .leading) {
          Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.black)
          
          if isSecureField {
            SecureField(placeholder, text: $text)
              .padding()
              .background(Color.gray.opacity(0.3))
              .cornerRadius(10)
          } else {
            TextField(placeholder, text: $text)
              .padding()
              .background(Color.gray.opacity(0.3))
              .cornerRadius(10)
          }
        }
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
      InputTextFieldView(text: .constant(""), title: "Email :", placeholder: "andra@gmail.com")
    }
}
