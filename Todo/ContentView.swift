//
//  ContentView.swift
//  Todo
//
//  Created by Jordan Singer on 7/6/20.
//

import SwiftUI

struct Task: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var completed = false
}

struct ContentView: View {
    @State var selection: Set<Int> = [0]
    
    var body: some View {
        NavigationView {
            List(selection: self.$selection) {
                Label("Tasks", systemImage: "largecircle.fill.circle")
                    .tag(0)
                Label("Today", systemImage: "star.fill")
                Label("Upcoming", systemImage: "calendar")
                
                Divider()
                
                Label("Activity", systemImage: "clock.fill")
                Label("Trash", systemImage: "trash.fill")
                
                Divider()
                
                Label("New List", systemImage: "plus")
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            
            TasksView()
        }
    }
}

struct TasksView: View {
    @State var tasks = [
        Task(title: "Here’s to the crazy ones"),
        Task(title: "the misfits, the rebels, the troublemakers", completed: true),
        Task(title: "the round pegs in the square holes…"),
        Task(title: "the ones who see things differently — they’re not fond of rules…"),
        Task(title: "You can quote them, disagree with them, glorify or vilify them"),
        Task(title: "but the only thing you can’t do is ignore them because they change things…"),
        Task(title: "they push the human race forward", completed: true),
        Task(title: "and while some may see them as the crazy ones"),
        Task(title: "we see genius", completed: true),
        Task(title: "because the ones who are crazy enough to think that they can change the world"),
        Task(title:  "are the ones who do.")
    ]
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 12) {
                Text("Tasks")
                    .font(.headline)
                ForEach(tasks, id: \.id) { task in
                    TaskView(task: task)
                }
            }
        }
        .navigationTitle("Todo")
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: { tasks.append(Task(title: "New task")) }) {
                    Image(systemName: "plus")
                }
            }
            
        }
    }
}

struct TaskView: View {
    @State var task: Task
    
    var body: some View {
        Button(action: { task.completed.toggle() }) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Image(systemName: task.completed ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.secondary)
                Text(task.title)
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .secondary : .primary)
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
