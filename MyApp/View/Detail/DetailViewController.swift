//
//  DetailViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import SVProgressHUD

final class DetailViewController: UIViewController {

    @IBOutlet weak var videoView: WKYTPlayerView!
    @IBOutlet weak var tableView: UITableView!

    var viewModel = DetailViewModel()
    let dispatchGroup = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        setupData()
    }

    func setupData() {
        fetchData()
    }

    func fetchData() {
        viewModel.loadApiVideoDetail { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                SVProgressHUD.show()
                this.fetchDataChannel()
                this.fetchDataRelated()
                this.fetchDataComment(isLoadMore: false)

                this.dispatchGroup.notify(queue: .main) {
                    SVProgressHUD.dismiss()
                    this.updateUI()
                }
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func fetchDataChannel() {
        dispatchGroup.enter()
        viewModel.loadApiVideoChannel { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                break
            case .failure(let error):
                this.alert(error: error)
            }
            this.dispatchGroup.leave()
        }
    }

    func fetchDataRelated() {
        dispatchGroup.enter()
        viewModel.loadApiRelatedVideo { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                break
            case .failure(let error):
                this.alert(error: error)
            }
            this.dispatchGroup.leave()
        }
    }

    func fetchDataComment(isLoadMore: Bool) {
        dispatchGroup.enter()
        viewModel.loadApiComment(isLoadMore: isLoadMore) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                if isLoadMore == true {
                    this.tableView.reloadSections(IndexSet(integer: 3), with: .none)
                } else {
                    break
                }
            case .failure(let error):
                this.alert(error: error)
            }
            this.dispatchGroup.leave()
        }
    }

    func updateUI() {
        tableView.reloadData()
        videoView.load(withVideoId: viewModel.video.id, playerVars: ["playsinline": 1])
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.videoView.playVideo()
        }
    }

    func setupNavigation() {
        configBackButton()
        configFavoriteButton(isFavorite: false)
    }

    func configBackButton() {
        let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-back"), style: .plain, target: self, action: #selector(backButtonTouchUpInside))
        backButtonItem.tintColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        navigationItem.leftBarButtonItem = backButtonItem
    }

    func configFavoriteButton(isFavorite: Bool) {
        var color: UIColor?
        if isFavorite {
            color = #colorLiteral(red: 0.9960784314, green: 0, blue: 0, alpha: 1)
        } else {
            color = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        }
        let favoriteButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-favorite"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        navigationItem.rightBarButtonItem = favoriteButtonItem
        favoriteButtonItem.tintColor = color
    }

    @objc func handleFavoriteButton() {

    }

    @objc func backButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
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
            cell.viewModel = viewModel.viewModelForDetailCell()
            return cell
        case .videoChannel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.videoChannelCell.rawValue, for: indexPath) as? VideoChannelCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForChannelCell()
            return cell
        case .relatedVideos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.relatedVideoCell.rawValue, for: indexPath) as? RelatedVideoCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.indexPath = indexPath
            cell.viewModel = viewModel.viewModelForRelatedCell(at: indexPath)
            return cell
        case .comment:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addCommentCell.rawValue, for: indexPath) as? AddCommentCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel.viewModelForAddComment(at: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.commentCell.rawValue, for: indexPath) as? CommentCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel.viewModelForCommentCell(at: indexPath)
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (tableView.cellForRow(at: indexPath) as? RelatedVideoCell) != nil else { return }
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(at: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = DetailViewModel.SectionType(rawValue: section) else { return nil }
        switch sectionType {
        case .videoChannel, .videoDetail:
            return nil
        case .relatedVideos:
            let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 18))
            let textLabel = UILabel(frame: CGRect(x: 15, y: view.frame.midY + 1, width: 200, height: 18))
            view.addSubview(textLabel)
            textLabel.text = "Tiếp Theo"
            textLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
            textLabel.font = .systemFont(ofSize: 18)
            return view
        case .comment:
            let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 18))
            let commentCountLabel = UILabel(frame: CGRect(x: 15, y: view.frame.midY + 1, width: 200, height: 18))
            view.addSubview(commentCountLabel)
            commentCountLabel.text = "Nhận xét (\(viewModel.video.commentCount))"
            commentCountLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
            commentCountLabel.font = .systemFont(ofSize: 18)
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height {
            fetchDataComment(isLoadMore: true)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height {
            fetchDataComment(isLoadMore: true)
        }
    }
}

extension DetailViewController: RelatedVideoCellDelegate {
    func cell(_ cell: RelatedVideoCell, needPerforms action: RelatedVideoCell.Action) {
        switch action {
        case .getDuration(let indexPath):
            if let indexPath = indexPath {
                viewModel.loadVideoDuration(at: indexPath) { [weak self] (result) in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        if this.tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
                            this.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    case .failure: break
                    }
                }
            }
        }
    }
}
