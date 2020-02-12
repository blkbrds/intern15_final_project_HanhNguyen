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
    
    init(imgaeURL: String, title: String, channelName: String, view: String) {
        self.imgaeURL = imgaeURL
        self.title = title
        self.channelName = channelName
        self.view = view
    }
}
