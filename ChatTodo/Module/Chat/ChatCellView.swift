//
//  ChatCellView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct ChatCellView: View {
  
  let message: Message
  
  private var isCurrentUser: Bool {
    return message.isFromCurrentUser
  }
  
    var body: some View {
      HStack {
        if isCurrentUser {
          Spacer()
          
          Text(message.messageText)
            .font(.subheadline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(BubleView(isFromCurrentUser: isCurrentUser))
            .frame(maxWidth: UIScreen.main.bounds.width / 1.2, alignment: .trailing)
          
        } else {
          HStack(alignment: .bottom, spacing: 8) {
            CircularImageView(user: User.DEFAULT, size: .small)
            
            Text(message.messageText)
              .font(.subheadline)
              .padding()
              .background(Color(.systemGray4))
              .foregroundColor(.black)
              .clipShape(BubleView(isFromCurrentUser: isCurrentUser))
              .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
            
            Spacer()
          }
        }
      }
      .padding(.horizontal, 10)
    }
}

//struct ChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//      ChatCellView(message: false)
//    }
//}
//  
