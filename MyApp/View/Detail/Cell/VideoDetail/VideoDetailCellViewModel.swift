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
    
    init(tag: String, title: String, viewCount: Int, likeCount: Int, disLikeConut: Int) {
        self.title = title
        self.tag = tag
        self.viewCount = viewCount
        self.likeConut = likeCount
        self.disLikeConut = disLikeConut
    }
}
