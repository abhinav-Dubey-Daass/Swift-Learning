import UIKit



//MARK: struct with Generic Implementation
struct Queue<Element>{
    var elements: [Element] = []
    
    mutating func enqueue(newElement: Element){
        elements.append(newElement)
    }
    
    mutating func dequeue() -> Element?{
        guard !elements.isEmpty else {return nil}
        return elements.remove(at: 0)
    }
    
    func printAllElement(){
        for element in elements{
            print(element)
        }
    }
}

var ayushiContacts = Queue<String>()
ayushiContacts.enqueue(newElement: "abhinav")
ayushiContacts.enqueue(newElement: "bharat")
ayushiContacts.enqueue(newElement: "manjari")
var abhinavContact = Queue<String>()
abhinavContact.enqueue(newElement: "abhinav")
abhinavContact.enqueue(newElement: "ayushi")
abhinavContact.enqueue(newElement: "suraj")


ayushiContacts.printAllElement()
abhinavContact.printAllElement()

print("Random Queue--->")
var random = Queue<Any>()
random.enqueue(newElement: "alien")
random.enqueue(newElement: 1)
random.enqueue(newElement: 1.33)
random.printAllElement()



//func add<T>(_ a:T ,_ b:T) ->T where T : Numeric{
//    return a + b
//}
//add(3,4.2)

//MARK: protocol oriented
protocol ItemStoring {
    associatedtype DataType

    var items: [DataType] {get set}
   mutating func add(item: DataType)
}

extension ItemStoring {
    mutating func add(item: DataType) {
        items.append(item)
    }
}
struct NameDatabase: ItemStoring {
    var items = [String]()
}
var names = NameDatabase()
names.add(item: "James")
names.add(item: "Jess")
print(names)
