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
        var mine: Bool
        var key: String
        
        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "mine": mine,
                "key": key
            ]
        }
    }

//    @discardableResult
    static func getPlaylist(params: Params, completion: @escaping Completion<[Video]>) -> Request? {
        let path = Api.Path.Home.path
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
