//
//  ContentView.swift
//  TahDoodle
//
//  Created by Eden on 2022/10/29.
//

import SwiftUI

struct ContentView: View {
    let taskStore: TaskStore
    
    @State private var newTaskTitle = ""
    
    private var newTaskView: some View {
        HStack {
            TextField("Something to do", text: $newTaskTitle)
            Button("Add Task") {
                let task = Task(title: newTaskTitle)
                taskStore.add(task)
                newTaskTitle = ""
            }.disabled(newTaskTitle.isEmpty)
        }.padding()
    }
    
    var body: some View {
        VStack {
            newTaskView
            TaskListView(taskStore: taskStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(taskStore: .sample)
    }
}
