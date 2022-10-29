//
//  TaskListView.swift
//  TahDoodle
//
//  Created by Eden on 2022/10/29.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskStore: TaskStore
    
    var body: some View {
        List {
            ForEach(taskStore.tasks) { task in
                TaskView(title: task.title)
                #if os(macOS)
                    .contextMenu {
                        Button("Delete") {
                            taskStore.remove(task)
                        }
                    }
                #endif
            }.onDelete { indexSet in
                indexSet.forEach { index in
                    let task = taskStore.tasks[index]
                    taskStore.remove(task)
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(taskStore: .sample)
    }
}
