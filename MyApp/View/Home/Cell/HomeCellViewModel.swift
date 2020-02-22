//
//  HomeCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class HomeCellViewModel {
    var thumbnailURL: String
    var title: String
    var channelTitle: String
    var imageChannelURL: String?
    var createdAt: Date
    var duration: String?

    init(video: Video) {
        thumbnailURL = video.imageURL
        title = video.title
        if let channelTitle = video.channel?.title {
            self.channelTitle = channelTitle
        } else {
            self.channelTitle = ""
        }
        imageChannelURL = video.channel?.imageURL
        createdAt = video.createdTime
        duration = video.duration
    }
}
