//
//  API.Detail.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/12/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Detail {
    struct CommentParams {
        var part: String
        var videoId: String
        var key: String
        var maxResults: Int
        var pageToken: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "videoId": videoId,
                "key": key,
                "maxResults": maxResults,
                "pageToken": pageToken
            ]
        }
    }

        struct Result: Mappable {
            var pageToken: String = ""
            var comments: [Comment] = []

            init?(map: Map) { }
            mutating func mapping(map: Map) {
                pageToken <- map["nextPageToken"]
                comments <- map["items"]
            }
        }

    struct VideoDetailParams {
        var part: String
        var id: String
        var key: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "id": id,
                "key": key
            ]
        }
    }

    struct RelatedVideoParams {
        var part: String
        var relatedToVideoId: String
        var type: String
        var key: String
        var maxResults: Int

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "relatedToVideoId": relatedToVideoId,
                "type": type,
                "key": key,
                "maxResults": maxResults
            ]
        }
    }

    struct VideoChannelParams {
        var part: String
        var key: String
        var id: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "id": id,
                "key": key
            ]
        }
    }

    @discardableResult
    static func getComments(params: CommentParams, completion: @escaping Completion<Result>) -> Request? {
        let path = Api.Path.Detail.comment
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let result = Mapper<Result>().map(JSON: json) else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    completion(.success(result))
                }
            }
        }
    }
    @discardableResult
    static func getVideoDetail(params: VideoDetailParams, completion: @escaping Completion<Video>) -> Request? {
        let path = Api.Path.Detail.videos
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let items = json["items"] as? JSArray, let video = Mapper<Video>().mapArray(JSONArray: items).first else {
                        completion(.failure(Api.Error.json))
                        return }
                    completion(.success(video))
                }
            }
        }
    }

    @discardableResult
    static func getRelatedVideos(params: RelatedVideoParams, completion: @escaping Completion<[Video]>) -> Request? {
        let path = Api.Path.Detail.relatedVideos
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
    static func getVideoChannel(params: VideoChannelParams, completion: @escaping Completion<Channel>) -> Request? {
        let path = Api.Path.Detail.videoChannel
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
