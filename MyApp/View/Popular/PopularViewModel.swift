//
//  PopularViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class PopularViewModel {
    var videos: [Video] = DummyData.fetchVideo()
    
    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }
}
