import UIKit

let data = [1,2,3,4]
let data2 = [1.2,2.3,4.3,5.4]
let data3 = ["a","b","c","d","e"]
let data4 = ["a",1,data] as [Any]

func printAll<T>(items : [T]){
    for item in items
    {
        print(item)
    }
}

printAll(items: data4)

// optional binding
var message : String?
message = "asds"


if let messageNew = message {
    print(messageNew)
}

func test<T>(message : T?){
    guard let newMessage = message else {
        print("nil")
        return
    }
    print(newMessage)
}
test(message : 12)


//MARK: Example 2
func linearSearch<T : Comparable>(_ array: [T],searchElement : T) -> Int? {
    
    for (index,element) in array.enumerated() {
        if element == searchElement{
            return index
        }
    }
    return nil
}

print(linearSearch(data3,searchElement:  "b"))


//MARK: Example 3

struct HomeFeed : Codable{
    let videos : [video]
}
struct video : Codable {
    var id : Int
    var name : String
}
struct Course_details : Codable{
    let name : String
    let duration : String
}


func fetchHomeFeed(completion: @escaping (HomeFeed) -> () ){
    
    let urlString = "http://api.letsbuildthatapp.com/youtube/home_feed"
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!){
        (data, response, error) in
        guard let data = data else {return}
        
        do {
            let homeFeed = try JSONDecoder().decode(HomeFeed.self, from: data)
            completion(homeFeed)
            
        }catch let jsonError {
            print("Failed to decode json ", jsonError)
        }
    }.resume()
    
}
func fetchCourseDetails(completion: @escaping ([Course_details]) -> () ){
    
    let urlString = "http://api.letsbuildthatapp.com/youtube/course_detail?id=1"
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!){
        (data, response, error) in
        guard let data = data else {return}
        
        do {
            let course_Details = try JSONDecoder().decode([Course_details].self, from: data)
            completion(course_Details)
            
        }catch let jsonError {
            print("Failed to decode json ", jsonError)
        }
    }.resume()
    
}
//MARK: Generic implementation
func fetchGenericData<Generic : Decodable>(urlToFetch : String, completion : @escaping (Generic) -> ()){
    
    let urlString = urlToFetch
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with: url!){
        (data, response, error) in
        guard let data = data else {return}
        
        do {
            let genericObj = try JSONDecoder().decode(Generic.self, from: data)
            completion(genericObj)
            
        }catch let jsonError {
            print("Failed to decode json ", jsonError)
        }
    }.resume()
    
}


fetchHomeFeed{
    homeFeed in
    homeFeed.videos.forEach({print($0.name)})
}
print("Course_Detail")
fetchCourseDetails{
    course_details in
    
    for courseDetail in course_details{
        print(courseDetail.name)
    }
    
}


print("______________----------------________________");
print("_______________Use of Generic_________________");
print("______________________________________________");
fetchGenericData(urlToFetch: "http://api.letsbuildthatapp.com/youtube/home_feed"){
    (homeFeed : HomeFeed) in
    
    for video in homeFeed.videos{
        print(video.name)
    }
}

print("_______________----------------------_______________________________")



//MARK: class with generic

class Box<T:DataType>{
    
}

protocol DataProvider {
    
    func giveData<T:DataType>() -> T
}

class DataConsumer<T : DataType>{
    var data : T?
    
    
    var dataProvider : DataProvider?
    
    func getData(){
        self.data = self.dataProvider?.giveData()
    }
}

protocol DataType{
    
}
extension DataType{
    func whoAmI(){
        print(type(of: self))
    }
}

struct JSONData : DataType{
    
}
final class JSONDataProvider : DataProvider{
    func giveData<T>() -> T {
        return JSONData() as! T
    }
}

let dataConsumer = DataConsumer<JSONData>()
dataConsumer.dataProvider = JSONDataProvider()
dataConsumer.getData()
