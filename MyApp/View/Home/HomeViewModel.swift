//
//  HomeViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
final class HomeViewModel {

    var videos: [Video] = []

    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }

    func loadVideos(completion: @escaping ApiComletion) {
        let publishedAfter = Date().startOfDate().string(withFormat: App.String.dateFormatYYYYMMDDTHHmmss)
        let params = Api.Home.Params(part: "snippet", publishedAfter: publishedAfter, key: App.String.apiKey)
        Api.Home.getPlaylist(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let videos):
                this.videos.append(contentsOf: videos)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
