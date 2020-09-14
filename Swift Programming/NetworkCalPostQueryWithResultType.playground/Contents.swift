import UIKit

enum RequestError: Error {
    case clientError
    case responseError
    case noData
    case dataDecodingError
}

struct Task: Codable{
    var id = ""
    var name = ""
    var dependencies : [Dependencies]
    var properties : [Properties]
    
}

struct Dependencies: Codable{
    
}
struct Properties : Codable {
    
}

let task = Task(id: "123abhinav123", name: "Pickup", dependencies: [], properties: [])

 let postUrlRequest = "http://cromag.stage.milezero.com/retail/api/task"

func write<NWM:Encodable>(data : NWM,resultHandler : @escaping (Result<NWM,RequestError>) -> Void){
    var urlRequest = URLRequest(url : URL(string: postUrlRequest)!)
    
    urlRequest.httpMethod = "POST"
    
    do{
        let nwm = try JSONEncoder().encode(data)
        urlRequest.httpBody = nwm
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }catch let error{
        print("Error while posting data : \(error)")
    }
    
    let session = URLSession.shared
//    let task = session.dataTask(with: )
    
    
}
