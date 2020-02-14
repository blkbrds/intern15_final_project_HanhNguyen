//
//  CommentCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class CommentCellViewModel {
    var name: String
    var avatar: String
    var comment: String
    var publishedAt: Date
    
    init(comment: Comment) {
        self.name = comment.authorDisplayName
        self.avatar = comment.authorProfileImageUrl
        self.comment = comment.textDisplay
        self.publishedAt  = comment.publishedAt
    }
}
