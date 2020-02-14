//
//  VideoDetailCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
final class VideoDetailCellViewModel {
    var tag: String
    var title: String
    var viewCount: Int
    var likeConut: Int
    var disLikeConut: Int

    init(video: Video) {
        self.title = video.title
        self.tag = video.description
        self.viewCount = Int(video.viewCount) ?? 0
        self.likeConut = Int(video.likeCount) ?? 0
        self.disLikeConut = Int(video.dislikeCount) ?? 0
    }
}
