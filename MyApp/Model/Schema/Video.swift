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
    var relatedVideos: [Video] = []
    var comments: [Comment] = []
    dynamic var createdTime: Date = Date()
    var viewCount: String = ""
    var likeCount: String = ""
    var dislikeCount: String = ""
    var commentCount: String = ""
    var tags: [String] = []
    dynamic var duration: String?
    dynamic var favoriteTime: Date = Date()
    dynamic var isFavorite: Bool = false

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

     override class func ignoredProperties() -> [String] {
        return ["relatedVideos", "comments", "viewCount", "likeCount", "dislikeCount", "tags"]
    }
}
