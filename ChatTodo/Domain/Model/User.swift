//
//  User.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
  @DocumentID var uid: String?
  let fullName: String
  let email: String
  let photoProfileUrl: String?
  
  var id: String {
    return uid ?? NSUUID().uuidString
  }
}

extension User {
  static let DEFAULT = User(fullName: "User Name", email: "default@gmail.com", photoProfileUrl: "Photo")
}
