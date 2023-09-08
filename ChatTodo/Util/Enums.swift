//
//  Enums.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import Foundation

enum Priority: String, Identifiable, CaseIterable {
  
  case low = "Low"
  case normal = "Normal"
  case high = "High"
  
  var id: UUID {
    return UUID()
  }

  var title: String {
    switch self {
      case .low:
        return "Low"
      case .normal:
        return "Normal"
      case .high:
        return "High"
    }
  }
}
