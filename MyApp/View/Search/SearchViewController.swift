//
//  SearchViewController.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/22/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import RealmSwift
final class SearchViewController: ViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupData() {
        super.setupData()
        viewModel.displayType = .keyword
        viewModel.loadKeywords { [weak self] (reuslt) in
            guard let this = self else { return }
            switch reuslt {
            case .success:
                this.updateUI()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    override func setupUI() {
        super.setupUI()
        tableView.register(name: CellIdentifier.relatedVideoCell.rawValue)
        tableView.register(name: CellIdentifier.searchKeyCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self

        searchBar.delegate = self
    }

    func updateUI() {
        tableView.reloadData()
    }

    private func dissmissKeyboard() {
        view.endEditing(true)
    }

    private func handleSearch() {
        guard let text = searchBar.text else { return }
        dissmissKeyboard()
        viewModel.displayType = .video
        viewModel.saveKeyword(text: text) { [weak self] (result) in
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

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellViewModel = viewModel.viewModelForCell(at: indexPath) as? SearchKeyCellViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchKeyCell.rawValue, for: indexPath) as? SearchKeyCell else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            return cell
        } else if let cellViewModel = viewModel.viewModelForCell(at: indexPath) as? RelatedCellViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.relatedVideoCell.rawValue, for: indexPath) as? RelatedVideoCell else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            return cell
        }
        return UITableViewCell()
    }
}
//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? SearchKeyCell) != nil {
            searchBar.text = viewModel.getKeyword(at: indexPath)
            handleSearch()
        } else if (tableView.cellForRow(at: indexPath) as? RelatedVideoCell) != nil {
            let vc = DetailViewController()
            vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.loadKeywords(text: searchText) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateUI()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearch()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        setupData()
    }
}
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dissmissKeyboard()
    }
}
