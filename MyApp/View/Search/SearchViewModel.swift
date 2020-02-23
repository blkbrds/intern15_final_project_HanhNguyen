//
//  SearchViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
final class SearchViewModel {
    enum DisplayType {
        case keyword
        case video
    }

    var displayType: DisplayType = .keyword
    var videos: [Video] = []
    var keywords: [Keyword] = []
    func numberOfRowsInSection(section: Int) -> Int {
        return videos.count
    }
    
    func loadKeywords(completion: RealmComletion) {
        do {
            let realm = try Realm()
            let objects = realm.objects(Keyword.self).sorted(byKeyPath: "searchTime", ascending: false)
            keywords = Array(objects)
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> SearchCellViewModel {
        switch displayType {
        case .keyword:
            return SearchKeyCellViewModel(key: keywords[indexPath.row].keyword)
        case .video:
            return RelatedCellViewModel(video: videos[indexPath.row])
        }
    }
}
