//
//  VideoChannelCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class VideoChannelCellViewModel {
    var avatar: String?
    var title: String
    var subscriberCount: Int

    init(video: Video) {
        if let channel = video.channel {
            avatar = channel.imageURL
            title = channel.title
            subscriberCount = Int(channel.subscriberCount) ?? 0
        } else {
            title = ""
            subscriberCount = 0
        }
    }
}
