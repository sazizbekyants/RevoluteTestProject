//
//  JSONDecodable.swift
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.compactMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

//func decode<T:JSONDecodable>(data: NSData) -> [T]? {
//    guard let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
//        dictionaries = JSONObject as? [JSONDictionary],
//        objects: [T] = decode(dictionaries) else {
//            return nil
//    }
//    
//    return objects
//}
