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
    }

    override func setupUI() {
        tableView.register(name: CellIdentifier.homeCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.homeCell.rawValue, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        return cell
    }
}
