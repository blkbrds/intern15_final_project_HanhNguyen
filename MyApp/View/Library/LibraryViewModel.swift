//
//  LibraryViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/19/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift

protocol LibraryViewModelDelegate: class {
    func viewModel(viewModel: LibraryViewModel, needperfomAction action: LibraryViewModel.Action)
}

final class LibraryViewModel {

    enum Action {
        case reloadData
    }
    var videos: [Video] = []
    var notification: NotificationToken?
    weak var delegate: LibraryViewModelDelegate?

    func numberOfRowsInSection(at section: Int) -> Int {
        return videos.count
    }

    func loadData(completion: RealmComletion) {
        do {
            let realm = try Realm()
            let object = realm.objects(Video.self).sorted(byKeyPath: "favoriteTime", ascending: false)
            videos = Array(object)
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> RelatedCellViewModel {
        return RelatedCellViewModel(video: videos[indexPath.row])
    }

    func setupObserver() {
        do {
            let realm = try Realm()
            notification = realm.objects(Video.self).observe({ [weak self] (action)  in
                guard let this = self else { return }
                switch action {
                case .update:
                    this.delegate?.viewModel(viewModel: this, needperfomAction: .reloadData)
                default:
                break
               }
            })
        } catch { }
    }
}
