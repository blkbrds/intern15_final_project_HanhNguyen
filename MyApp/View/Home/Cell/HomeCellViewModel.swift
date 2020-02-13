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
    var channelName: String
    var imageChannelURL: String
    var createdAt: Date

    init(video: Video) {
        thumbnailURL = video.imageURL
        title = video.title
        channelName = video.channel.title
        imageChannelURL = video.channel.imageURL
        createdAt = video.createdTime
    }
}
