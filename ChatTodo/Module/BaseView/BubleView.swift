//
//  BubleView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct BubleView: Shape {
  
  let isFromCurrentUser: Bool
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: [
        .topLeft,
        .topRight,
        isFromCurrentUser ? .bottomLeft : .bottomRight
      ],
      cornerRadii: CGSize(width: 12, height: 12))
    
    return Path(path.cgPath)
  }
}

struct BubleView_Previews: PreviewProvider {
    static var previews: some View {
      BubleView(isFromCurrentUser: true)
    }
}
