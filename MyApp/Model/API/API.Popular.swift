//
//  API.Popular.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/15/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

extension Api.Popular {
    struct Params {
        var part: String
        var chart: String
        var regionCode: String
        var key: String
        var videoCategoryId: Int
        
        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "chart": chart,
                "key": key,
                "regionCode": regionCode,
                "videoCategoryId": videoCategoryId
            ]
        }
    }
    
    @discardableResult
    static func getPopularVideos(params: Params, completion: @escaping Completion<[Video]>) -> Request? {
        let path = Api.Path.Popular.path
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
