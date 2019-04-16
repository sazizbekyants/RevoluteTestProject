//
//  JSONObject.swift
//

import Foundation

struct ApiWrapper {
    let items: [Serialization]
}

extension ApiWrapper {
    private enum Keys: String, SerializationKey {
        case items
    }
    init(serialization: Serialization) {
        items = serialization.value(forKey: Keys.items) ?? []
    }
}

public protocol JSONObject {
   init?(json: Any)
}

/*
Unfortunately this is not possible:
extension Array: JSONObject where Element: JSONObject {
    init?(json: Any) {
        guard let e = json as? [Any] else {
            return nil
        }
        self = e.flatMap(Element.init)
    }
}
 */

public struct JSONArray<Element: JSONObject>: JSONObject  {
    
    public var array: [String: Any]
    public init?(json: Any) {
        let jsonSerialization = json as? Serialization
        let existingItems = jsonSerialization ?? [String: Any]()
        self.array = existingItems
    }
}
