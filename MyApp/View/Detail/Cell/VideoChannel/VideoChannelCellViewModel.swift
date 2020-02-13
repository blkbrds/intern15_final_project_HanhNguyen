//
//  VideoChannelCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class VideoChannelCellViewModel {
    var avatar: String
    var title: String
    var subscriberCount: String
    
    init(video: Video) {
        self.avatar = video.channel.imageURL
        self.title = video.channel.title
        self.subscriberCount = video.channel.subscriberCount
    }
}
