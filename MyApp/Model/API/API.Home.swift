//
//  API.Home.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/8/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Home {

    struct Params {
        var part: String
        var publishedAfter: String
        var key: String
        var pageToken: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "publishedAfter": publishedAfter,
                "key": key,
                "pageToken": pageToken
            ]
        }
    }

    struct Result: Mappable {
        var nextPageToken: String = ""
        var videos: [Video] = []

        init?(map: Map) { }
        mutating func mapping(map: Map) {
            nextPageToken <- map["nextPageToken"]
            videos <- map["items"]
        }
    }

    @discardableResult
    static func getPlaylist(params: Params, completion: @escaping Completion<Result>) -> Request? {
        let path = Api.Path.Home.path 
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let result = Mapper<Result>().map(JSON: json) else {
                        completion(.failure(Api.Error.json))
                        return }
                    completion(.success(result))
                }
            }
        }
    }
}
