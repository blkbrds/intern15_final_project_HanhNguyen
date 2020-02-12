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

    var video: Video?

    func numberOfSections() -> Int {
        return SectionType.allCases.count
    }

    func numberOfItems(section: Int) -> Int {
        guard let video = video else { return 0 }
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .videoDetail, .videoChannel:
            return Config.numberOfItems
        case .relatedVideos:
            return video.related.count
        case .comment:
            return video.comment.count
        }
    }

    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return .zero }
        switch sectionType {
        case .videoDetail, .comment, .videoChannel, .relatedVideos:
            return UITableView.automaticDimension
        }
    }
    
    func viewModelForDetailCell(at indexPath: IndexPath) -> VideoDetailCellViewModel {
        return VideoDetailCellViewModel(tag: "", title: "", viewCount: 1212122, likeCount: 12112, disLikeConut: 122)
    }
    
    func viewModelForChannelCell(at indexPath: IndexPath) -> VideoChannelCellViewModel {
        return VideoChannelCellViewModel(avatar: "", channelName: "", view: "")
    }
    
    func viewModelForRelatedCell(at indexPath: IndexPath) -> RelatedCellViewModel {
        return RelatedCellViewModel(imgaeURL: "", title: "", channelName: "", view: "")
    }
    
    func viewModelForAddComment(at indexPath: IndexPath) -> AddCommentCellViewModel {
        return AddCommentCellViewModel(avatar: "", comment: "")
    }
    
    func viewModelForCommentCell(at indexPath: IndexPath) -> CommentCellViewModel {
        return CommentCellViewModel(name: "", avatar: "", comment: "")
    }
}
extension DetailViewModel {
    enum SectionType: Int, CaseIterable {
        case videoDetail
        case videoChannel
        case relatedVideos
        case comment
    }
    
    enum CommentSectionCellType: Int {
        case comments
        case addcomment
    }

    struct Config {
        static let numberOfItems: Int = 1
    }
}
