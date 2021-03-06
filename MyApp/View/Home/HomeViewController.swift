//
//  HomeViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD
final class HomeViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = HomeViewModel()
    private let tableRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        tableRefreshControl.tintColor = .black
        let tableViewAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        tableRefreshControl.attributedTitle = NSAttributedString(string: App.String.refresh, attributes: tableViewAttributes)
        tableRefreshControl.addTarget(self, action: #selector(tableViewDidScrollToTop), for: .valueChanged)
        tableView.addSubview(tableRefreshControl)

        tableView.register(name: CellIdentifier.homeCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupData() {
        super.setupData()
        fetchData(isLoadMore: false)
    }

    @objc func tableViewDidScrollToTop() {
        fetchData(isLoadMore: false)
    }

    func fetchData(isLoadMore: Bool) {
        SVProgressHUD.show()
        viewModel.loadVideos(isLoadMore: isLoadMore) { [weak self] (result) in
            SVProgressHUD.dismiss()
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateUI()
            case .failure(let error):
                this.alert(error: error)
            }
            this.viewModel.isLoading = false
        }
    }

    func fetchImageChannel(at indexPath: IndexPath) {
        viewModel.loadImageChannel(at: indexPath) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.setupUI()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func updateUI() {
        tableView.reloadData()
        tableRefreshControl.endRefreshing()
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.homeCell.rawValue, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        cell.indexPath = indexPath
        cell.delegate = self
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height {
            fetchData(isLoadMore: true)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height {
            fetchData(isLoadMore: true)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: HomeTableViewCellDelagete {
    func cell(_ cell: HomeCell, needPerformsAction action: HomeCell.Action) {
        switch action {
        case .getImageCollection(let indexPath):
            if let indexPath = indexPath {
                viewModel.loadImageChannel(at: indexPath) { [weak self] (result) in
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
