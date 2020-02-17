//
//  ChildPopularViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/15/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class ChildPopularViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!

    private let tableRefreshControl = UIRefreshControl()
    var viewModel = ChildPopularViewModel() {
        didSet {
            fetchData(isLoadMore: true)
        }
    }

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

    @objc func tableViewDidScrollToTop() {
        fetchData(isLoadMore: false)
    }

    override func setupData() {
        super.setupData()
        fetchData(isLoadMore: false)
    }

    func updateUI() {
        tableView.reloadData()
        tableRefreshControl.endRefreshing()
    }

    func fetchData(isLoadMore: Bool) {
        viewModel.loadApiPopular(isLoadMore: isLoadMore) { [weak self] (result) in
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
}
extension ChildPopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.homeCell.rawValue, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height && viewModel.page < viewModel.totalPages {
            viewModel.page += 1
            fetchData(isLoadMore: true)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY >= contentHeight - scrollView.frame.size.height, viewModel.page < viewModel.totalPages {
            viewModel.page += 1
            fetchData(isLoadMore: true)
        }
    }
}

extension ChildPopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}
