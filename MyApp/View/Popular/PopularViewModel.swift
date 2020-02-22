//
//  PopularViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
enum VideoCategory: Int, CaseIterable {
    case music
    case game
    case news
    case entertainment

    var id: Int {
        switch self {
        case .music:
            return 10
        case .game:
            return 20
        case .news:
            return 2
        case .entertainment:
            return 23
        }
    }
}

final class PopularViewModel {

    var videos: [Video] = []

    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }
}
