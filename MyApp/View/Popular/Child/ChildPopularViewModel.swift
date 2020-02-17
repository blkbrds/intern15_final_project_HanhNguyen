//
//  ChildPopularViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/15/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class ChildPopularViewModel {
    var videos: [Video] = []
    
    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return videos.count
    }
}
