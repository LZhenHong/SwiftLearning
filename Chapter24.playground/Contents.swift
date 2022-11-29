import UIKit

class Tutorial {
    let title: String
    unowned let author: Author
    weak var editor: Editor?
    
    lazy var description: () -> String = { [weak self] in
        guard let self = self else {
            return "The tutorial is no longer available."
        }
        return "\(self.title) by \(self.author.name)"
    }
    
    init(title: String, author: Author) {
        self.title = title
        self.author = author
    }
    
    deinit {
        print("Goodbye tutorial \(title)!")
    }
}

class Editor {
    let name: String
    var tutorials: [Tutorial] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye editor \(name)!")
    }
}

class Author {
    let name: String
    var tutorials: [Tutorial] = []
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Goodbye author \(name)!")
    }
}

let tutorialDescription: () -> String
do {
    let author = Author(name: "Cosmin")
    let tutorial = Tutorial(title: "Memory management", author: author)
    tutorialDescription = tutorial.description
    author.tutorials.append(tutorial)
    
    let editor = Editor(name: "Ray")
    tutorial.editor = editor
    editor.tutorials.append(tutorial)
}
print(tutorialDescription())

final class FunctionKeeper {
    private let fn: () -> Void
    
    init(fn: @escaping () -> Void) {
        self.fn = fn
    }
    
    func run() {
        fn()
    }
}
let name = "Cosmin"
let fn = FunctionKeeper {
    print("Hello, \(name)")
}
fn.run()

var counter = 0
var g = {
    print(counter)
}
counter = 1
g()

counter = 0
g = { [counter] in
    print(counter)
}
counter = 1
g()
