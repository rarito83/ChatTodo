//
//  ChatViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import Foundation

class ChatViewModel: ObservableObject {
  
  @Published var messageText = ""
  @Published var messages = [Message]()
  let service: ChatService
  
  init(user: User) {
    self.service = ChatService(chatPartner: user)
    observeMessage()
  }
  
  func sendMessage() {
    service.sendMessage(messageText)
  }
  
  func observeMessage() {
    service.observeMessages() { messages in
      self.messages.append(contentsOf: messages)
    }
  }
}
