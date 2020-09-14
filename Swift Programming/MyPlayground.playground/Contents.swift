import UIKit

var str = "Hello, playground"

print(str)

//Mark : Closures
func fetchData(completionHandler : () -> (Void)){
    print("fetching data from ")
    completionHandler()
}

func networkRequest(){
    fetchData(completionHandler: {
        print("Json data is Fetched")
    })
}

networkRequest()







