//
//  MainChatViewModel.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import Foundation
import Combine
import Firebase

class MainChatViewModel: ObservableObject {

  @Published var currentUser: User?
  @Published var recentMessages = [Message]()
  private var cancellable = Set<AnyCancellable>()
  private let service = InboxService()
  
  init() {
    setupSubscribers()
    service.observeRecentMessages()
  }
  
  private func setupSubscribers() {
    UserService.shared.$currentUser.sink { [weak self] user in
      self?.currentUser = user
    }.store(in: &cancellable)
    
    service.$documentChanges.sink { [weak self] changes in
      self?.initialMessages(fromChanges: changes)
    }.store(in: &cancellable)
  }
  
  private func initialMessages(fromChanges changes: [DocumentChange]) {
    var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
    
    for i in 0 ..< messages.count {
      let message = messages[i]
      
      UserService.getUsers(withUid: message.chatPartnerId) { user in
        messages[i].user = user
        self.recentMessages.append(messages[i])
      }
    }
  }
}
