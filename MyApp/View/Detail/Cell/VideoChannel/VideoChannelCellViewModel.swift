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
    var channelName: String
    var view: String
    
    init(avatar: String, channelName: String, view: String) {
        self.avatar = avatar
        self.channelName = channelName
        self.view = view
    }
}
