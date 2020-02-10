//
//  Video.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Video {
    var imageURL: String
    var title: String
    var channel: Channel
    var view: String
    var createdTime: Date

    init(imageURL: String, title: String, channel: Channel, view: String, createdTime: Date) {
        self.imageURL = imageURL
        self.title = title
        self.channel = channel
        self.view = view
        self.createdTime = createdTime
    }
}
