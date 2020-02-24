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
        if !isLoadMore {
            nextPageToken = ""
        }
        isLoading = true
        let publishedAfter = Date().startOfDate().string(withFormat: App.String.dateFormatYYYYMMDDTHHmmss)
        let params = Api.Home.Params(part: "snippet", publishedAfter: publishedAfter, key: App.String.apiKey, pageToken: nextPageToken)
        Api.Home.getPlaylist(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return
            }
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

    func loadVideoDuration(at indexPath: IndexPath, completion: @escaping ApiComletion) {
        let params = Api.Home.DurationParams(part: "contentDetails", key: App.String.apiKey, id: videos[indexPath.row].id)
        Api.Home.getVideoDuration(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return
            }
            switch result {
            case .success(let duration):
                this.videos[indexPath.row].duration = duration
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadImageChannel(at indexPath: IndexPath, completion: @escaping ApiComletion) {
        guard let id = videos[indexPath.row].channel?.id else {
            completion(.failure(Api.Error.invalidRequest))
            return
        }
        let params = Api.Home.ChannelParams(part: "snippet", id: id, key: App.String.apiKey)
        Api.Home.getImageChannel(params: params) { [weak self] (result) in
            guard let this = self else {
                completion(.failure(Api.Error.invalidRequest))
                return }
            switch result {
            case .success(let imageChannel):
                this.videos[indexPath.row].channel?.imageURL = imageChannel.imageURL
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
