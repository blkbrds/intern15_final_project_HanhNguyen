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

    init(videoCategory: VideoCategory = .music) {
        self.videoCategory = videoCategory
    }

    func loadApiPopular(completion: @escaping ApiComletion) {
        let params = Api.Popular.Params(part: "snippet", chart: "mostPopular", regionCode: "VN", key: App.String.apiKey, videoCategoryId: videoCategory.id)
        Api.Popular.getPopularVideos(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let videos):
                this.videos = videos
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadImageChannel(at indexPath: IndexPath, completion: @escaping ApiComletion) {
        let params = Api.Popular.ImageChannelParmas(part: "snippet", id: videos[indexPath.row].channel.id, key: App.String.apiKey)
        Api.Popular.getImageChannel(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let channel):
                this.videos[indexPath.row].channel.imageURL = channel.imageURL
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
