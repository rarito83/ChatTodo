//
//  TaskEntity.swift
//  ChatTodo
//
//  Created by Rarito on 08/09/23.
//

import Foundation
import RealmSwift

class TaskEntity: Object, ObjectKeyIdentifiable {
  
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var title = ""
  @Persisted var completed = false

}
