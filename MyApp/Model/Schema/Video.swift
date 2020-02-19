//
//  Video.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

@objcMembers final class Video: Object, Mappable {
    dynamic var id: String = ""
    dynamic var imageURL: String = ""
    dynamic var title: String = ""
    dynamic var channel: Channel?
    var relatedVideos = List<Video>()
    var comments = List<Comment>()
    dynamic var createdTime: Date = Date()
    dynamic var viewCount: String = ""
    dynamic var likeCount: String = ""
    dynamic var dislikeCount: String = ""
    dynamic var commentCount: String = ""
    var tags = List<String>()
    dynamic var duration: String?

    required init() { }

    init?(map: Map) { }

    func mapping(map: Map) {
        var tempId: String = ""
        tempId <- map["id.videoId"]
        if tempId.isEmpty {
            tempId <- map["id"]
        }
        id = tempId
        tags <- map["snippet.tags"]
        imageURL <- map["snippet.thumbnails.high.url"]
        title <- map["snippet.title"]
        createdTime <- map["snippet.publishedAt"]
        let channel = Channel()
        channel.id <- map["snippet.channelId"]
        channel.title <- map["snippet.channelTitle"]
        self.channel = channel
        viewCount <- map["statistics.viewCount"]
        likeCount <- map["statistics.likeCount"]
        dislikeCount <- map["statistics.dislikeCount"]
        commentCount <- map["statistics.commentCount"]
    }

    override static func primaryKey() -> String? {
      return "id"
    }
}
