//
//  User.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import Foundation

struct User: Codable, Identifiable {
  let id: String
  let fullName: String
  let email: String
  
  var initial: String {
    let formatted = PersonNameComponentsFormatter()
    if let component = formatted.personNameComponents(from: fullName) {
      formatted.style = .abbreviated
      return formatted.string(from: component)
    }
    return ""
  }
}
