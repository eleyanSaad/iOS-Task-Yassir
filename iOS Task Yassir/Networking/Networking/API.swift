
import Foundation
import SwiftyJSON
import Alamofire

enum URLs {
    static var API = "https://rickandmortyapi.com/api"
    static let getAllChharacters = API + "/character"
}


class API {
    enum Language: String { case english = "en" , arabic = "ar" }
    
    static func headers() -> [String: String] {
        var headers: [String: String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    static func getMessageFromResponse(_ response: DataResponse<Any>) -> String {
        var message = ""
        switch response.result {
        case .failure(_):
            guard let data = response.data else { break }
            message = JSON(data)["error"].stringValue
            print(message)
        case .success(let value):
            message = JSON(value)["success_message"].stringValue
        }
        return message
    }
    
    static func isUnauthenticated(_ response: DataResponse<Any>) -> Bool {
        return response.response?.statusCode == 401
    }
}
