//
//  LibraryViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/19/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class LibraryViewModel {
    var video: [Video] = []
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return video.count
    }
}
