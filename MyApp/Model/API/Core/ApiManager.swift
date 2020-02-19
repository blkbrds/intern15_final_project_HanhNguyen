//
//  ApiManager.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias Completion<T> = (Result<T>) -> Void
typealias ApiComletion = (APIResult) -> Void
typealias RealmComletion = (RealmResult) -> Void

enum APIResult {
    case success
    case failure(Error)
}
enum RealmResult {
    case success(Data?)
    case failure(Error)
}
let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        let headers: [String: String] = [:]
        return headers
    }
}
