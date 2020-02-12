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
    
    init(name: String, avatar: String, comment: String) {
        self.name = name
        self.avatar = avatar
        self.comment = comment
    }
}
