//
//  RelatedCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class RelatedCellViewModel: SearchCellViewModel {
    var imgaeURL: String
    var title: String
    var channelTitle: String
    var view: String
    var duration: String?
    
    init(video: Video) {
        imgaeURL = video.imageURL
        title = video.title
        channelTitle = video.channel?.title ?? ""
        view = video.viewCount
        duration = video.duration
    }
}
