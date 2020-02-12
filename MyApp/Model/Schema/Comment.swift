//
//  Comment.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/12/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
final class Comment: Mappable {
    var publishedAt: Date = Date()
    var authorDisplayName: String = ""
    var authorProfileImageUrl: String = ""
    var textDisplay: String = ""

    init(map: Map) { }

    func mapping(map: Map) {
        publishedAt <- map["snippet.topLevelComment.snippet.publishedAt"]
        authorDisplayName <- map["snippet.topLevelComment.snippet.authorDisplayName"]
        authorProfileImageUrl <- map["snippet.topLevelComment.snippet.authorProfileImageUrl"]
        textDisplay <- map["snippet.topLevelComment.snippet.textDisplay"]
    }
}
