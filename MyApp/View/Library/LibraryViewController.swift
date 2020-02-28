//
//  LibraryViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class LibraryViewController: ViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = LibraryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.setupObserver()
        setupData()
        setupUI()
    }

    override func setupUI() {
        super.setupUI()
        let barButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-trash"), style: .plain, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem = barButtonItem
        barButtonItem.tintColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)

        tableView.register(name: CellIdentifier.relatedVideoCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func setupData() {
        super.setupData()
        fetchData()
    }

    func updateUI() {
        tableView.reloadData()
    }

    @objc func deleteAll() {
        let alertButton = UIAlertAction(title: App.String.yes, style: .default) { _ in
            self.viewModel.removeAllFavoriteVideos { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success:
                    this.updateUI()
                case .failure(let error):
                    this.alert(error: error)
                }
            }
        }
        let cancelButton = UIAlertAction(title: App.String.no, style: .cancel, handler: nil)
        let alert = UIAlertController(title: App.String.warning, message: App.String.removeAll, preferredStyle: .alert)
        alert.addAction(alertButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.handleUnfavorite(at: indexPath) { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success:
                    this.updateUI()
                case .failure(let error):
                    this.alert(error: error)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "\(App.String.delete)"
    }
}
