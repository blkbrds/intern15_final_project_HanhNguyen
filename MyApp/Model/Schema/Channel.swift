//
//  Channel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
@objcMembers final class Channel: Object, Mappable {
    dynamic var id: String = ""
    dynamic var imageURL: String?
    dynamic var title: String = ""
    dynamic var subscriberCount: String = ""

    required init() { }

    init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["snippet.title"]
        imageURL <- map["snippet.thumbnails.high.url"]
        subscriberCount <- map["statistics.subscriberCount"]
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
