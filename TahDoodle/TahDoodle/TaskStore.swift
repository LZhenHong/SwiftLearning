//
//  TaskStore.swift
//  TahDoodle
//
//  Created by Eden on 2022/10/29.
//

import Foundation

class TaskStore: ObservableObject {
    private let fileURL: URL = {
        let fileManager = FileManager.default
        let documentDirectories = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let myDocumentDirectory = documentDirectories.first!
        let tasksFileURL = myDocumentDirectory.appendingPathComponent("tasks.json")
        print("Tasks file is \(tasksFileURL)")
        return tasksFileURL
    }()
    
    @Published private(set) var tasks: [Task] = []
    
    init() {
        loadTasks()
    }
    
    func add(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    func remove(_ task: Task) {
        guard let index = tasks.firstIndex(of: task) else {
            return
        }
        tasks.remove(at: index)
        saveTasks()
    }
    
    private func saveTasks() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)
            try data.write(to: fileURL)
            print("Saved \(tasks.count) tasks to \(fileURL.path)")
        } catch {
            print("Could not save tasks. Reason: \(error)")
        }
    }
    
    private func loadTasks() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            tasks = try decoder.decode([Task].self, from: data)
            print("Loaded \(tasks.count) tasks from \(fileURL.path)")
        } catch {
            print("Did not load any tasks. Reason: \(error)")
        }
    }
}

#if DEBUG
extension TaskStore {
    static var sample: TaskStore = {
        let tasks = [
            Task(title: "Add features"),
            Task(title: "Fix bugs"),
            Task(title: "Ship it")
        ]
        let store = TaskStore()
        store.tasks = tasks
        return store
    }()
}
#endif
