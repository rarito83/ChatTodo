//
//  CircularImageView.swift
//  ChatTodo
//
//  Created by Rarito on 07/09/23.
//

import SwiftUI

struct CircularImageView: View {
  
  var user: User?
  let size: ImageSize
  
    var body: some View {
      if let imageUrl = user?.photoProfileUrl {
        Image(imageUrl)
          .resizable()
          .scaledToFill()
          .frame(width: size.dimens, height: size.dimens)
          .clipShape(Circle())
      } else {
        Image(systemName: "person.circle.fill")
          .resizable()
          .scaledToFill()
          .frame(width: size.dimens, height: size.dimens)
          .clipShape(Circle())
      }
    }
}

enum ImageSize {
  case small
  case medium
  case large
  
  var dimens: CGFloat {
    switch self {
      case .small:
        return 40
      case .medium:
        return 56
      case .large:
        return 64
    }
  }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
      CircularImageView(user: User.DEFAULT, size: .medium)
    }
}
