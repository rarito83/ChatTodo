//
//  AddTaskView.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import SwiftUI

struct AddTaskView: View {
  
  @EnvironmentObject var realmManager: RealmManager
  @State var title = ""
  @Environment(\.dismiss) var dismiss
  
    var body: some View {
      VStack(alignment: .leading, spacing: 18) {
        Text("Create New Task")
          .font(.title2)
          .fontWeight(.semibold)
        
        TextField("Add new task here...", text: $title)
          .textFieldStyle(.roundedBorder)
        
        Spacer()
        
        Button {
          print("Add task")
          if !title.isEmpty {
            realmManager.addTask(taskTitle: title)
          }
          dismiss()
        } label: {
          VStack {
            Text("ADD TASK")
              .font(.system(size: 18, weight: .semibold))
              .foregroundColor(.white)
              .padding()
          }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
      }
      .padding(24)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
        .environmentObject(RealmManager())
    }
}
