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
        var pageToken: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "chart": chart,
                "key": key,
                "regionCode": regionCode,
                "videoCategoryId": videoCategoryId,
                "pageToken": pageToken
            ]
        }
    }

    struct Result: Mappable {
        var nextPageToken: String = ""
        var videos: [Video] = []
        var totalResults: String = ""

        init?(map: Map) { }
        mutating func mapping(map: Map) {
            nextPageToken <- map["nextPageToken"]
            videos <- map["items"]
            totalResults <- map["pageInfo.totalResults"]
        }
    }

    @discardableResult
    static func getPopularVideos(params: Params, completion: @escaping Completion<Result>) -> Request? {
        let path = Api.Path.Popular.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let results = Mapper<Result>().map(JSON: json) else {
                        completion(.failure(Api.Error.json))
                        return }
                    completion(.success(results))
                }
            }
        }
    }
}
