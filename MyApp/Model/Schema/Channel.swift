//
//  Channel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
final class Channel: Mappable {
    var id: String = ""
    var imageURL: String?
    var title: String = ""
    var subscriberCount: String = ""

    init() { }

    init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["snippet.title"]
        imageURL <- map["snippet.thumbnails.high.url"]
        subscriberCount <- map["statistics.subscriberCount"]
    }
}
