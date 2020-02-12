//
//  DetailViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var videoView: UIView!

    var viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func setupUI() {
        tableView.register(name: CellIdentifier.videoChannelCell.rawValue)
        tableView.register(name: CellIdentifier.videoDetailCell.rawValue)
        tableView.register(name: CellIdentifier.relatedVideoCell.rawValue)
        tableView.register(name: CellIdentifier.addCommentCell.rawValue)
        tableView.register(name: CellIdentifier.commentCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = DetailViewModel.SectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch type {
        case .videoDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.videoDetailCell.rawValue, for: indexPath) as? VideoDetailCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForDetailCell(at: indexPath)
            return cell
        case .videoChannel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.videoChannelCell.rawValue, for: indexPath) as? VideoChannelCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForChannelCell(at: indexPath)
            return cell
        case .relatedVideos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.relatedVideoCell.rawValue, for: indexPath) as? RelatedVideoCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForRelatedCell(at: indexPath)
        case .comment:
            guard let type = DetailViewModel.CommentSectionCellType(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            switch type {
            case .addcomment:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addCommentCell.rawValue, for: indexPath) as? AddCommentCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel.viewModelForAddComment(at: indexPath)
            case .comments:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.commentCell.rawValue, for: indexPath) as? CommentCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel.viewModelForCommentCell(at: indexPath)
            }
        }
        return UITableViewCell()
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(at: indexPath)
    }
}
