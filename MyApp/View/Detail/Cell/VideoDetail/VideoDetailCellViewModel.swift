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
        getTagFromDescription(description: video.description)
    }
    
    func getTagFromDescription(description: String) {
        let descriptions = description.split(separator: " ")
        var tags: [String] = []
        for item in descriptions {
            if item.contains("#") {
                tags.append(String(item))
            }
        }
        tag = tags.joined(separator: " ")
    }
}
