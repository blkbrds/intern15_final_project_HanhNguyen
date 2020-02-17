//
//  ChildPopularViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/15/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class ChildPopularViewModel {

    var videoCategory: VideoCategory
    var videos: [Video] = []
    var nextPageToken: String = ""
    var isLoading: Bool = false
    var page: Int = 0

    init(videoCategory: VideoCategory = .music) {
        self.videoCategory = videoCategory
    }

    func loadApiPopular(isLoadMore: Bool, completion: @escaping ApiComletion) {
        guard !isLoading else {
            completion(.failure(Api.Error.invalidRequest))
            return
        }
        isLoading = true
        let params = Api.Popular.Params(part: "snippet", chart: "mostPopular", regionCode: "VN", key: App.String.apiKey, videoCategoryId: videoCategory.id, pageToken: nextPageToken)
        Api.Popular.getPopularVideos(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let result):
                let totalPages = result.totalResults / result.resultsPerPage
                if isLoadMore {
                    if this.page < totalPages {
                        this.page += 1
                        this.videos.append(contentsOf: result.videos)
                    }
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

    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(video: videos[indexPath.row])
    }

    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(id: videos[indexPath.row].id)
    }
}
