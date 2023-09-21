//
//  RealmManager.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
  
  @Published private(set) var tasks: [TaskEntity] = []
  private(set) var realm: Realm?
  
  init() {
    openRealm()
//    getTask()
  }
  
  func openRealm() {
    do {
      let config = Realm.Configuration(schemaVersion: 2)
      Realm.Configuration.defaultConfiguration = config
      realm = try Realm()
    } catch {
      print("Error open realm \(error)")
    }
  }
  
  func addTask(taskTitle: String) {
    if let realm = realm {
      do {
        try realm.write {
          let newTask = TaskEntity(value: ["title": taskTitle, "completed": false])
          realm.add(newTask)
          getTask()
        }
      } catch {
        print("Error add new task \(error.localizedDescription)")
      }
    }
  }
  
  func getTask() {
    if let realm = realm {
      let allTasks = realm.objects(TaskEntity.self).sorted(byKeyPath: "completed")
      tasks = []
      allTasks.forEach { task in
        tasks.append(task)
      }
    }
  }
  
  
  func updateTasks(id: ObjectId, completed: Bool) {
    if let realm = realm {
      do {
        let updateTask = realm.objects(TaskEntity.self).filter(NSPredicate(format: "id == %@", id))
        guard !updateTask.isEmpty else { return }
        
        try realm.write {
          updateTask[0].completed = completed
          getTask()
        }
      } catch {
        print("Error add new task \(error.localizedDescription)")
      }
    }
  }
  
  func deleteTask(id: ObjectId) {
    if let realm = realm {
      do {
        let taskDelete = realm.objects(TaskEntity.self).filter(NSPredicate(format: "id == %@", id))
        guard !taskDelete.isEmpty else { return }
        
        try realm.write {
          realm.delete(taskDelete)
          getTask()
        }
      } catch {
        print("Error add new task \(error.localizedDescription)")
      }
    }
  }
}
