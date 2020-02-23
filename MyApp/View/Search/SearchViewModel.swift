//
//  SearchViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class SearchViewModel {
    var videos: [Video] = []
    
    func numberOfRowsInSection(section: Int) -> Int {
        return videos.count
    }
}
