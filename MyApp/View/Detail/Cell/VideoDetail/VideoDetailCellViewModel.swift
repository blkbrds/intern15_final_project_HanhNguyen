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
    var tag: String = ""
    var title: String
    var viewCount: Int
    var likeCount: Int
    var disLikeCount: Int

    init(video: Video) {
        self.title = video.title
        self.viewCount = Int(video.viewCount) ?? 0
        self.likeCount = Int(video.likeCount) ?? 0
        self.disLikeCount = Int(video.dislikeCount) ?? 0
        getTagFromDescription(tags: video.tags)
    }

    func getTagFromDescription(tags: [String]) {
        if tags.isEmpty {
            tag = ""
        } else if tags.count == 1 {
            tag = "#\(tags[0].split(separator: " ").joined())"
        } else if tags.count == 2 {
            tag = "#\(tags[0].split(separator: " ").joined()) " + "#\(tags[1].split(separator: " ").joined())"
        } else {
            tag = "#\(tags[0].split(separator: " ").joined()) " + "#\(tags[1].split(separator: " ").joined()) " + "#\(tags[2].split(separator: " ").joined())"
        }
    }
}
