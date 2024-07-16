//

//  Created by Ammar AlTahhan on 01/06/2019.
//  Copyright © 2019 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension API {
    enum VenuesRequestType {
        case all, featured, offered, discounted
    }
    
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
                completion(nil,message, err)
                
            case .success(let value):
                let json = JSON(value)
                do {
                    let messages: Characters = try JSONDecoder()
                        .decode(Characters.self, from: try json.rawData())
                    completion(messages, message, nil)
                } catch {
                    print("Error, couldn't decode data: \(error)")
                    completion(nil, "Error, couldn't decode data", error)
                }
            }
        }
    }
}
