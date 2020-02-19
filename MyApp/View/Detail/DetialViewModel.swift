//
//  DetailViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
final class DetailViewModel {

    var video: Video = Video()
    var isLoading: Bool = false
    var pageToken: String = ""

    init(id: String = "") {
        video.id = id
    }

    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }

    func loadApiComment(isLoadMore: Bool, completion: @escaping ApiComletion) {
        guard !isLoading else {
            completion(.failure(Api.Error.invalidRequest))
            return
        }
        isLoading = true
        let params = Api.Detail.CommentParams(part: "snippet", videoId: video.id, key: App.String.apiKey, maxResults: 5, pageToken: pageToken)
        Api.Detail.getComments(params: params) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let result):
                if isLoadMore {
                    this.video.comments.append(contentsOf: result.comments)
                } else {
                    this.video.comments = result.comments
                }
                this.pageToken = result.pageToken
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        isLoading = false
    }

    func loadApiVideoDetail(completion: @escaping ApiComletion) {
        let part: [String] = ["snippet", "statistics"]
        let parms = Api.Detail.VideoDetailParams(part: part.joined(separator: ","), id: video.id, key: App.String.apiKey)
        Api.Detail.getVideoDetail(params: parms) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let video):
                this.video = video
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadApiRelatedVideo(completion: @escaping ApiComletion) {
        let parms = Api.Detail.RelatedVideoParams(part: "snippet", relatedToVideoId: video.id, type: "video", key: App.String.apiKey, maxResults: 16)
        Api.Detail.getRelatedVideos(params: parms) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let videos):
                this.video.relatedVideos = videos
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadApiVideoChannel(completion: @escaping ApiComletion) {
        let part: [String] = ["snippet", "statistics"]
        let parms = Api.Detail.VideoChannelParams(part: part.joined(separator: ","), key: App.String.apiKey, id: video.channel.id)
        Api.Detail.getVideoChannel(params: parms) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let channel):
                if let channel = channel {
                    this.video.channel = channel
                }
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfItems(section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .videoDetail, .videoChannel:
            return Config.numberOfItems
        case .relatedVideos:
            return video.relatedVideos.count
        case .comment:
            return video.comments.count
        }
    }

    func heightForHeaderInSection(section: Int) -> CGFloat {
        guard let sectionType = SectionType(rawValue: section) else { return .zero }
        switch sectionType {
        case .videoDetail, .videoChannel:
            return .leastNonzeroMagnitude
        case .comment, .relatedVideos:
            return Config.heightSection
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return .zero }
        switch sectionType {
        case .videoDetail, .videoChannel, .relatedVideos, .comment:
            return UITableView.automaticDimension
        }
    }

    func viewModelForDetailCell() -> VideoDetailCellViewModel {
        return VideoDetailCellViewModel(video: video)
    }

    func viewModelForChannelCell() -> VideoChannelCellViewModel {
        return VideoChannelCellViewModel(video: video)
    }

    func viewModelForRelatedCell(at indexPath: IndexPath) -> RelatedCellViewModel {
        return RelatedCellViewModel(video: video.relatedVideos[indexPath.row])
    }

    func viewModelForAddComment(at indexPath: IndexPath) -> AddCommentCellViewModel {
        return AddCommentCellViewModel(avatar: "", comment: "")
    }

    func viewModelForCommentCell(at indexPath: IndexPath) -> CommentCellViewModel {
        return CommentCellViewModel(comment: video.comments[indexPath.row])
    }

    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(id: video.relatedVideos[indexPath.row].id)
    }
}
extension DetailViewModel {
    enum SectionType: Int, CaseIterable {
        case videoDetail
        case videoChannel
        case relatedVideos
        case comment
    }

    struct Config {
        static let numberOfItems: Int = 1
        static let heightSection: CGFloat = 40
    }
}
