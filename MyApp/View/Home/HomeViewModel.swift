//
//  HomeViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class HomeViewModel {

    var videos: [Video] = DummyData.fetchVideo()

    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }
}
