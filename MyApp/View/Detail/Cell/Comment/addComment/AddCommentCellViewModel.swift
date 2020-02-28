//
//  AddCommentCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class AddCommentCellViewModel {
    var avatar: String
    var comment: String

    init(avatar: String, comment: String) {
        self.avatar = avatar
        self.comment = comment
    }
}
