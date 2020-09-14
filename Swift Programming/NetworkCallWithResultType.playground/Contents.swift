import UIKit



enum RequestError: Error {
    case clientError
    case responseError
    case noData
    case dataDecodingError
}

class NetReader{
    
    
    let url : String
    
    init(url : String)
    {
        self.url = url
    }
    
    func read<NRM: Decodable>(resultHandler: @escaping (Result<NRM, RequestError>) -> Void) {
        
        let urlObject = URL(string: url)
        
        let urlTask = URLSession.shared.dataTask(with: urlObject!) { (data, response, error) in
            
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
            
            guard let decodedData : NRM = self.decodedData(data) else {
                resultHandler(.failure(.dataDecodingError))
                return
            }
            
            resultHandler(.success(decodedData))
        }
        
        urlTask.resume()
    }
    
    private func decodedData<NRM: Decodable>(_  data: Data) -> NRM?  {
        let nrm = try! JSONDecoder().decode(NRM.self, from: data)
        return nrm
    }
    
}




let netReader = NetReader(url: "http://cromag.stage.milezero.com/retail/api/task")

netReader.read{ (result : Result<[Task] ,RequestError>) in
    
    switch result{
        
    case .success(let tasks) :
        for task in tasks{
            print("Task ID : ",task.id)
            print("Task Name : \(task.name)")
        }
        
    case .failure(let failureValue) :
        print("Failed to fetch Task list",failureValue)
        
    }
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



