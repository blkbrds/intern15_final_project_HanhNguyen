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

    struct ImageChannelParmas {
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

    @discardableResult
    static func getImageChannel(params: ImageChannelParmas, completion: @escaping Completion<Channel>) -> Request? {
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
}
