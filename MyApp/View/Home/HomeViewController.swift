//
//  HomeViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        tableView.register(name: CellIdentifier.homeCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension HomeViewController: UITableViewDataSource {
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
