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

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "videoId": videoId,
                "key": key,
                "maxResults": maxResults
            ]
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
    static func getComments(params: CommentParams, completion: @escaping Completion<[Comment]>) -> Request? {
        let path = Api.Path.Detail.comment
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let items = json["items"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    let comments = Mapper<Comment>().mapArray(JSONArray: items)
                    completion(.success(comments))
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
    static func getVideoChannel(params: VideoChannelParams, completion: @escaping Completion<Channel?>) -> Request? {
        let path = Api.Path.Detail.videoChannel
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let items = json["items"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return }
                    let channel = Mapper<Channel>().mapArray(JSONArray: items).first 
                    completion(.success(channel))
                }
            }
        }
    }
}
