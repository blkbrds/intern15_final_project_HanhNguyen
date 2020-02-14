//
//  RelatedCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class RelatedCellViewModel {
    var imgaeURL: String
    var title: String
    var channelName: String
    var view: String
    
    init(video: Video) {
        self.imgaeURL = video.imageURL
        self.title = video.title
        self.channelName = video.channel.name
        self.view = video.viewCount
    }
}
