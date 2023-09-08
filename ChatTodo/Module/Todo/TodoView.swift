//
//  TodoView.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import SwiftUI

struct TodoView: View {
  
  @StateObject var realmManager = RealmManager()
  @State private var showAddTask = false
  @State private var selectedPriority = false
  
    var body: some View {
      NavigationView {
        VStack {
          Picker("Priority", selection: $selectedPriority) {
            ForEach(Priority.allCases) { priority in
              Text(priority.title).tag(priority)
            }
          }
          .pickerStyle(.segmented)
          .padding(.bottom, 12)
          
          List {
            ForEach(realmManager.tasks, id: \.id) { task in
              if !task.isInvalidated {
                TaskRow(task: task.title, completed: task.completed)
                  .onTapGesture {
                    realmManager.updateTasks(id: task.id, completed: !task.completed)
                  }
                  .swipeActions {
                    Button(role: .destructive) {
                      realmManager.deleteTask(id: task.id)
                    } label: {
                      Label("Delete", systemImage: "trash")
                    }
                  }
              }
            }
          }
          .listStyle(PlainListStyle())
          .navigationTitle("My Todo Task")
          .navigationBarItems(trailing:
                                NavigationLink("Add", destination: AddTaskView().environmentObject(realmManager))
          )
        }
        .padding()
      }
      .onAppear {
        realmManager.getTask()
      }
    }
}



struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
