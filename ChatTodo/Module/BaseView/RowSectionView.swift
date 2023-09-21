//
//  RowSectionView.swift
//  ChatTodo
//
//  Created by Rarito on 06/09/23.
//

import SwiftUI

struct RowSectionView: View {
    
    let image: String
    let title: String
  
    var body: some View {
      HStack(spacing: 10) {
        Image(systemName: image)
          .imageScale(.small)
          .font(.title)
          .foregroundColor(.gray)
        
        Text(title)
          .font(.subheadline)
          .foregroundColor(.black)
      }
    }
}

struct RowSectionView_Previews: PreviewProvider {
    static var previews: some View {
      RowSectionView(image: "gear", title: "chat")
    }
}
