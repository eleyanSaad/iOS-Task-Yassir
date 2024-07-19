//

//  Created by Ammar AlTahhan on 01/06/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}


extension API {
    static func getCharactersApiList(pageNumber: Int,
                          completion: @escaping (_ botMessage: Characters?,_ message: String, _ error: Error?)-> Void)
    {
        let url = URL(string: URLs.getAllChharacters)!
        let headers  = API.headers()
        let para = ["page":pageNumber]
        
        Alamofire.request(url, method: .get, parameters: para, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response) in
    
            let message = getMessageFromResponse(response)
            switch response.result {
            case .failure(let err):
                
                if Connectivity.isConnectedToInternet {
                     print("Connected")
                    completion(nil,message, err)

                 } else {
                     completion(nil,"Check your Internet conection", err)

                }
                
            case .success(let value):
                let json = JSON(value)
                do {
                    let messages: Characters = try JSONDecoder()
                        .decode(Characters.self, from: try json.rawData())
                    completion(messages, message, nil)
                } catch {
                    if Connectivity.isConnectedToInternet {
                         print("Connected")
                        completion(nil, "Error, couldn't decode data", error)

                     } else {
                         print("No Internet")
                         completion(nil, "No Internet", error)

                    }
                    print("Error, couldn't decode data: \(error)")
                }
            }
        }
    }
}
