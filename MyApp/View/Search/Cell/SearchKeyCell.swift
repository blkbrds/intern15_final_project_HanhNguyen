//
//  SearchKeyCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class SearchKeyCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    
    var viewModel: SearchKeyViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        self.keyLabel.text = viewModel?.key
    }
}
