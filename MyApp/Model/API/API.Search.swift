//
//  API.Search.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Search {
    struct Params {
        var part: String
        var q: String
        var key: String
        var type: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "q": q,
                "key": key,
                "type": type
            ]
        }
    }

    @discardableResult
    static func searchVideos(params: Params, completion: @escaping Completion<[Video]>) -> Request? {
        let path = Api.Path.Search.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                   guard let json = json as? JSObject, let items = json["items"] as? JSArray else {
                   completion(.failure(Api.Error.json))
                   return }
                   let videos = Mapper<Video>().mapArray(JSONArray: items)
                   completion(.success(videos))
                }
            }
        }
    }
}
