//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        static let baseURL = "https://www.googleapis.com/youtube/v3"
    }

    struct Home { }
    struct Detail { }
}

extension Api.Path {
    struct Home {
        static var path: String {
            return baseURL / "search"
        }
        
        static var videoDuration: String {
            return baseURL / "videos"
        }
    }

    struct Detail {
        static var videos: String {
            return baseURL / "videos"
        }
        static var comment: String {
            return baseURL / "commentThreads"
        }
        static var relatedVideos: String {
            return baseURL / "search"
        }
        
        static var videoChannel: String {
            return baseURL / "channels"
        }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
