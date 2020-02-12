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
    struct CommentParms {
        var part: String
        var videoId: String
        var key: String

        func toJSON() -> [String: Any] {
            return [
                "part": part,
                "videoId": videoId,
                "key": key
            ]
        }
    }
    
    struct VideoDetailParms {
        var part: String
        var id: String
        var key: String

        func toJSONVideo() -> [String: Any] {
            return [
                "part": part,
                "id": id,
                "key": key
            ]
        }
    }

    @discardableResult
    static func getComments(params: CommentParms, completion: @escaping Completion<[Comment]>) -> Request? {
        let path = Api.Path.Detail.comment
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let json):
                    guard let json = json as? JSObject, let items = json["items"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return }
                    let comments = Mapper<Comment>().mapArray(JSONArray: items)
                    completion(.success(comments))
                }
            }
        }
    }

    static func getVideoDetail(params: VideoDetailParms, completion: @escaping Completion<Video>) -> Request? {
        let path = Api.Path.Detail.videos
        return api.request(method: .get, urlString: path, parameters: params.toJSONVideo()) { (result) in
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
}
