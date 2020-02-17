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
    var nextPageToken: String = ""
    var isLoading: Bool = false

    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }

    func loadVideos(isLoadMore: Bool, completion: @escaping ApiComletion) {
        guard !isLoading else {
            completion(.failure(Api.Error.invalidRequest))
            return
        }
        isLoading = true
        let publishedAfter = Date().startOfDate().string(withFormat: App.String.dateFormatYYYYMMDDTHHmmss)
        let params = Api.Home.Params(part: "snippet", publishedAfter: publishedAfter, key: App.String.apiKey, pageToken: nextPageToken)
        Api.Home.getPlaylist(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let result):
                if isLoadMore {
                    this.videos.append(contentsOf: result.videos)
                } else {
                    this.videos = result.videos
                }
                this.nextPageToken = result.nextPageToken
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(id: videos[indexPath.row].id)
    }
}

