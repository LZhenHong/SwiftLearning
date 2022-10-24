import Cocoa

struct StackIterator<T>: IteratorProtocol {
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}

struct Stack<Element>: Sequence {
    var items: [Element] = []
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    mutating func pushAll<S: Sequence>(_ sequence: S) where S.Element == Element {
        for item in sequence {
            self.push(item)
        }
    }
    
    func map<U>(_ txform: (Element) -> U) -> Stack<U> {
        var mappedItems: [U] = []
        for item in items {
            mappedItems.append(txform(item))
        }
        return Stack<U>(items: mappedItems)
    }
    
    func filter(_ predicate: (Element) -> Bool) -> Stack<Element> {
        var filteredItems: [Element] = []
        for item in items where predicate(item) {
            filteredItems.append(item)
        }
        return Stack<Element>(items: filteredItems)
    }
    
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
}

var myStack = Stack<Int>()
myStack.push(10)
myStack.push(20)
myStack.push(30)

var myStackIterator = StackIterator(stack: myStack)
while let value = myStackIterator.next() {
    print("go \(value)")
}

for value in myStack {
    print("for-in loop: got \(value)")
}

// MARK: -

protocol Food {
    var menuListing: String { get }
}

struct Bread: Food {
    var kind = "sourdough"
    
    var menuListing: String {
        "\(kind) bread"
    }
}

func eat<T: Food>(_ food: T) {
    print("I sure love \(food.menuListing).")
}

eat(Bread())

struct Restaurant {
    struct SliceFood<Ingredient: Food>: Food {
        var food: Ingredient
        var menuListing: String {
            "a slice of \(food.menuListing)"
        }
    }
    
    struct CookedFood<Ingredient: Food>: Food {
        var food: Ingredient
        var menuListing: String {
            "\(food.menuListing), cooked to perfection"
        }
    }
    
    func makeSliecdBread() -> some Food {
        return SliceFood(food: Bread())
    }
    
    func makeToast() -> some Food {
        let slicedBread = SliceFood(food: Bread())
        return CookedFood(food: slicedBread)
    }
}

let restaurant = Restaurant()
let toast = restaurant.makeToast()
eat(toast)
