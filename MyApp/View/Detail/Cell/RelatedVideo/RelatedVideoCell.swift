//
//  RelatedVideoCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
final class RelatedVideoCell: UITableViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    var viewModel: RelatedCellViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }
        videoImageView.setImage(url: viewModel.imgaeURL, defaultImage: #imageLiteral(resourceName: "avatar"))
        titleLabel.text = viewModel.title
        channelNameLabel.text = viewModel.channelName
    }
}
