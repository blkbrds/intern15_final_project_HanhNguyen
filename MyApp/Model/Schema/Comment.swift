//
//  Comment.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/12/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
@objcMembers final class Comment: Object, Mappable {

    dynamic var id: String = ""
    dynamic var publishedAt: Date = Date()
    dynamic var authorDisplayName: String = ""
    dynamic var authorProfileImageUrl: String = ""
    dynamic var textDisplay: String = ""

    init(map: Map) { }

    required init() {  }

    func mapping(map: Map) {
        id <- map["id"]
        publishedAt <- map["snippet.topLevelComment.snippet.publishedAt"]
        authorDisplayName <- map["snippet.topLevelComment.snippet.authorDisplayName"]
        authorProfileImageUrl <- map["snippet.topLevelComment.snippet.authorProfileImageUrl"]
        textDisplay <- map["snippet.topLevelComment.snippet.textDisplay"]
    }
}
