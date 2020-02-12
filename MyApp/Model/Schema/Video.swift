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

    init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        imageURL <- map["snippet.thumbnails.high.url"]
        title <- map["snippet.title"]
        createdTime <- map["snippet.publishedAt"]
        channel.id <- map["snippet.channelId"]
        channel.name <- map["snippet.channelTitle"]
    }
}
