//
//  User.swift
//  NetworkAPITextExample
//

import Foundation
struct Currency  {
    let name: String?
}
extension Currency  :JSONObject {
    init(json: Any) {
        name = (json as? [String : Any])?["USDGBP"] as? String
    }
}
