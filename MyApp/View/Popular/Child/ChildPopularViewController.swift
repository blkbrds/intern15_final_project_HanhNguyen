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

    var viewModel = ChildPopularViewModel() {
        didSet {
            fetchData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        tableView.register(name: CellIdentifier.homeCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupData() {
        fetchData()
    }

    func updateUI() {
        tableView.reloadData()
    }

    func fetchData() {
        viewModel.loadApiPopular { [weak self] (result) in
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
extension ChildPopularViewController: UITableViewDataSource {
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

extension ChildPopularViewController: HomeTableViewCellDelagete {
    func getImage(cell: HomeCell, needPerform action: HomeCell.Action) {
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
        }
    }
}
