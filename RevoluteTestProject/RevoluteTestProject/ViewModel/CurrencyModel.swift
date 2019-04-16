//
//  RepositoryModel.swift
//

import Foundation

struct CurrencyWithNameEndpoint: GET {
    
    typealias ResponseType = JSONArray<Currency>
    let path = "revolut-ios?"
    
    let parameter:String
    var urlParameter: [String : String] {
        return ["pairs": parameter]
    }
}
extension Client  {
    static func CurrencyAPIClient() -> Client {
        return Client(baseUrl: "https://europe-west1-revolut-230009.cloudfunctions.net")
    }
    func CurrencyWithName(param:String, completion: @escaping (Response<JSONArray<Currency>>) -> Void) {
        get(CurrencyWithNameEndpoint(parameter: param)) { response in
            completion(response)
        }
    }
}





