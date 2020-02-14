//
//  Video.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Video: Mappable {
    var id: String = ""
    var imageURL: String = ""
    var title: String = ""
    var channel: Channel = Channel()
    var related: [Video] = []
    var comment: [Comment] = []
    var createdTime: Date = Date()
    var viewCount: String = ""
    var likeCount: String = ""
    var dislikeCount: String = ""
    var description: String = ""
    var commentCount: String = ""

    init() { }

    init?(map: Map) { }

    func mapping(map: Map) {
        var tempId: String = ""
        tempId <- map["id.videoId"]
        if tempId.isEmpty {
            tempId <- map["id"]
        }
        id = tempId
        imageURL <- map["snippet.thumbnails.high.url"]
        title <- map["snippet.title"]
        createdTime <- map["snippet.publishedAt"]
        channel.id <- map["snippet.channelId"]
        channel.title <- map["snippet.channelTitle"]
        viewCount <- map["statistics.viewCount"]
        likeCount <- map["statistics.likeCount"]
        dislikeCount <- map["statistics.dislikeCount"]
        description <- map["snippet.description"]
        commentCount <- map["statistics.commentCount"]
    }
}
