//
//  Response.swift
//

import Foundation

public struct Response<ResponseType: JSONObject> {
    public let res: ResponseType?
    public let error: Error?
}
