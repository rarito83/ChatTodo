//
//  TaskRow.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import SwiftUI

struct TaskRow: View {
  
  var task: String
  var completed: Bool
  
    var body: some View {
      HStack {
        Image(systemName: completed ? "checkmark.circle" : "circle")
        
        Text(task)
      }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
      TaskRow(task: "New Task", completed: false)
    }
}
