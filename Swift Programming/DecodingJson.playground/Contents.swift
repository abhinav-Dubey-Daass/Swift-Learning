import UIKit


//decoding json 
struct customer : Codable{
    var firstName :String
    var lastName : String
    var age :Int
    
    init(from decoder : Decoder) throws{
        decoder.container(keyedBy: <#T##CodingKey.Protocol#>)
    }
}

let jsonData = """
{
"firstName" : "harshit",
"lastName" : "dubey",
"age" : 12
}
""".data(using: .utf8)

//To decode above json to particular customer structure we need Decodable
