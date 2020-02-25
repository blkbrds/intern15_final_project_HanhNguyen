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
    var totalPages = 0

    init(videoCategory: VideoCategory = .music) {
        self.videoCategory = videoCategory
    }

    func loadApiPopular(isLoadMore: Bool, completion: @escaping ApiComletion) {
        guard !isLoading else {
            completion(.failure(Api.Error.invalidRequest))
            return
        }
        if !isLoadMore {
            nextPageToken = ""
        }
        isLoading = true
        let params = Api.Popular.Params(part: "snippet", chart: "mostPopular", regionCode: "VN", key: App.String.apiKeyPopular, videoCategoryId: videoCategory.id, pageToken: nextPageToken)
        Api.Popular.getPopularVideos(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return
            }
            switch result {
            case .success(let result):
                let totalPage = result.totalResults / result.resultsPerPage
                this.page += 1
                if isLoadMore {
                    this.videos.append(contentsOf: result.videos)
                } else {
                    this.videos = result.videos
                }
                this.nextPageToken = result.nextPageToken
                this.totalPages = totalPage
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadImageChannel(at indexPath: IndexPath, completion: @escaping ApiComletion) {
        guard let id = videos[indexPath.row].channel?.id else {
            completion(.failure(Api.Error.invalidRequest))
            return }
        let params = Api.Popular.ImageChannelParams(part: "snippet", id: id, key: App.String.apiKeyPopular)
        Api.Popular.getImageChannel(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let channel):
                this.videos[indexPath.row].channel?.imageURL = channel.imageURL
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadVideoDuration(at indexPath: IndexPath, completion: @escaping ApiComletion) {
        let params = Api.Popular.ImageChannelParams(part: "contentDetails", id: videos[indexPath.row].id, key: App.String.apiKeyPopular)
        Api.Popular.getVideoDuration(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let duration):
                this.videos[indexPath.row].duration = duration
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
        return DetailViewModel(video: videos[indexPath.row])
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return videos.count
    }
}
