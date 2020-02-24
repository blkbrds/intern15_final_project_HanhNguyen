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
        var totalResults: Int = 0
        var resultsPerPage: Int = 0

        init?(map: Map) { }
        mutating func mapping(map: Map) {
            nextPageToken <- map["nextPageToken"]
            videos <- map["items"]
            totalResults <- map["pageInfo.totalResults"]
            resultsPerPage <- map["pageInfo.resultsPerPage"]
        }
    }
    
    struct ImageChannelParams {
        var part: String
        var id: String
        var key: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "key": key,
                "id": id
            ]
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

    @discardableResult
    static func getImageChannel(params: ImageChannelParams, completion: @escaping Completion<Channel>) -> Request? {
        let path = Api.Path.Popular.imageChannel
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let items = json["items"] as? JSArray, let channel = Mapper<Channel>().mapArray(JSONArray: items).first else {
                        completion(.failure(Api.Error.json))
                        return }
                    completion(.success(channel))
                }
            }
        }
    }

    @discardableResult
    static func getVideoDuration(params: ImageChannelParams, completion: @escaping Completion<String>) -> Request? {
        let path = Api.Path.Popular.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject,
                        let items = json["items"] as? JSArray,
                        let item = items.first,
                        let contentDetails = item["contentDetails"] as? JSObject,
                        let duration = contentDetails["duration"] as? String
                        else {
                            completion(.failure(Api.Error.json))
                            return
                    }
                    completion(.success(duration))
                }
            }
        }
    }
}
