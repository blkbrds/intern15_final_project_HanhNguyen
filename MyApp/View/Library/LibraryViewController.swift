//
//  LibraryViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class LibraryViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = LibraryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.setupObserver()
    }

    override func setupUI() {
        super.setupUI()
        tableView.register(name: CellIdentifier.relatedVideoCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func setupData() {
        super.setupData()
        fetchData()
    }

    func fetchData() {
        viewModel.loadData { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
}
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.relatedVideoCell.rawValue, for: indexPath) as? RelatedVideoCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}

extension LibraryViewController: LibraryViewModelDelegate {
    func viewModel(viewModel: LibraryViewModel, needperfomAction action: LibraryViewModel.Action) {
        switch action {
        case .reloadData:
            fetchData()
        }
    }
}
